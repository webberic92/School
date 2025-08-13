-- SQLite schema (foreign keys on; no CASCADE/DO blocks)
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS node_tps;
DROP TABLE IF EXISTS node_overhead;
DROP TABLE IF EXISTS node_resource_utilization;
DROP TABLE IF EXISTS experiment_summary;

CREATE TABLE experiment_summary (
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

CREATE TABLE node_tps (
    id INTEGER PRIMARY KEY,
    experiment_id INTEGER NOT NULL REFERENCES experiment_summary(id),
    node_id TEXT NOT NULL,
    tps REAL
);

CREATE TABLE node_overhead (
    id INTEGER PRIMARY KEY,
    experiment_id INTEGER NOT NULL REFERENCES experiment_summary(id),
    node_id TEXT NOT NULL,
    overhead_messages INTEGER
);

CREATE TABLE node_resource_utilization (
    id INTEGER PRIMARY KEY,
    experiment_id INTEGER NOT NULL REFERENCES experiment_summary(id),
    node_id TEXT NOT NULL,
    cpu_util REAL,
    mem_util REAL
);

-- Holds the id of the most recently inserted experiment in this connection
CREATE TEMP TABLE IF NOT EXISTS __exp(id INTEGER);

-- t3m_16nodes_16txpb_16rounds_MERKLE.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('MERKLE', 't3m_16nodes_16txpb_16rounds_MERKLE.txt', 16, 16, 16,
   33.67,
   656.37,
   9.53,
   28.47,
   13.289);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 33.55 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 33.39 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 33.99 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 33.59 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 33.54 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 33.33 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 34.02 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 34.10 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 34.00 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 33.59 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 33.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 33.53 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 33.52 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 33.93 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 33.49 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 33.55 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 646 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 665 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 665 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 664 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 642 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 662 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 662 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 642 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 663 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 640 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 679 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 663 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 610 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 677 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 641 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 681 AS overhead_messages FROM __exp
);


-- t3m_16nodes_16txpb_16rounds_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', 't3m_16nodes_16txpb_16rounds_RSA.txt', 16, 16, 16,
   50.26,
   881.62,
   33.69,
   28.32,
   10.244);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 50.49 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 49.01 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 50.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 50.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 50.36 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 50.80 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 50.38 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 50.22 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 50.67 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 50.75 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 49.69 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 50.14 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 49.73 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 49.50 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 50.69 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 50.38 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 875 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 822 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 864 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 930 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 842 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 925 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 901 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 844 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 932 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 921 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 784 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 853 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 884 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 918 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 935 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 876 AS overhead_messages FROM __exp
);


-- t3m_5nodes_5txpb_5rounds_MERKLE.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('MERKLE', 't3m_5nodes_5txpb_5rounds_MERKLE.txt', 5, 5, 5,
   70.75,
   64.6,
   41.93,
   28.24,
   5.822);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 70.09 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 71.95 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 68.63 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 71.68 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 71.40 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 67 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 68 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 67 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 62 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 59 AS overhead_messages FROM __exp
);


-- t3m_5nodes_5txpb_5rounds_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', 't3m_5nodes_5txpb_5rounds_RSA.txt', 5, 5, 5,
   82.12,
   100.4,
   0.0,
   0.0,
   4.972);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 84.86 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 83.06 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 74.01 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 86.14 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 82.53 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 107 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 105 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 80 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 105 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 105 AS overhead_messages FROM __exp
);


-- t3m_8nodes_8txpb_8rounds_MERKLE.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('MERKLE', 't3m_8nodes_8txpb_8rounds_MERKLE.txt', 8, 8, 8,
   61.42,
   157.25,
   47.37,
   28.21,
   5.043);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 61.62 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 61.02 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 61.68 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 60.68 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 62.29 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 60.54 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 61.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 61.84 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 161 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 131 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 165 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 162 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 165 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 161 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 154 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 159 AS overhead_messages FROM __exp
);


-- t3m_8nodes_8txpb_8rounds_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', 't3m_8nodes_8txpb_8rounds_RSA.txt', 8, 8, 8,
   86.75,
   203.25,
   0.0,
   0.0,
   5.527);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 89.43 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 86.57 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 86.02 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 84.46 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 87.43 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 87.19 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 85.40 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 87.48 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 209 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 203 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 214 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 209 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 213 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 227 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 203 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 148 AS overhead_messages FROM __exp
);

