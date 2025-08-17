#!/usr/bin/env python3
import os
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import sqlite3
from matplotlib import cm
from matplotlib.colors import Normalize

# --- DB: SQLite ---
DB_PATH = "./t3medium_small_deployments.db"   # <- change if your DB lives elsewhere
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

# Ensure both protocols are present and in desired order
df_pivot = df_pivot.reindex(columns=["MERKLE", "RSA"])
df_pivot = df_pivot.reindex(df_grouped["scenario_label"].unique())
df_pivot = df_pivot.fillna(0.0)

# Bring along txpb per scenario for shading logic
txpb_map = df_grouped.drop_duplicates("scenario_label").set_index("scenario_label")["txpb"].reindex(df_pivot.index)
txpb_values = txpb_map.to_numpy()

# --- Color shading based on txpb ---
# Lower txpb -> darker; Higher txpb -> lighter
# Normalize txpb into [0,1], then invert so min txpb = 1 (dark end of colormap_r)
if len(txpb_values) > 0:
    norm = Normalize(vmin=txpb_values.min(), vmax=txpb_values.max(), clip=True)
    shade_param = 1.0 - norm(txpb_values)  # 0 (light) .. 1 (dark), inverted so low txpb -> dark
else:
    shade_param = np.array([])

# Choose colormaps: reverse so shade_param=1 gives darkest
blues = cm.get_cmap("Blues_r")
greens = cm.get_cmap("Greens_r")

merkle_point_colors = [blues(s) for s in shade_param]
rsa_point_colors    = [greens(s) for s in shade_param]

# --- Plot (Line Graph with shaded markers) ---
fig, ax = plt.subplots(figsize=(12, 8))
x = np.arange(len(df_pivot.index))

# Series data
y_merkle = df_pivot["MERKLE"].to_numpy() if "MERKLE" in df_pivot.columns else np.zeros_like(x, dtype=float)
y_rsa    = df_pivot["RSA"].to_numpy()    if "RSA"    in df_pivot.columns else np.zeros_like(x, dtype=float)

# Base lines per protocol (neutral-ish line color), markers carry the shade by txpb
line_merkle, = ax.plot(x, y_merkle, label="MERKLE", linewidth=2.0, alpha=0.8, color="tab:blue")
line_rsa,    = ax.plot(x, y_rsa,    label="RSA",    linewidth=2.0, alpha=0.8, color="tab:green")

# Shaded markers per point (same light/dark intensity for the pair at each scenario)
ax.scatter(x, y_merkle, s=70, marker="o", color=merkle_point_colors, edgecolors="none", zorder=3)
ax.scatter(x, y_rsa,    s=70, marker="o", color=rsa_point_colors,    edgecolors="none", zorder=3)

# Optional: label a few points with TPS
for xi, ym, yr in zip(x, y_merkle, y_rsa):
    if not np.isnan(ym):
        ax.annotate(f"{ym:.1f}", (xi, ym), textcoords="offset points", xytext=(0, 6),
                    ha="center", fontsize=8)
    if not np.isnan(yr):
        ax.annotate(f"{yr:.1f}", (xi, yr), textcoords="offset points", xytext=(0, -12),
                    ha="center", fontsize=8)

# Axes and labels
ax.set_xlabel("Scenario (Nodes - Tx per Batch)", fontsize=12)
ax.set_ylabel("Average TPS", fontsize=12)
ax.set_title("Throughput (TPS) by Protocol and Scenario — Line Graph with txpb-based Shading", fontsize=14)
ax.set_xticks(x)
ax.set_xticklabels(df_pivot.index, rotation=45, ha="right")
ax.legend()

# Expand y-axis
max_y = float(df_pivot.to_numpy().max()) if len(df_pivot) else 1.0
ax.set_ylim(0, max_y * 1.2)

ax.grid(axis="y", linestyle="--", alpha=0.7)

# Add a colorbar to show how shading maps to txpb
# We build a scalar mappable using the same colormap scale (for display only)
from matplotlib.cm import ScalarMappable
sm = ScalarMappable(cmap=cm.get_cmap("Greens_r"), norm=Normalize(vmin=txpb_values.min() if len(txpb_values) else 0,
                                                                 vmax=txpb_values.max() if len(txpb_values) else 1))
sm.set_array([])
cbar = plt.colorbar(sm, ax=ax, pad=0.015)
cbar.set_label("txpb (lower = darker shade)", rotation=90)

plt.tight_layout()

os.makedirs("../charts", exist_ok=True)
out_path = "../charts/tps_line.png"
plt.savefig(out_path, dpi=200)
print(f"✅ Saved updated line graph to '{out_path}'")
