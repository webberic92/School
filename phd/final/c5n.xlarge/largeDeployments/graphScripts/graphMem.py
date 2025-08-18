#!/usr/bin/env python3
import os
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import sqlite3

# --- DB: SQLite ---
DB_PATH = "./c5nxl_large_deployments.db"   # <- change if your DB lives elsewhere
conn = sqlite3.connect(DB_PATH)

# --- Load data ---
df = pd.read_sql("SELECT * FROM experiment_summary", conn)

print("📋 Loaded data:")
print(df[["nodes", "txpb", "protocol", "avg_cpu", "avg_mem"]])

# Scenario label like "8n-128tx"
df["scenario_label"] = df.apply(lambda r: f"{int(r['nodes'])}n-{int(r['txpb'])}tx", axis=1)

# --- CPU Data ---
cpu_df = df.groupby(["scenario_label", "protocol"], as_index=False)["avg_cpu"].mean()
cpu_df["nodes"] = cpu_df["scenario_label"].str.extract(r"^(\d+)").astype(int)
cpu_df["txpb"]  = cpu_df["scenario_label"].str.extract(r"-(\d+)tx").astype(int)
cpu_df = cpu_df.sort_values(["nodes", "txpb"])
cpu_pivot = cpu_df.pivot(index="scenario_label", columns="protocol", values="avg_cpu")
cpu_pivot = cpu_pivot.reindex(columns=["MERKLE", "RSA"])
cpu_pivot = cpu_pivot.reindex(cpu_df["scenario_label"].unique()).fillna(0.0)

# --- MEM Data ---
mem_df = df.groupby(["scenario_label", "protocol"], as_index=False)["avg_mem"].mean()
mem_df["nodes"] = mem_df["scenario_label"].str.extract(r"^(\d+)").astype(int)
mem_df["txpb"]  = mem_df["scenario_label"].str.extract(r"-(\d+)tx").astype(int)
mem_df = mem_df.sort_values(["nodes", "txpb"])
mem_pivot = mem_df.pivot(index="scenario_label", columns="protocol", values="avg_mem")
mem_pivot = mem_pivot.reindex(columns=["MERKLE", "RSA"])
mem_pivot = mem_pivot.reindex(mem_df["scenario_label"].unique()).fillna(0.0)

# --- Plot ---
fig, axes = plt.subplots(1, 2, figsize=(16, 7))
bar_width = 0.35

# --- CPU subplot ---
x_cpu = np.arange(len(cpu_pivot.index))
bars_merkle_cpu = axes[0].bar(x_cpu - bar_width/2, cpu_pivot["MERKLE"], bar_width, label="MERKLE", color="blue")
bars_rsa_cpu    = axes[0].bar(x_cpu + bar_width/2, cpu_pivot["RSA"],    bar_width, label="RSA", color="lime")

axes[0].set_title("Average CPU Usage (%)")
axes[0].set_xlabel("Scenario (Nodes - Tx per Batch)")
axes[0].set_ylabel("CPU Usage (%)")
axes[0].set_xticks(x_cpu)
axes[0].set_xticklabels(cpu_pivot.index, rotation=45)
for bars in (bars_merkle_cpu, bars_rsa_cpu):
    for bar in bars:
        h = bar.get_height()
        axes[0].annotate(f'{h:.1f}', xy=(bar.get_x() + bar.get_width()/2, h),
                         xytext=(0, 3), textcoords="offset points",
                         ha='center', va='bottom', fontsize=8)
axes[0].legend()
axes[0].grid(axis="y", linestyle="--", alpha=0.7)

# --- MEM subplot ---
x_mem = np.arange(len(mem_pivot.index))
bars_merkle_mem = axes[1].bar(x_mem - bar_width/2, mem_pivot["MERKLE"], bar_width, label="MERKLE", color="blue")
bars_rsa_mem    = axes[1].bar(x_mem + bar_width/2, mem_pivot["RSA"],    bar_width, label="RSA", color="lime")

axes[1].set_title("Average Memory Usage (GB)")
axes[1].set_xlabel("Scenario (Nodes - Tx per Batch)")
axes[1].set_ylabel("Memory Usage (GB)")
axes[1].set_xticks(x_mem)
axes[1].set_xticklabels(mem_pivot.index, rotation=45)
for bars in (bars_merkle_mem, bars_rsa_mem):
    for bar in bars:
        h = bar.get_height()
        axes[1].annotate(f'{h:.2f}', xy=(bar.get_x() + bar.get_width()/2, h),
                         xytext=(0, 3), textcoords="offset points",
                         ha='center', va='bottom', fontsize=8)
axes[1].legend()
axes[1].grid(axis="y", linestyle="--", alpha=0.7)

plt.suptitle("Resource Utilization by Protocol and Scenario", fontsize=16)
plt.tight_layout(rect=[0, 0, 1, 0.95])

os.makedirs("../charts", exist_ok=True)
out_path = "../charts/resource_utilization_chart.png"
plt.savefig(out_path)
print(f"✅ Saved chart to '{out_path}'")
