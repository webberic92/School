import pandas as pd
import matplotlib.pyplot as plt
from sqlalchemy import create_engine
import numpy as np

# Connect to the database
user = "webby"
password = "root"
host = "localhost"
port = "5432"
database = "aleph_results"
engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{database}')

# Load the data
df = pd.read_sql("SELECT * FROM experiment_summary", engine)

# Preview
print("📋 Loaded data:")
print(df[["nodes", "txpb", "protocol", "avg_cpu", "avg_mem"]])

# Create label like "8n-128tx"
df["scenario_label"] = df.apply(lambda row: f"{row['nodes']}n-{row['txpb']}tx", axis=1)

# Prepare CPU Data
cpu_df = df.groupby(["scenario_label", "protocol"], as_index=False)["avg_cpu"].mean()
cpu_df["nodes"] = cpu_df["scenario_label"].str.extract(r"^(\d+)").astype(int)
cpu_df["txpb"] = cpu_df["scenario_label"].str.extract(r"-(\d+)tx").astype(int)
cpu_df = cpu_df.sort_values(by=["nodes", "txpb"])
cpu_pivot = cpu_df.pivot(index="scenario_label", columns="protocol", values="avg_cpu")
cpu_pivot = cpu_pivot.reindex(cpu_df["scenario_label"].unique())

# Prepare MEM Data
mem_df = df.groupby(["scenario_label", "protocol"], as_index=False)["avg_mem"].mean()
mem_df["nodes"] = mem_df["scenario_label"].str.extract(r"^(\d+)").astype(int)
mem_df["txpb"] = mem_df["scenario_label"].str.extract(r"-(\d+)tx").astype(int)
mem_df = mem_df.sort_values(by=["nodes", "txpb"])
mem_pivot = mem_df.pivot(index="scenario_label", columns="protocol", values="avg_mem")
mem_pivot = mem_pivot.reindex(mem_df["scenario_label"].unique())

# Plotting
fig, axes = plt.subplots(1, 2, figsize=(16, 7))
bar_width = 0.35

# X locations
x_cpu = np.arange(len(cpu_pivot.index))
x_mem = np.arange(len(mem_pivot.index))

# CPU subplot
bars_merkle_cpu = axes[0].bar(x_cpu - bar_width/2, cpu_pivot["MERKLE"], bar_width, label="MERKLE")
bars_rsa_cpu = axes[0].bar(x_cpu + bar_width/2, cpu_pivot["RSA"], bar_width, label="RSA")

axes[0].set_title("Average CPU Usage (%)")
axes[0].set_xlabel("Scenario (Nodes - Tx per Batch)")
axes[0].set_ylabel("CPU Usage (%)")
axes[0].set_xticks(x_cpu)
axes[0].set_xticklabels(cpu_pivot.index, rotation=45)

for bars in [bars_merkle_cpu, bars_rsa_cpu]:
    for bar in bars:
        height = bar.get_height()
        axes[0].annotate(f'{height:.1f}',
                         xy=(bar.get_x() + bar.get_width()/2, height),
                         xytext=(0, 3),
                         textcoords="offset points",
                         ha='center', va='bottom', fontsize=8)

axes[0].legend()
axes[0].grid(axis="y", linestyle="--", alpha=0.7)

# MEM subplot
bars_merkle_mem = axes[1].bar(x_mem - bar_width/2, mem_pivot["MERKLE"], bar_width, label="MERKLE")
bars_rsa_mem = axes[1].bar(x_mem + bar_width/2, mem_pivot["RSA"], bar_width, label="RSA")

axes[1].set_title("Average Memory Usage (GB)")
axes[1].set_xlabel("Scenario (Nodes - Tx per Batch)")
axes[1].set_ylabel("Memory Usage (GB)")
axes[1].set_xticks(x_mem)
axes[1].set_xticklabels(mem_pivot.index, rotation=45)

for bars in [bars_merkle_mem, bars_rsa_mem]:
    for bar in bars:
        height = bar.get_height()
        axes[1].annotate(f'{height:.2f}',
                         xy=(bar.get_x() + bar.get_width()/2, height),
                         xytext=(0, 3),
                         textcoords="offset points",
                         ha='center', va='bottom', fontsize=8)

axes[1].legend()
axes[1].grid(axis="y", linestyle="--", alpha=0.7)

plt.suptitle("Resource Utilization by Protocol and Scenario", fontsize=16)
plt.tight_layout(rect=[0, 0, 1, 0.95])
plt.savefig("resource_utilization_chart.png")
print("✅ Saved chart to 'resource_utilization_chart.png'")
