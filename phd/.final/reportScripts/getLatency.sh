#!/bin/bash

echo "⏱️  Measuring Latency Across Nodes"
echo "--------------------------------------------"

start_times=()
end_times=()

# Loop through all node_status files
for node_path in node-*/; do
    file_path="${node_path}/node_status"
    [[ ! -f "$file_path" ]] && file_path="${node_path}/node_status.txt"
    
    if [[ -f "$file_path" ]]; then
        # Remove ANSI escape codes and extract timestamps
        starts=$(grep "LATENCY START" "$file_path" | sed 's/\x1B\[[0-9;]*[JKmsu]//g' | awk '{print $1}' | sed 's/Z//')
        ends=$(grep "LATENCY END" "$file_path" | sed 's/\x1B\[[0-9;]*[JKmsu]//g' | awk '{print $1}' | sed 's/Z//')

        # Append to arrays
        for ts in $starts; do start_times+=("$ts"); done
        for ts in $ends; do end_times+=("$ts"); done
    fi
done

# Check if we have timestamps
if [[ ${#start_times[@]} -eq 0 || ${#end_times[@]} -eq 0 ]]; then
    echo "❌ No LATENCY START/END timestamps found."
    exit 1
fi

# Sort and find earliest start and latest end
sorted_starts=($(printf "%s\n" "${start_times[@]}" | sort))
sorted_ends=($(printf "%s\n" "${end_times[@]}" | sort))

earliest_start="${sorted_starts[0]}"
latest_end="${sorted_ends[-1]}"

# Convert to epoch seconds with nanosecond precision
start_epoch=$(LC_ALL=C date -d "$earliest_start" +%s.%N 2>/dev/null)
end_epoch=$(LC_ALL=C date -d "$latest_end" +%s.%N 2>/dev/null)

# Fallback in case date parsing fails
if [[ -z "$start_epoch" || -z "$end_epoch" ]]; then
    echo "❌ Failed to parse start or end timestamp."
    echo "Start: $earliest_start"
    echo "End:   $latest_end"
    exit 1
fi

# Calculate latency
latency=$(echo "$end_epoch - $start_epoch" | bc -l)

echo "📍 Earliest Start: $earliest_start"
echo "📍 Latest End:     $latest_end"
echo "--------------------------------------------"
printf "📈 Total Latency: %.3f seconds\n" "$latency"