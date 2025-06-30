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
print(df[["nodes", "txpb", "protocol", "avg_overhead"]])

# Create label like "8n-128tx"
df["scenario_label"] = df.apply(lambda row: f"{row['nodes']}n-{row['txpb']}tx", axis=1)

# Group by scenario and protocol, compute mean overhead
df_grouped = df.groupby(["scenario_label", "protocol"], as_index=False)["avg_overhead"].mean()

# Extract sorting keys
df_grouped["nodes"] = df_grouped["scenario_label"].str.extract(r"^(\d+)").astype(int)
df_grouped["txpb"] = df_grouped["scenario_label"].str.extract(r"-(\d+)tx").astype(int)
df_grouped = df_grouped.sort_values(by=["nodes", "txpb"])

# Pivot and reindex by sorted scenario labels
df_pivot = df_grouped.pivot(index="scenario_label", columns="protocol", values="avg_overhead")
df_pivot = df_pivot.reindex(df_grouped["scenario_label"].unique())

# Plotting
fig, ax = plt.subplots(figsize=(12, 8))
x = np.arange(len(df_pivot.index))
bar_width = 0.35

bars_merkle = ax.bar(x - bar_width/2, df_pivot["MERKLE"], bar_width, label="MERKLE")
bars_rsa = ax.bar(x + bar_width/2, df_pivot["RSA"], bar_width, label="RSA")

# Label bars with values
for bars in [bars_merkle, bars_rsa]:
    for bar in bars:
        height = bar.get_height()
        ax.annotate(f'{height:.1f}',
                    xy=(bar.get_x() + bar.get_width() / 2, height),
                    xytext=(0, 3),
                    textcoords="offset points",
                    ha='center', va='bottom', fontsize=9)

# Labels and title
ax.set_xlabel("Scenario (Nodes - Tx per Batch)", fontsize=12)
ax.set_ylabel("Avg Communication Overhead", fontsize=12)
ax.set_title("Communication Overhead by Protocol and Scenario", fontsize=14)
ax.set_xticks(x)
ax.set_xticklabels(df_pivot.index, rotation=45)
ax.legend()

# Y-axis scaling
max_y = df_pivot.to_numpy().max()
ax.set_ylim(0, max_y * 1.2)

ax.grid(axis="y", linestyle="--", alpha=0.7)
plt.tight_layout()
plt.savefig("communication_overhead_bar_chart.png")
print("✅ Saved updated graph to 'communication_overhead_bar_chart.png'")
