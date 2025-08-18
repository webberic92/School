#!/usr/bin/env python3
import os
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import sqlite3

# --- DB: SQLite ---
DB_PATH = "./c5nxl_medium_deployments.db"   # <- change if your DB lives elsewhere
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

# Ensure both protocols are present and in correct order
df_pivot = df_pivot.reindex(columns=["MERKLE", "RSA"])
df_pivot = df_pivot.reindex(df_grouped["scenario_label"].unique())
df_pivot = df_pivot.fillna(0.0)

# --- Plot ---
fig, ax = plt.subplots(figsize=(12, 8))
x = np.arange(len(df_pivot.index))
bar_width = 0.35

bars_merkle = ax.bar(x - bar_width/2, df_pivot["MERKLE"], bar_width, label="MERKLE", color="blue")
bars_rsa    = ax.bar(x + bar_width/2, df_pivot["RSA"],    bar_width, label="RSA", color="lime")

# Label bars with TPS values
for bars in (bars_merkle, bars_rsa):
    for bar in bars:
        h = bar.get_height()
        ax.annotate(f'{h:.1f}',
                    xy=(bar.get_x() + bar.get_width()/2, h),
                    xytext=(0, 3), textcoords="offset points",
                    ha='center', va='bottom', fontsize=9)

# Axes and labels
ax.set_xlabel("Scenario (Nodes - Tx per Batch)", fontsize=12)
ax.set_ylabel("Average TPS", fontsize=12)
ax.set_title("Throughput (TPS) by Protocol and Scenario", fontsize=14)
ax.set_xticks(x)
ax.set_xticklabels(df_pivot.index, rotation=45)
ax.legend()

# Expand y-axis
max_y = float(df_pivot.to_numpy().max()) if len(df_pivot) else 1.0
ax.set_ylim(0, max_y * 1.2)

ax.grid(axis="y", linestyle="--", alpha=0.7)
plt.tight_layout()

os.makedirs("../charts", exist_ok=True)
out_path = "../charts/tps.png"
plt.savefig(out_path)
print(f"✅ Saved updated graph to '{out_path}'")
