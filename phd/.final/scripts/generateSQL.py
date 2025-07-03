#!/usr/bin/env python3
import os
import re

BASE_PATH = "../"
OUTPUT_FILE = "./insert_all.sql"

TABLE_SUMMARY = "experiment_summary"
TABLE_TPS = "node_tps"
TABLE_OVERHEAD = "node_overhead"
TABLE_RESOURCE = "node_resource_utilization"

HEADER_SQL = f"""-- Drop and create schema
DROP TABLE IF EXISTS {TABLE_TPS}, {TABLE_OVERHEAD}, {TABLE_RESOURCE}, {TABLE_SUMMARY} CASCADE;

CREATE TABLE {TABLE_SUMMARY} (
    id SERIAL PRIMARY KEY,
    protocol TEXT NOT NULL,
    filename TEXT NOT NULL,
    nodes INTEGER NOT NULL,
    txpb INTEGER NOT NULL,
    rounds INTEGER NOT NULL,
    avg_tps REAL,
    avg_overhead REAL,
    avg_cpu REAL,
    avg_mem REAL,
    latency_seconds REAL
);

CREATE TABLE {TABLE_TPS} (
    id SERIAL PRIMARY KEY,
    experiment_id INTEGER NOT NULL REFERENCES {TABLE_SUMMARY}(id),
    node_id TEXT NOT NULL,
    tps REAL
);

CREATE TABLE {TABLE_OVERHEAD} (
    id SERIAL PRIMARY KEY,
    experiment_id INTEGER NOT NULL REFERENCES {TABLE_SUMMARY}(id),
    node_id TEXT NOT NULL,
    overhead_messages INTEGER
);

CREATE TABLE {TABLE_RESOURCE} (
    id SERIAL PRIMARY KEY,
    experiment_id INTEGER NOT NULL REFERENCES {TABLE_SUMMARY}(id),
    node_id TEXT NOT NULL,
    cpu_util REAL,
    mem_util REAL
);

-- Optional truncation for repeatable runs
-- TRUNCATE TABLE {TABLE_TPS}, {TABLE_OVERHEAD}, {TABLE_RESOURCE}, {TABLE_SUMMARY} RESTART IDENTITY CASCADE;

"""

def parse_filename(fname):
    m = re.search(r"(\d+)nodes.*?(\d+)?txpb.*?(\d+)?rounds", fname)
    if m:
        nodes, txpb, rounds = m.groups()
        return int(nodes), int(txpb or 0), int(rounds or 0)
    return None, None, None

def sanitize(val):
    return val.replace("'", "''")

def parse_file(path, protocol, fname):
    with open(path) as f:
        content = f.read()

    nodes, txpb, rounds = parse_filename(fname)
    if not nodes:
        return ""

    avg_tps = re.search(r"Average TPS across \d+ nodes\s+\(Tx/Round: \d+, Rounds: \d+\):\s*([\d.]+)", content)
    avg_overhead = re.search(r"Average Communication Overhead.*?: ([\d.]+)", content)
    avg_cpu = re.search(r"Average CPU Utilization.*?: ([\d.]+)", content)
    avg_mem = re.search(r"Average Memory Utilization.*?: ([\d.]+)", content)
    latency = re.search(r"Total Latency: ([\d.]+)", content)

    tps = re.findall(r"node-(\d+).*?TPS: ([\d.]+)", content)
    overheads = re.findall(r"node-(\d+)/\s+Overhead: (\d+)", content)
    resources = re.findall(r"node-(\d+)/\s+([\d.]+)\s+([\d.]+)", content)

    block = f"""-- {fname}
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO {TABLE_SUMMARY} 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('{protocol}', '{sanitize(fname)}', {nodes}, {txpb}, {rounds}, 
   {float(avg_tps.group(1)) if avg_tps else 'NULL'}, 
   {float(avg_overhead.group(1)) if avg_overhead else 'NULL'},
   {float(avg_cpu.group(1)) if avg_cpu else 'NULL'},
   {float(avg_mem.group(1)) if avg_mem else 'NULL'},
   {float(latency.group(1)) if latency else 'NULL'})
  RETURNING id INTO experiment_id;
"""

    if tps:
        block += f"\n  INSERT INTO {TABLE_TPS} (experiment_id, node_id, tps)\n  VALUES\n"
        block += ",\n".join(f"    (experiment_id, 'node-{n}', {v})" for n, v in tps) + ";\n"

    if overheads:
        block += f"\n  INSERT INTO {TABLE_OVERHEAD} (experiment_id, node_id, overhead_messages)\n  VALUES\n"
        block += ",\n".join(f"    (experiment_id, 'node-{n}', {v})" for n, v in overheads) + ";\n"

    if resources:
        block += f"\n  INSERT INTO {TABLE_RESOURCE} (experiment_id, node_id, cpu_util, mem_util)\n  VALUES\n"
        block += ",\n".join(f"    (experiment_id, 'node-{n}', {cpu}, {mem})"
                            for n, cpu, mem in resources) + ";\n"

    block += "END $$;\n\n"
    return block


def main():
    sql_blocks = [HEADER_SQL]

    for proto in ['merkle', 'rsa']:
        full_path = os.path.join(BASE_PATH, proto)
        if not os.path.exists(full_path):
            continue
        for fname in sorted(os.listdir(full_path)):
            if fname.endswith('.txt'):
                sql_block = parse_file(os.path.join(full_path, fname), proto.upper(), fname)
                sql_blocks.append(sql_block)

    with open(OUTPUT_FILE, "w") as out:
        out.write("\n".join(sql_blocks))

    print(f"✅ SQL written to {OUTPUT_FILE}")

if __name__ == "__main__":
    main()
