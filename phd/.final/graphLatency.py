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
print(df[["nodes", "txpb", "protocol", "latency_seconds"]])

# Create label like "8n-128tx"
df["scenario_label"] = df.apply(lambda row: f"{row['nodes']}n-{row['txpb']}tx", axis=1)

# Group by scenario and protocol, compute mean latency
df_grouped = df.groupby(["scenario_label", "protocol"], as_index=False)["latency_seconds"].mean()

# Extract sorting keys
df_grouped["nodes"] = df_grouped["scenario_label"].str.extract(r"^(\d+)").astype(int)
df_grouped["txpb"] = df_grouped["scenario_label"].str.extract(r"-(\d+)tx").astype(int)
df_grouped = df_grouped.sort_values(by=["nodes", "txpb"])

# Pivot and reindex
df_pivot = df_grouped.pivot(index="scenario_label", columns="protocol", values="latency_seconds")
df_pivot = df_pivot.reindex(df_grouped["scenario_label"].unique())

# Plotting
fig, ax = plt.subplots(figsize=(12, 8))
x = np.arange(len(df_pivot.index))
bar_width = 0.35

bars_merkle = ax.bar(x - bar_width/2, df_pivot["MERKLE"], bar_width, label="MERKLE")
bars_rsa = ax.bar(x + bar_width/2, df_pivot["RSA"], bar_width, label="RSA")

# Label bars with latency values
for bars in [bars_merkle, bars_rsa]:
    for bar in bars:
        height = bar.get_height()
        ax.annotate(f'{height:.1f}',
                    xy=(bar.get_x() + bar.get_width() / 2, height),
                    xytext=(0, 3),
                    textcoords="offset points",
                    ha='center', va='bottom', fontsize=9)

# Axes and labels
ax.set_xlabel("Scenario (Nodes - Tx per Batch)", fontsize=12)
ax.set_ylabel("Average Latency (s)", fontsize=12)
ax.set_title("Latency by Protocol and Scenario", fontsize=14)
ax.set_xticks(x)
ax.set_xticklabels(df_pivot.index, rotation=45)
ax.legend()

# Expand Y-axis range
max_y = df_pivot.to_numpy().max()
ax.set_ylim(0, max_y * 1.2)

ax.grid(axis="y", linestyle="--", alpha=0.7)
plt.tight_layout()
plt.savefig("latency_bar_chart.png")
print("✅ Saved latency chart to 'latency_bar_chart.png'")
