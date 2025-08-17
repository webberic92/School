#!/bin/bash

REPORT_FILE="final_metrics_report.txt"
> "$REPORT_FILE"  # Clear existing report

echo "📦 AlephResearch Final Metrics Report (RSA)" | tee -a "$REPORT_FILE"
echo "==============================================" | tee -a "$REPORT_FILE"
echo "" | tee -a "$REPORT_FILE"

# Run TPS
if [[ -x ./getThroughput_TPS.sh ]]; then
    echo "🚀 Transaction Throughput (TPS)" | tee -a "$REPORT_FILE"
    echo "----------------------------------------------" | tee -a "$REPORT_FILE"
    ./getThroughput_TPS.sh | tee -a "$REPORT_FILE"
    echo "" | tee -a "$REPORT_FILE"
else
    echo "⚠️ getThroughput_TPS.sh not found or not executable." | tee -a "$REPORT_FILE"
fi

# Run Communication Overhead
if [[ -x ./getCommunicationOverhead.sh ]]; then
    echo "📡 Communication Overhead" | tee -a "$REPORT_FILE"
    echo "----------------------------------------------" | tee -a "$REPORT_FILE"
    ./getCommunicationOverhead.sh | tee -a "$REPORT_FILE"
    echo "" | tee -a "$REPORT_FILE"
else
    echo "⚠️ getCommunicationOverhead.sh not found or not executable." | tee -a "$REPORT_FILE"
fi

# Run Memory & CPU Utilization
if [[ -x ./getMemoryUtilization.sh ]]; then
    echo "🖥️  Resource Utilization (CPU & Memory)" | tee -a "$REPORT_FILE"
    echo "----------------------------------------------" | tee -a "$REPORT_FILE"
    ./getMemoryUtilization.sh | tee -a "$REPORT_FILE"
    echo "" | tee -a "$REPORT_FILE"
else
    echo "⚠️ getMemoryUtilization.sh not found or not executable." | tee -a "$REPORT_FILE"
fi

# Run Latency
if [[ -x ./getLatency.sh ]]; then
    echo "⏱️  Consensus Latency" | tee -a "$REPORT_FILE"
    echo "----------------------------------------------" | tee -a "$REPORT_FILE"
    ./getLatency.sh | tee -a "$REPORT_FILE"
    echo "" | tee -a "$REPORT_FILE"
else
    echo "⚠️ getLatency.sh not found or not executable." | tee -a "$REPORT_FILE"
fi

echo "✅ Report complete. Output saved to: $REPORT_FILE"