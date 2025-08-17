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

-- t3m_5nodes_128txpb_16rounds_MERKLE_BROKE.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('MERKLE', 't3m_5nodes_128txpb_16rounds_MERKLE_BROKE.txt', 5, 128, 16,
   NULL,
   NULL,
   NULL,
   NULL,
   NULL);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());


-- t3m_5nodes_128txpb_16rounds_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', 't3m_5nodes_128txpb_16rounds_RSA.txt', 5, 128, 16,
   341.46,
   192.0,
   38.64,
   32.97,
   9.211);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 335.42 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 344.69 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 360.33 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 334.14 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 332.74 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 234 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 177 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 116 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 230 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 203 AS overhead_messages FROM __exp
);


-- t3m_5nodes_16txpb_5rounds_MERKLE.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('MERKLE', 't3m_5nodes_16txpb_5rounds_MERKLE.txt', 5, 16, 5,
   180.73,
   65.2,
   42.53,
   28.28,
   5.717);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 180.52 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 181.58 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 184.58 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 180.16 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 176.81 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 63 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 66 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 63 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 63 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 71 AS overhead_messages FROM __exp
);


-- t3m_5nodes_16txpb_5rounds_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', 't3m_5nodes_16txpb_5rounds_RSA.txt', 5, 16, 5,
   75.63,
   98.4,
   49.95,
   28.59,
   4.748);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 76.09 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 75.50 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 75.70 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 75.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 75.83 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 77 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 101 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 103 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 107 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 104 AS overhead_messages FROM __exp
);


-- t3m_5nodes_32txpb_5rounds_MERKLE.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('MERKLE', 't3m_5nodes_32txpb_5rounds_MERKLE.txt', 5, 32, 5,
   228.49,
   64.6,
   34.95,
   28.27,
   5.576);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 229.35 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 228.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 226.25 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 231.71 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 226.35 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 70 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 69 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 59 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 70 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 55 AS overhead_messages FROM __exp
);


-- t3m_5nodes_32txpb_5rounds_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', 't3m_5nodes_32txpb_5rounds_RSA.txt', 5, 32, 5,
   203.55,
   85.0,
   42.41,
   28.4,
   4.391);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 201.53 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 203.66 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 202.46 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 206.13 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 203.96 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 96 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 95 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 93 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 50 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 91 AS overhead_messages FROM __exp
);


-- t3m_5nodes_512txpb_16rounds_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', 't3m_5nodes_512txpb_16rounds_RSA.txt', 5, 512, 16,
   414.65,
   207.8,
   43.0,
   29.19,
   26.026);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 414.80 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 410.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 421.85 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 413.13 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 412.83 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 198 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 224 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 174 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 232 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 211 AS overhead_messages FROM __exp
);


-- t3m_5nodes_64txpb_5rounds_MERKLE.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('MERKLE', 't3m_5nodes_64txpb_5rounds_MERKLE.txt', 5, 64, 5,
   296.89,
   63.4,
   51.98,
   28.21,
   5.537);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 299.90 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 294.01 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 294.46 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 291.75 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 304.34 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 63 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 65 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 62 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 63 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 64 AS overhead_messages FROM __exp
);


-- t3m_5nodes_64txpb_5rounds_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', 't3m_5nodes_64txpb_5rounds_RSA.txt', 5, 64, 5,
   404.31,
   79.2,
   38.34,
   28.31,
   5.647);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 403.58 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 412.96 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 406.16 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 403.42 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 395.44 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 85 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 86 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 78 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 77 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 70 AS overhead_messages FROM __exp
);

