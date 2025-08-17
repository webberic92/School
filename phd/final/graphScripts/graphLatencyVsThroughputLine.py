#!/usr/bin/env python3
import os
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import sqlite3
from itertools import cycle

# ---------- Output ----------
os.makedirs("./charts", exist_ok=True)
out_path = "./charts/throughput_vs_batch_by_nodes_merkle_vs_rsa.png"

# ---------- DB ----------
DB_PATH = "t3m_small_deployments.db"  # change if needed
conn = sqlite3.connect(DB_PATH)

# ---------- Load ----------
df = pd.read_sql("SELECT * FROM experiment_summary", conn)

# Expect: protocol, nodes, txpb, avg_tps
needed = {"protocol", "nodes", "txpb", "avg_tps"}
missing = needed - set(df.columns)
if missing:
    raise ValueError(f"Missing columns in experiment_summary: {missing}")

# Clean & aggregate
df = df.dropna(subset=["protocol", "nodes", "txpb"])
df["protocol"] = df["protocol"].str.upper()

agg = (
    df.groupby(["nodes", "txpb", "protocol"], as_index=False)["avg_tps"]
      .mean()
      .sort_values(["nodes", "txpb"])
)

# ---------- Quick audit: how many txpb points per (nodes, protocol)?
counts = agg.groupby(["nodes", "protocol"])["txpb"].nunique().reset_index(name="num_txpb_points")
print("\n📊 Points per (nodes, protocol):")
print(counts.sort_values(["nodes", "protocol"]).to_string(index=False))
print("\nℹ️ Lines will only be drawn where num_txpb_points ≥ 2.\n")

# ---------- Plot ----------
configs = sorted(agg["nodes"].unique().tolist())  # node-count configs
protocols = ["MERKLE", "RSA"]
markers = {"MERKLE": "s", "RSA": "o"}  # square vs circle
color_cycle = cycle(plt.rcParams["axes.prop_cycle"].by_key().get("color", ["C0","C1","C2","C3","C4"]))

fig, ax = plt.subplots(figsize=(12, 7))

for nodes in configs:
    color = next(color_cycle)
    for proto in protocols:
        sub = agg[(agg["nodes"] == nodes) & (agg["protocol"] == proto)].copy()
        if sub.empty:
            continue
        sub = sub.sort_values("txpb")
        x = sub["txpb"].to_numpy(float)
        y = sub["avg_tps"].to_numpy(float)

        # draw a line only if we have at least 2 points
        label = f"{nodes}N {proto.capitalize()}"
        if len(sub) >= 2:
            ax.plot(x, y, marker=markers.get(proto, "o"), linestyle='-',
                    linewidth=2.0, markersize=6, alpha=0.95,
                    color=color, label=label)
        else:
            # single point: just a marker with same legend entry
            ax.plot(x, y, marker=markers.get(proto, "o"), linestyle='',
                    markersize=7, alpha=0.95,
                    color=color, label=label + " (1 pt)")

# Axes, scale, grid, legend
ax.set_xscale("log")
ax.set_yscale("log")
ax.set_xlabel("Batch size (Tx per round) — log scale", fontsize=12)
ax.set_ylabel("Throughput (Tx per second) — log scale", fontsize=12)
ax.set_title("Throughput vs Batch Size by Node Config (Merkle □ vs RSA ○)", fontsize=14)
ax.grid(True, which="both", linestyle="--", alpha=0.6)
ax.legend(title="Config / Variant", ncol=2, fontsize=9)

plt.tight_layout()
plt.savefig(out_path, dpi=200)
print(f"✅ Saved: {out_path}")
