#!/bin/bash

LOG_DIR="./"
NODE1_STATUS="node-1/node_status"

TX_PER_ROUND=$(grep "number_of_transactions" "$NODE1_STATUS" | awk -F= '{gsub(/ /,"",$2); print $2}' | cut -d'#' -f1)
ROUNDS=$(grep "total_rounds" "$NODE1_STATUS" | awk -F= '{gsub(/ /,"",$2); print $2}' | cut -d'#' -f1)
TOTAL_TX=$((TX_PER_ROUND * ROUNDS))

echo "📊 Transaction Throughput per Node"
echo "----------------------------------"

total_tps=0
node_count=0

for node_path in node-*/; do
    file_path="${node_path}/node_status"

    if [[ ! -f "$file_path" ]]; then
        file_path="${node_path}/node_status.txt"
    fi

    if [[ -f "$file_path" ]]; then
        timestamps=$(grep "Successfully wrote finalized DAG for round" "$file_path" | \
                    sed -E 's/\x1b\[[0-9;]*m//g' | \
                    grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9:.]+Z' | \
                    sed 's/T/ /' | sed 's/Z//')



        start_time=$(echo "$timestamps" | head -n 1)
        end_time=$(echo "$timestamps" | tail -n 1)

        start_epoch=$(LC_ALL=C date -d "$start_time" +%s.%N 2>/dev/null)
        end_epoch=$(LC_ALL=C date -d "$end_time" +%s.%N 2>/dev/null)

        if [[ -n "$start_epoch" && -n "$end_epoch" ]]; then
            duration=$(echo "$end_epoch - $start_epoch" | bc -l)
            tps=$(echo "$TOTAL_TX / $duration" | bc -l)

            printf "%-40s TPS: %.2f\n" "$node_path" "$tps"

            total_tps=$(echo "$total_tps + $tps" | bc -l)
            node_count=$((node_count + 1))
        else
            printf "%-40s ⚠️ Invalid timestamps, skipping\n" "$node_path"
        fi
    fi
done

# Compute and print average TPS
if [[ $node_count -gt 0 ]]; then
    avg_tps=$(echo "$total_tps / $node_count" | bc -l)
    echo "----------------------------------"
    printf "📈 Average TPS across %d nodes (Tx/Round: %d, Rounds: %d): %.2f\n" "$node_count" "$TX_PER_ROUND" "$ROUNDS" "$avg_tps"
fi