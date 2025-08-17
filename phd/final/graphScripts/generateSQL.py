#!/usr/bin/env python3
import os, re, statistics

BASE_PATH = "../"              # folder with your *.txt reports
OUTPUT_FILE = "./insert_all.sql"

TABLE_SUMMARY  = "experiment_summary"
TABLE_TPS      = "node_tps"
TABLE_OVERHEAD = "node_overhead"
TABLE_RESOURCE = "node_resource_utilization"

HEADER_SQL = f"""-- SQLite schema (foreign keys on; no CASCADE/DO blocks)
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS {TABLE_TPS};
DROP TABLE IF EXISTS {TABLE_OVERHEAD};
DROP TABLE IF EXISTS {TABLE_RESOURCE};
DROP TABLE IF EXISTS {TABLE_SUMMARY};

CREATE TABLE {TABLE_SUMMARY} (
    id INTEGER PRIMARY KEY,
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
    id INTEGER PRIMARY KEY,
    experiment_id INTEGER NOT NULL REFERENCES {TABLE_SUMMARY}(id),
    node_id TEXT NOT NULL,
    tps REAL
);

CREATE TABLE {TABLE_OVERHEAD} (
    id INTEGER PRIMARY KEY,
    experiment_id INTEGER NOT NULL REFERENCES {TABLE_SUMMARY}(id),
    node_id TEXT NOT NULL,
    overhead_messages INTEGER
);

CREATE TABLE {TABLE_RESOURCE} (
    id INTEGER PRIMARY KEY,
    experiment_id INTEGER NOT NULL REFERENCES {TABLE_SUMMARY}(id),
    node_id TEXT NOT NULL,
    cpu_util REAL,
    mem_util REAL
);

-- Holds the id of the most recently inserted experiment in this connection
CREATE TEMP TABLE IF NOT EXISTS __exp(id INTEGER);
"""

def parse_filename(fname: str):
    # t3m_16nodes_16txpb_16rounds_XXXXX.txt
    m = re.search(r"t3m_(\d+)nodes.*?(\d+)txpb.*?(\d+)rounds", fname, re.I)
    if m:
        nodes, txpb, rounds = m.groups()
        return int(nodes), int(txpb), int(rounds)
    return None, None, None

def infer_protocol(fname: str):
    up = fname.upper()
    if "_RSA" in up: return "RSA"
    if "_MERKLE" in up: return "MERKLE"
    return "UNKNOWN"

def sanitize(val: str) -> str:
    return val.replace("'", "''")

def parse_file(path, protocol, fname):
    with open(path, "r", encoding="utf-8", errors="replace") as f:
        content = f.read()

    nodes, txpb, rounds = parse_filename(fname)
    if not nodes:
        return ""  # skip files that don't match expected naming

    # --- summary stats ---
    # TPS: be strict about the colon AFTER the closing paren, so we don't hit "Tx/Round: 5"
    avg_tps_line = re.search(
        r"Average TPS across\s+\d+\s+nodes\s*\(Tx/Round:\s*\d+,\s*Rounds:\s*\d+\)\s*:\s*([\d.]+)",
        content, re.I
    )

    avg_overhead = re.search(r"Average Communication Overhead.*?:\s*([\d.]+)", content, re.I)
    avg_cpu      = re.search(r"Average CPU Utilization.*?:\s*([\d.]+)", content, re.I)
    avg_mem      = re.search(r"Average Memory Utilization.*?:\s*([\d.]+)", content, re.I)
    latency      = re.search(r"Total Latency:\s*([\d.]+)", content, re.I)

    # --- per-node stats (tolerant) ---
    tps        = re.findall(r"node-(\d+).*?TPS:\s*([\d.]+)", content, re.S | re.I)
    overheads  = re.findall(r"node-(\d+).*?Overhead.*?:\s*([\d.]+)", content, re.S | re.I)
    resources  = re.findall(
        r"node-(\d+).*?CPU(?:\s*Utilization)?[:\s]+([\d.]+).*?Mem(?:ory)?(?:\s*Utilization)?[:\s]+([\d.]+)",
        content, re.S | re.I
    )

    # Decide avg_tps: prefer the explicit line; else fallback to mean of per-node TPS
    if avg_tps_line:
        avg_tps_val = float(avg_tps_line.group(1))
    elif tps:
        avg_tps_val = float(statistics.mean(float(v) for _, v in tps))
    else:
        avg_tps_val = None

    # Begin SQL block for this file
    block = f"""-- {fname}
INSERT INTO {TABLE_SUMMARY}
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('{protocol}', '{sanitize(fname)}', {nodes}, {txpb}, {rounds},
   {avg_tps_val if avg_tps_val is not None else 'NULL'},
   {float(avg_overhead.group(1)) if avg_overhead else 'NULL'},
   {float(avg_cpu.group(1)) if avg_cpu else 'NULL'},
   {float(avg_mem.group(1)) if avg_mem else 'NULL'},
   {float(latency.group(1)) if latency else 'NULL'});

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());
"""

    # Helper to build SELECT … UNION ALL … from __exp so experiment_id is stable
    def select_union(rows, mapper, header_cols):
        if not rows: return ""
        selects = "\n  UNION ALL\n  ".join(mapper(r) for r in rows)
        return f"SELECT {header_cols} FROM (\n  {selects}\n);\n"

    if tps:
        block += (
            f"\nINSERT INTO {TABLE_TPS} (experiment_id, node_id, tps)\n" +
            select_union(
                tps,
                lambda nv: f"SELECT id, 'node-{nv[0]}' AS node_id, {nv[1]} AS tps FROM __exp",
                "id, node_id, tps"
            )
        )

    if overheads:
        block += (
            f"\nINSERT INTO {TABLE_OVERHEAD} (experiment_id, node_id, overhead_messages)\n" +
            select_union(
                overheads,
                lambda nv: f"SELECT id, 'node-{nv[0]}' AS node_id, {int(float(nv[1]))} AS overhead_messages FROM __exp",
                "id, node_id, overhead_messages"
            )
        )

    if resources:
        block += (
            f"\nINSERT INTO {TABLE_RESOURCE} (experiment_id, node_id, cpu_util, mem_util)\n" +
            select_union(
                resources,
                lambda ncm: f"SELECT id, 'node-{ncm[0]}' AS node_id, {ncm[1]} AS cpu_util, {ncm[2]} AS mem_util FROM __exp",
                "id, node_id, cpu_util, mem_util"
            )
        )

    block += "\n"
    return block

def main():
    sql_blocks = [HEADER_SQL]
    for fname in sorted(os.listdir(BASE_PATH)):
        if not fname.lower().endswith(".txt"):
            continue
        protocol = infer_protocol(fname)
        sql_block = parse_file(os.path.join(BASE_PATH, fname), protocol, fname)
        if sql_block.strip():
            sql_blocks.append(sql_block)

    with open(OUTPUT_FILE, "w", encoding="utf-8") as out:
        out.write("\n".join(sql_blocks))
    print(f"✅ SQL written to {OUTPUT_FILE}")

if __name__ == "__main__":
    main()
