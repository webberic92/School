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

-- 16nodes_1024txpb_16rounds_MERKLE.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('MERKLE', '16nodes_1024txpb_16rounds_MERKLE.txt', 16, 1024, 16,
   36.97,
   711.5,
   47.5,
   25.22,
   480.372);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 36.74 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 36.79 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 36.66 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 36.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 36.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 37.01 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 37.31 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 36.59 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 37.23 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 36.70 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 36.93 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 37.20 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 37.59 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 37.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 36.90 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 37.01 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 743 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 616 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 706 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 743 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 695 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 728 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 750 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 763 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 713 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 728 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 709 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 666 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 691 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 691 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 717 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 725 AS overhead_messages FROM __exp
);


-- 16nodes_1024txpb_16rounds_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', '16nodes_1024txpb_16rounds_RSA.txt', 16, 1024, 16,
   94.72,
   846.31,
   20.52,
   13.87,
   186.788);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 94.43 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 93.95 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 94.21 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 94.04 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 96.42 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 95.07 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 94.38 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 94.19 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 94.38 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 94.42 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 94.63 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 94.88 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 94.18 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 95.57 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 93.76 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 97.03 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 805 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 867 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 761 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 894 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 789 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 869 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 898 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 826 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 868 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 879 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 849 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 837 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 866 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 858 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 848 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 827 AS overhead_messages FROM __exp
);


-- 32nodes_1024txpb_16rounds_MERKLE.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('MERKLE', '32nodes_1024txpb_16rounds_MERKLE.txt', 32, 1024, 16,
   8.52,
   2172.6,
   60.11,
   60.08,
   2065.805);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 8.51 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 8.52 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 8.59 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 8.53 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 8.54 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 8.50 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 8.54 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 8.51 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 8.54 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 8.51 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 8.48 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 8.52 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 8.56 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 8.49 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 8.52 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 8.51 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 8.56 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 8.56 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 8.49 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 8.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 8.53 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 8.55 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 8.52 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 8.54 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 8.48 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 8.55 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 8.54 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 8.51 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 8.53 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 8.51 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 2293 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 2045 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 2250 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 2022 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 2215 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 2228 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 1966 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 2114 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 2093 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 2195 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 1952 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 2027 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 2238 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 2262 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 2234 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 2046 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 2237 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 2196 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 2249 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 2203 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 2262 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 2111 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 2173 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 2203 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 2287 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 2175 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 2202 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 2177 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 2379 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 2144 AS overhead_messages FROM __exp
);


-- 32nodes_1024txpb_16rounds_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', '32nodes_1024txpb_16rounds_RSA.txt', 32, 1024, 16,
   44.9,
   1695.03,
   21.57,
   19.99,
   398.377);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 44.67 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 44.89 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 45.16 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 44.95 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 45.15 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 44.93 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 44.78 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 44.86 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 44.93 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-18' AS node_id, 44.67 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 45.18 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 44.57 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 45.38 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 44.58 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 44.57 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 44.62 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 44.85 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 44.91 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 44.89 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 44.66 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 45.67 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 45.10 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 45.23 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 45.66 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 44.72 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 44.42 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 44.63 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 44.85 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 44.76 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 44.97 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 45.44 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 44.25 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 1644 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 1728 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 1755 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 1731 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 1644 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 1796 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 1624 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 1537 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 1757 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-18' AS node_id, 1748 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 1734 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 1739 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 1726 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 1714 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 1623 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 1589 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 1714 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 1712 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 1733 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 1761 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 1715 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 1741 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 1798 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 1657 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 1728 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 1592 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 1570 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 1702 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 1711 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 1706 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 1649 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 1663 AS overhead_messages FROM __exp
);


-- 5nodes_1024txpb_16rounds_MERKLE.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('MERKLE', '5nodes_1024txpb_16rounds_MERKLE.txt', 5, 1024, 16,
   262.02,
   184.8,
   31.64,
   13.32,
   68.894);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 263.07 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 260.56 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 261.67 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 262.48 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 262.30 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 179 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 177 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 191 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 188 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 189 AS overhead_messages FROM __exp
);


-- 5nodes_1024txpb_16rounds_NEED_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', '5nodes_1024txpb_16rounds_NEED_RSA.txt', 5, 1024, 16,
   NULL,
   NULL,
   NULL,
   NULL,
   NULL);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());


-- 8nodes_1024txpb_16rounds_MERKLE.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('MERKLE', '8nodes_1024txpb_16rounds_MERKLE.txt', 8, 1024, 16,
   126.86,
   322.5,
   40.17,
   16.19,
   142.795);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 125.86 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 126.99 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 127.11 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 125.66 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 127.28 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 127.67 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 126.72 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 127.57 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 326 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 316 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 315 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 333 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 333 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 311 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 328 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 318 AS overhead_messages FROM __exp
);


-- 8nodes_1024txpb_16rounds_NEED_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', '8nodes_1024txpb_16rounds_NEED_RSA.txt', 8, 1024, 16,
   NULL,
   NULL,
   NULL,
   NULL,
   NULL);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

