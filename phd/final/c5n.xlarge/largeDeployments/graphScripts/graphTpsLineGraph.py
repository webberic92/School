#!/usr/bin/env python3
import os
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import sqlite3
from matplotlib import cm
from matplotlib.colors import Normalize
from matplotlib.cm import ScalarMappable

# ----- Manageable output settings (as requested) -----
os.makedirs("./charts", exist_ok=True)
out_path = "./charts/tps_line.png"

# --- DB: SQLite ---
DB_PATH = "c5nxl_large_deployments.db"   # <- change if your DB lives elsewhere
conn = sqlite3.connect(DB_PATH)

# --- Load data ---
df = pd.read_sql("SELECT * FROM experiment_summary", conn)

print("📋 Loaded data:")
print(df[["nodes", "txpb", "protocol", "avg_tps"]])

# Scenario label like "8n-128tx"
df["scenario_label"] = df.apply(lambda r: f"{int(r['nodes'])}n-{int(r['txpb'])}tx", axis=1)

# Group by scenario/protocol and compute mean TPS
df_grouped = df.groupby(["scenario_label", "protocol"], as_index=False)["avg_tps"].mean()

# Extract numeric keys for sorting
df_grouped["nodes"] = df_grouped["scenario_label"].str.extract(r"^(\d+)").astype(int)
df_grouped["txpb"]  = df_grouped["scenario_label"].str.extract(r"-(\d+)tx").astype(int)
df_grouped = df_grouped.sort_values(["nodes", "txpb"])

# Pivot => rows=scenario, cols=protocol
df_pivot = df_grouped.pivot(index="scenario_label", columns="protocol", values="avg_tps")

# Ensure both protocols are present and in desired order; keep NaNs (NO fill with zeros)
df_pivot = df_pivot.reindex(columns=["MERKLE", "RSA"])
df_pivot = df_pivot.reindex(df_grouped["scenario_label"].unique())

# txpb per scenario for shading
txpb_map = df_grouped.drop_duplicates("scenario_label").set_index("scenario_label")["txpb"].reindex(df_pivot.index)
txpb_values = txpb_map.to_numpy()

# --- Color shading based on txpb (small=light, large=dark) ---
# Use non-reversed colormaps so low norm -> light, high norm -> dark
if len(txpb_values) > 0:
    norm = Normalize(vmin=txpb_values.min(), vmax=txpb_values.max(), clip=True)
    shade_param = norm(txpb_values)  # 0 (light) .. 1 (dark)
else:
    shade_param = np.array([])

blues  = cm.get_cmap("Blues")   # MERKLE
greens = cm.get_cmap("Greens")  # RSA

merkle_point_colors = [blues(s) for s in shade_param]
rsa_point_colors    = [greens(s) for s in shade_param]

# --- Plot (Line Graph with shaded markers) ---
fig, ax = plt.subplots(figsize=(12, 8))
x = np.arange(len(df_pivot.index))

# Series data (keep NaNs); also treat zeros as missing to break lines
y_merkle = df_pivot["MERKLE"].to_numpy() if "MERKLE" in df_pivot.columns else np.full_like(x, np.nan, dtype=float)
y_rsa    = df_pivot["RSA"].to_numpy()    if "RSA"    in df_pivot.columns else np.full_like(x, np.nan, dtype=float)

# Convert explicit zeros to NaN so lines break instead of hitting baseline
y_merkle = np.where((~np.isnan(y_merkle)) & (y_merkle == 0.0), np.nan, y_merkle)
y_rsa    = np.where((~np.isnan(y_rsa))    & (y_rsa    == 0.0), np.nan, y_rsa)

# Plot lines; markers will carry the txpb-based shading
ax.plot(x, y_merkle, label="MERKLE", linewidth=2.0, alpha=0.9, color="tab:blue")
ax.plot(x, y_rsa,    label="RSA",    linewidth=2.0, alpha=0.9, color="tab:green")

# Shaded markers (same light/dark intensity per scenario for both protocols)
ax.scatter(x, y_merkle, s=70, marker="o", color=merkle_point_colors, edgecolors="none", zorder=3)
ax.scatter(x, y_rsa,    s=70, marker="o", color=rsa_point_colors,    edgecolors="none", zorder=3)

# Annotate points (skip NaNs)
for xi, ym, yr in zip(x, y_merkle, y_rsa):
    if not (ym is None or np.isnan(ym)):
        ax.annotate(f"{ym:.1f}", (xi, ym), textcoords="offset points", xytext=(0, 6),
                    ha="center", fontsize=8)
    if not (yr is None or np.isnan(yr)):
        ax.annotate(f"{yr:.1f}", (xi, yr), textcoords="offset points", xytext=(0, -12),
                    ha="center", fontsize=8)

# Axes and labels
ax.set_xlabel("Scenario (Nodes - Tx per Batch)", fontsize=12)
ax.set_ylabel("Average TPS", fontsize=12)
ax.set_title("Throughput (TPS) by Protocol and Scenario", fontsize=14)
ax.set_xticks(x)
ax.set_xticklabels(df_pivot.index, rotation=45, ha="right")
ax.legend()

# Expand y-axis if we have finite values
finite_vals = np.concatenate([v[np.isfinite(v)] for v in [y_merkle, y_rsa]])
if finite_vals.size > 0:
    max_y = float(np.nanmax(finite_vals))
    ax.set_ylim(0, max_y * 1.2)

ax.grid(axis="y", linestyle="--", alpha=0.7)

plt.tight_layout()

plt.savefig(out_path, dpi=200)
print(f"✅ Saved updated line graph to '{out_path}'")
