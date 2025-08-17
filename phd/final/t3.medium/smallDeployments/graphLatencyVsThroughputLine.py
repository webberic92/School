#!/usr/bin/env python3
import os
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import sqlite3
from matplotlib import cm
from matplotlib.colors import Normalize

# ----- Manageable output settings -----
os.makedirs("./charts", exist_ok=True)
out_path = "./charts/tps_vs_latency_line.png"

# --- DB: SQLite ---
DB_PATH = "t3m_scaling_5nodes_txpb_deployments.db"   # <- adjust if needed
conn = sqlite3.connect(DB_PATH)

# --- Load data ---
df = pd.read_sql("SELECT * FROM experiment_summary", conn)

print("📋 Loaded data (first rows preview):")
print(df[["nodes", "txpb", "protocol", "avg_tps", "latency_seconds"]].head())

# Scenario label like "5n-64tx"
df["scenario_label"] = df.apply(lambda r: f"{int(r['nodes'])}n-{int(r['txpb'])}tx", axis=1)

# Group by scenario/protocol: mean TPS & mean latency (seconds)
df_grouped = df.groupby(["scenario_label", "protocol"], as_index=False).agg(
    avg_tps=("avg_tps", "mean"),
    latency=("latency_seconds", "mean"),
)

# Extract numeric keys for sorting
df_grouped["nodes"] = df_grouped["scenario_label"].str.extract(r"^(\d+)").astype(int)
df_grouped["txpb"]  = df_grouped["scenario_label"].str.extract(r"-(\d+)tx").astype(int)
df_grouped = df_grouped.sort_values(["nodes", "txpb"])

# Pivot => rows=scenario, cols=protocol
df_pivot_tps     = df_grouped.pivot(index="scenario_label", columns="protocol", values="avg_tps")
df_pivot_latency = df_grouped.pivot(index="scenario_label", columns="protocol", values="latency")

# Ensure both protocols are present and aligned (keep NaNs; don't fill with zeros)
for p in ["MERKLE", "RSA"]:
    if p not in df_pivot_tps.columns:     df_pivot_tps[p] = np.nan
    if p not in df_pivot_latency.columns: df_pivot_latency[p] = np.nan

df_pivot_tps     = df_pivot_tps.reindex(df_grouped["scenario_label"].unique())
df_pivot_latency = df_pivot_latency.reindex(df_grouped["scenario_label"].unique())

# --- Color shading based on txpb (small=light, large=dark) ---
txpb_map = df_grouped.drop_duplicates("scenario_label").set_index("scenario_label")["txpb"].reindex(df_pivot_tps.index)
txpb_values = txpb_map.to_numpy()

# Normalize txpb; low -> light, high -> dark (non-reversed colormaps)
finite_txpb = txpb_values[np.isfinite(txpb_values)]
vmin = finite_txpb.min() if finite_txpb.size else 0
vmax = finite_txpb.max() if finite_txpb.size else 1
norm = Normalize(vmin=vmin, vmax=vmax, clip=True)
shade_param = norm(txpb_values)

blues  = cm.get_cmap("Blues")   # MERKLE markers
greens = cm.get_cmap("Greens")  # RSA markers
merkle_point_colors = [blues(s) for s in shade_param]
rsa_point_colors    = [greens(s) for s in shade_param]

# --- Prepare data arrays; treat 0 as missing so lines break instead of dropping to axis ---
def to_nan_if_zero(a):
    a = np.asarray(a, dtype=float)
    return np.where((~np.isnan(a)) & (a == 0.0), np.nan, a)

x_merkle = to_nan_if_zero(df_pivot_tps["MERKLE"].to_numpy())
y_merkle = to_nan_if_zero(df_pivot_latency["MERKLE"].to_numpy())
x_rsa    = to_nan_if_zero(df_pivot_tps["RSA"].to_numpy())
y_rsa    = to_nan_if_zero(df_pivot_latency["RSA"].to_numpy())

# --- Plot (Throughput vs Latency) ---
fig, ax = plt.subplots(figsize=(12, 8))

# Lines (break across NaNs automatically)
ax.plot(x_merkle, y_merkle, label="MERKLE", linewidth=2.0, color="tab:blue", alpha=0.9)
ax.plot(x_rsa,    y_rsa,    label="RSA",    linewidth=2.0, color="tab:green", alpha=0.9)

# Shaded markers (per-scenario intensity by txpb)
ax.scatter(x_merkle, y_merkle, s=70, color=merkle_point_colors, edgecolors="none", zorder=3)
ax.scatter(x_rsa,    y_rsa,    s=70, color=rsa_point_colors,    edgecolors="none", zorder=3)

# Label each point with its scenario
for (xm, ym, label) in zip(x_merkle, y_merkle, df_pivot_tps.index):
    if np.isfinite(xm) and np.isfinite(ym):
        ax.annotate(label, (xm, ym), textcoords="offset points", xytext=(5, 6), fontsize=8, color="tab:blue")
for (xr, yr, label) in zip(x_rsa, y_rsa, df_pivot_tps.index):
    if np.isfinite(xr) and np.isfinite(yr):
        ax.annotate(label, (xr, yr), textcoords="offset points", xytext=(5, -12), fontsize=8, color="tab:green")

# Axes & labels (flipped: TPS = X, Latency = Y)
ax.set_xlabel("Average Throughput (TPS)", fontsize=12)
ax.set_ylabel("Consensus Latency (seconds)", fontsize=12)
ax.set_title("Throughput vs Latency by Protocol (txpb shading: small=light, large=dark)", fontsize=14)
ax.legend()
ax.grid(True, linestyle="--", alpha=0.7)

plt.tight_layout()
plt.savefig(out_path, dpi=200)
print(f"✅ Saved throughput vs latency chart to '{out_path}'")
