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

# Preview for sanity check
print("📋 Loaded data:")
print(df[["nodes", "txpb", "protocol", "avg_tps"]])

# Create label like "8n-128tx"
df["scenario_label"] = df.apply(lambda row: f"{row['nodes']}n-{row['txpb']}tx", axis=1)

df_grouped = df.groupby(["scenario_label", "protocol"], as_index=False)["avg_tps"].mean()
df_grouped["nodes"] = df_grouped["scenario_label"].str.extract(r"^(\d+)").astype(int)
df_grouped["txpb"] = df_grouped["scenario_label"].str.extract(r"-(\d+)tx").astype(int)
df_grouped = df_grouped.sort_values(by=["nodes", "txpb"])

df_pivot = df_grouped.pivot(index="scenario_label", columns="protocol", values="avg_tps")
df_pivot = df_pivot.reindex(sorted(df_grouped["scenario_label"].unique(), key=lambda x: int(x.split('n')[0])))

# Plotting
fig, ax = plt.subplots(figsize=(12, 8))
x = np.arange(len(df_pivot.index))
bar_width = 0.35

# Draw bars
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

# Axes and labels
ax.set_xlabel("Scenario (Nodes - Tx per Batch)", fontsize=12)
ax.set_ylabel("Average TPS", fontsize=12)
ax.set_title("Throughput (TPS) by Protocol and Scenario", fontsize=14)
ax.set_xticks(x)
ax.set_xticklabels(df_pivot.index, rotation=45)
ax.legend()

# Force y-axis to expand
max_y = df_pivot.to_numpy().max()
ax.set_ylim(0, max_y * 1.2)

ax.grid(axis="y", linestyle="--", alpha=0.7)
plt.tight_layout()
plt.savefig("tps.png")
print("✅ Saved updated graph to 'experiment_summary_bar_chart.png'")
