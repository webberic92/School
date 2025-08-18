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

-- 12nodes_128txpb_16rounds_MERKLE.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('MERKLE', '12nodes_128txpb_16rounds_MERKLE.txt', 12, 128, 16,
   67.27,
   441.66,
   39.7,
   11.83,
   37.719);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 67.51 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 67.17 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 68.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 67.53 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 67.15 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 67.11 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 67.12 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 66.36 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 68.26 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 67.20 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 66.35 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 67.48 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 422 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 363 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 456 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 463 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 463 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 452 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 429 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 467 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 427 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 433 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 455 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 470 AS overhead_messages FROM __exp
);


-- 12nodes_128txpb_16rounds_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', '12nodes_128txpb_16rounds_RSA.txt', 12, 128, 16,
   116.92,
   549.08,
   22.58,
   11.12,
   23.44);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 116.23 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 117.27 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 116.25 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 116.44 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 116.78 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 114.58 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 116.68 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 116.22 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 118.21 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 120.77 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 116.73 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 116.86 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 519 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 583 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 545 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 577 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 571 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 512 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 578 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 529 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 468 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 548 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 565 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 594 AS overhead_messages FROM __exp
);


-- 12nodes_512txpb_16rounds_MERKLE.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('MERKLE', '12nodes_512txpb_16rounds_MERKLE.txt', 12, 512, 16,
   58.99,
   453.58,
   42.84,
   15.45,
   151.79);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 58.80 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 58.57 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 58.84 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 58.76 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 58.99 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 59.11 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 58.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 59.12 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 59.33 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 59.02 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 59.42 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 59.06 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 480 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 361 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 462 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 465 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 440 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 472 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 464 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 474 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 458 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 461 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 456 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 450 AS overhead_messages FROM __exp
);


-- 12nodes_512txpb_16rounds_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', '12nodes_512txpb_16rounds_RSA.txt', 12, 512, 16,
   120.31,
   533.41,
   23.17,
   11.96,
   77.002);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 118.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 120.82 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 120.34 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 119.95 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 120.44 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 120.21 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 120.50 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 120.26 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 121.35 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 120.56 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 119.90 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 120.92 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 551 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 510 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 499 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 492 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 544 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 603 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 560 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 487 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 519 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 584 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 457 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 595 AS overhead_messages FROM __exp
);


-- 12nodes_5txpb_16rounds_MERKLE.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('MERKLE', '12nodes_5txpb_16rounds_MERKLE.txt', 12, 5, 16,
   31.66,
   447.5,
   20.47,
   10.89,
   8.269);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 31.68 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 31.93 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 31.45 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 31.59 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 31.66 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 31.79 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 31.58 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 31.66 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 31.69 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 31.60 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 31.58 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 31.71 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 446 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 434 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 456 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 461 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 440 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 450 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 431 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 462 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 441 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 448 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 448 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 453 AS overhead_messages FROM __exp
);


-- 12nodes_5txpb_16rounds_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', '12nodes_5txpb_16rounds_RSA.txt', 12, 5, 16,
   60.87,
   595.0,
   22.03,
   10.74,
   3.261);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 61.17 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 60.41 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 61.16 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 60.86 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 60.80 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 60.53 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 60.83 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 60.76 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 60.74 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 61.43 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 60.99 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 60.74 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 587 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 524 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 613 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 608 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 608 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 598 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 631 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 595 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 587 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 576 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 611 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 602 AS overhead_messages FROM __exp
);


-- 5nodes_128txpb_16rounds_MERKLE.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('MERKLE', '5nodes_128txpb_16rounds_MERKLE.txt', 5, 128, 16,
   374.5,
   191.8,
   18.35,
   10.84,
   11.179);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 373.74 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 373.39 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 376.68 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 371.72 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 376.95 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 197 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 188 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 191 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 188 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 195 AS overhead_messages FROM __exp
);


-- 5nodes_128txpb_16rounds_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', '5nodes_128txpb_16rounds_RSA.txt', 5, 128, 16,
   476.13,
   204.8,
   24.04,
   10.85,
   8.361);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 481.31 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 444.21 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 484.01 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 485.71 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 485.40 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 240 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 122 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 236 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 193 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 233 AS overhead_messages FROM __exp
);


-- 5nodes_512txpb_16rounds_MERKLE.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('MERKLE', '5nodes_512txpb_16rounds_MERKLE.txt', 5, 512, 16,
   320.9,
   185.6,
   29.09,
   11.81,
   32.743);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 321.41 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 319.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 323.33 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 320.96 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 319.75 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 186 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 180 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 187 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 185 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 190 AS overhead_messages FROM __exp
);


-- 5nodes_512txpb_16rounds_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', '5nodes_512txpb_16rounds_RSA.txt', 5, 512, 16,
   1094.47,
   186.2,
   23.39,
   11.03,
   17.089);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 689.71 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 688.06 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 1705.13 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 690.78 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 1698.68 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 231 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 226 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 124 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 236 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 114 AS overhead_messages FROM __exp
);


-- 5nodes_5txpb_16rounds_MERKLE.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('MERKLE', '5nodes_5txpb_16rounds_MERKLE.txt', 5, 5, 16,
   70.97,
   190.4,
   17.0,
   10.67,
   5.279);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 70.87 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 71.23 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 71.22 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 70.85 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 70.66 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 191 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 193 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 185 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 188 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 195 AS overhead_messages FROM __exp
);


-- 5nodes_5txpb_16rounds_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', '5nodes_5txpb_16rounds_RSA.txt', 5, 5, 16,
   89.22,
   235.0,
   20.21,
   10.66,
   5.834);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 88.64 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 89.79 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 88.95 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 89.45 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 89.28 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 239 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 235 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 234 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 227 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 240 AS overhead_messages FROM __exp
);


-- 8nodes_128txpb_16rounds_MERKLE.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('MERKLE', '8nodes_128txpb_16rounds_MERKLE.txt', 8, 128, 16,
   185.85,
   310.12,
   31.0,
   11.07,
   17.41);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 187.21 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 187.66 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 187.57 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 185.22 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 183.64 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 185.71 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 184.15 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 185.61 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 302 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 306 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 323 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 321 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 310 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 299 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 307 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 313 AS overhead_messages FROM __exp
);


-- 8nodes_128txpb_16rounds_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', '8nodes_128txpb_16rounds_RSA.txt', 8, 128, 16,
   257.98,
   378.87,
   24.68,
   10.97,
   12.424);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 261.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 256.19 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 258.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 257.23 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 259.06 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 257.06 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 256.86 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 257.29 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 374 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 381 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 391 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 419 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 379 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 374 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 359 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 354 AS overhead_messages FROM __exp
);


-- 8nodes_512txpb_16rounds_MERKLE.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('MERKLE', '8nodes_512txpb_16rounds_MERKLE.txt', 8, 512, 16,
   146.86,
   316.0,
   36.13,
   12.96,
   64.759);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 147.32 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 145.78 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 147.19 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 146.61 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 147.34 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 146.66 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 146.74 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 147.26 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 328 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 329 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 315 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 321 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 305 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 316 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 299 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 315 AS overhead_messages FROM __exp
);


-- 8nodes_512txpb_16rounds_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', '8nodes_512txpb_16rounds_RSA.txt', 8, 512, 16,
   246.73,
   353.12,
   21.74,
   11.5,
   38.482);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 245.00 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 254.74 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 244.87 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 244.61 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 246.51 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 245.66 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 247.06 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 245.35 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 392 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 207 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 399 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 326 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 382 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 382 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 355 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 382 AS overhead_messages FROM __exp
);


-- 8nodes_5txpb_16rounds_MERKLE.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('MERKLE', '8nodes_5txpb_16rounds_MERKLE.txt', 8, 5, 16,
   49.66,
   308.5,
   17.37,
   10.65,
   7.046);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 49.78 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 49.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 49.68 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 49.60 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 49.62 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 49.79 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 49.82 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 49.53 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 305 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 309 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 313 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 305 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 312 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 318 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 301 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 305 AS overhead_messages FROM __exp
);


-- 8nodes_5txpb_16rounds_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', '8nodes_5txpb_16rounds_RSA.txt', 8, 5, 16,
   74.96,
   405.87,
   20.41,
   10.86,
   5.613);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 74.96 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 74.86 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 75.07 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 74.92 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 75.87 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 75.00 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 74.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 74.39 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 402 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 401 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 395 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 404 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 390 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 419 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 419 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 417 AS overhead_messages FROM __exp
);

