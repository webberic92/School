#!/bin/bash
# 📡 Communication Overhead: Total number of messages exchanged during the consensus process.

echo "📡 Communication Overhead per Node (Final Round Only)"
echo "------------------------------------------------------"

total_overhead=0
node_count=0

for node_path in node-*/; do
    file_path="${node_path}/node_status"
    if [[ ! -f "$file_path" ]]; then
        file_path="${node_path}/node_status.txt"
    fi

    if [[ -f "$file_path" ]]; then
        # Use the last line that contains "COMMUNICATION OVERHEAD"
        line=$(grep "COMMUNICATION OVERHEAD" "$file_path" | tail -n 1)

        # Extract just the number
        overhead=$(echo "$line" | grep -oE "COMMUNICATION OVERHEAD [0-9]+" | awk '{print $3}')

        if [[ "$overhead" =~ ^[0-9]+$ ]]; then
            printf "%-40s Overhead: %d messages\n" "$node_path" "$overhead"
            total_overhead=$((total_overhead + overhead))
            node_count=$((node_count + 1))
        else
            printf "%-40s ⚠️ Could not parse overhead\n" "$node_path"
        fi
    else
        printf "%-40s ⚠️ No status file found\n" "$node_path"
    fi
done

# Calculate average overhead
if [[ $node_count -gt 0 ]]; then
    avg_overhead=$(echo "scale=2; $total_overhead / $node_count" | bc -l)
    echo "------------------------------------------------------"
    printf "📈 Average Communication Overhead across %d nodes: %.2f messages\n" "$node_count" "$avg_overhead"
else
    echo "❌ No valid data found."
fi