import matplotlib.pyplot as plt
import seaborn as sns

# Plot transaction throughput
sns.lineplot(x="node_id", y="value", hue="metric_name", data=df)
plt.title("Transaction Throughput by Node")
plt.show()
