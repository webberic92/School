-- Drop and create schema
DROP TABLE IF EXISTS node_tps, node_overhead, node_resource_utilization, experiment_summary CASCADE;

CREATE TABLE experiment_summary (
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

CREATE TABLE node_tps (
    id SERIAL PRIMARY KEY,
    experiment_id INTEGER NOT NULL REFERENCES experiment_summary(id),
    node_id TEXT NOT NULL,
    tps REAL
);

CREATE TABLE node_overhead (
    id SERIAL PRIMARY KEY,
    experiment_id INTEGER NOT NULL REFERENCES experiment_summary(id),
    node_id TEXT NOT NULL,
    overhead_messages INTEGER
);

CREATE TABLE node_resource_utilization (
    id SERIAL PRIMARY KEY,
    experiment_id INTEGER NOT NULL REFERENCES experiment_summary(id),
    node_id TEXT NOT NULL,
    cpu_util REAL,
    mem_util REAL
);

-- Optional truncation for repeatable runs
-- TRUNCATE TABLE node_tps, node_overhead, node_resource_utilization, experiment_summary RESTART IDENTITY CASCADE;


-- 12nodes_256txpb_16rounds_MERKLE.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('MERKLE', '12nodes_256txpb_16rounds_MERKLE.txt', 12, 256, 16, 
   81.03, 
   452.75,
   38.79,
   12.58,
   58.526)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 81.57),
    (experiment_id, 'node-10', 80.73),
    (experiment_id, 'node-11', 81.84),
    (experiment_id, 'node-12', 80.41),
    (experiment_id, 'node-2', 80.45),
    (experiment_id, 'node-3', 80.40),
    (experiment_id, 'node-4', 81.62),
    (experiment_id, 'node-5', 80.41),
    (experiment_id, 'node-6', 81.33),
    (experiment_id, 'node-7', 81.32),
    (experiment_id, 'node-8', 80.49),
    (experiment_id, 'node-9', 81.79);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 473),
    (experiment_id, 'node-10', 458),
    (experiment_id, 'node-11', 448),
    (experiment_id, 'node-12', 427),
    (experiment_id, 'node-2', 449),
    (experiment_id, 'node-3', 469),
    (experiment_id, 'node-4', 465),
    (experiment_id, 'node-5', 451),
    (experiment_id, 'node-6', 460),
    (experiment_id, 'node-7', 476),
    (experiment_id, 'node-8', 425),
    (experiment_id, 'node-9', 432);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 43.90, 12.79),
    (experiment_id, 'node-10', 39.19, 12.57),
    (experiment_id, 'node-11', 37.16, 12.52),
    (experiment_id, 'node-12', 37.79, 12.55),
    (experiment_id, 'node-2', 37.36, 12.64),
    (experiment_id, 'node-3', 39.82, 12.58),
    (experiment_id, 'node-4', 39.26, 12.62),
    (experiment_id, 'node-5', 35.84, 12.55),
    (experiment_id, 'node-6', 38.83, 12.62),
    (experiment_id, 'node-7', 36.48, 12.53),
    (experiment_id, 'node-8', 44.38, 12.59),
    (experiment_id, 'node-9', 35.53, 12.45);
END $$;


-- 16nodes_1024txpb_16rounds_MERKLE.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('MERKLE', '16nodes_1024txpb_16rounds_MERKLE.txt', 16, 1024, 16, 
   36.97, 
   711.5,
   47.5,
   25.22,
   480.372)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 36.74),
    (experiment_id, 'node-10', 36.79),
    (experiment_id, 'node-11', 36.66),
    (experiment_id, 'node-12', 36.65),
    (experiment_id, 'node-13', 36.81),
    (experiment_id, 'node-14', 37.01),
    (experiment_id, 'node-15', 37.31),
    (experiment_id, 'node-16', 36.59),
    (experiment_id, 'node-2', 37.23),
    (experiment_id, 'node-3', 36.70),
    (experiment_id, 'node-4', 36.93),
    (experiment_id, 'node-5', 37.20),
    (experiment_id, 'node-6', 37.59),
    (experiment_id, 'node-7', 37.47),
    (experiment_id, 'node-8', 36.90),
    (experiment_id, 'node-9', 37.01);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 743),
    (experiment_id, 'node-10', 616),
    (experiment_id, 'node-11', 706),
    (experiment_id, 'node-12', 743),
    (experiment_id, 'node-13', 695),
    (experiment_id, 'node-14', 728),
    (experiment_id, 'node-15', 750),
    (experiment_id, 'node-16', 763),
    (experiment_id, 'node-2', 713),
    (experiment_id, 'node-3', 728),
    (experiment_id, 'node-4', 709),
    (experiment_id, 'node-5', 666),
    (experiment_id, 'node-6', 691),
    (experiment_id, 'node-7', 691),
    (experiment_id, 'node-8', 717),
    (experiment_id, 'node-9', 725);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 45.12, 24.86),
    (experiment_id, 'node-10', 55.87, 26.52),
    (experiment_id, 'node-11', 42.43, 24.58),
    (experiment_id, 'node-12', 43.14, 24.74),
    (experiment_id, 'node-13', 46.27, 25.37),
    (experiment_id, 'node-14', 46.00, 25.05),
    (experiment_id, 'node-15', 49.30, 25.30),
    (experiment_id, 'node-16', 47.74, 25.43),
    (experiment_id, 'node-2', 46.34, 24.96),
    (experiment_id, 'node-3', 45.77, 25.06),
    (experiment_id, 'node-4', 46.14, 24.42),
    (experiment_id, 'node-5', 52.33, 26.71),
    (experiment_id, 'node-6', 47.04, 25.07),
    (experiment_id, 'node-7', 50.65, 25.23),
    (experiment_id, 'node-8', 48.06, 25.32),
    (experiment_id, 'node-9', 47.82, 24.98);
END $$;


-- 8nodes_128txpb_16rounds_MERKLE.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('MERKLE', '8nodes_128txpb_16rounds_MERKLE.txt', 8, 128, 16, 
   185.85, 
   310.12,
   31.0,
   11.07,
   17.41)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 187.21),
    (experiment_id, 'node-2', 187.66),
    (experiment_id, 'node-3', 187.57),
    (experiment_id, 'node-4', 185.22),
    (experiment_id, 'node-5', 183.64),
    (experiment_id, 'node-6', 185.71),
    (experiment_id, 'node-7', 184.15),
    (experiment_id, 'node-8', 185.61);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 302),
    (experiment_id, 'node-2', 306),
    (experiment_id, 'node-3', 323),
    (experiment_id, 'node-4', 321),
    (experiment_id, 'node-5', 310),
    (experiment_id, 'node-6', 299),
    (experiment_id, 'node-7', 307),
    (experiment_id, 'node-8', 313);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 34.36, 11.10),
    (experiment_id, 'node-2', 32.16, 11.04),
    (experiment_id, 'node-3', 28.39, 11.06),
    (experiment_id, 'node-4', 26.86, 11.03),
    (experiment_id, 'node-5', 31.50, 11.06),
    (experiment_id, 'node-6', 33.76, 11.22),
    (experiment_id, 'node-7', 31.22, 11.06),
    (experiment_id, 'node-8', 29.78, 11.06);
END $$;


-- 12nodes_256txpb_16rounds_RSA.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('RSA', '12nodes_256txpb_16rounds_RSA.txt', 12, 256, 16, 
   234.42, 
   570.83,
   21.23,
   11.04,
   23.56)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 250.28),
    (experiment_id, 'node-10', 235.37),
    (experiment_id, 'node-11', 235.16),
    (experiment_id, 'node-12', 234.27),
    (experiment_id, 'node-2', 232.52),
    (experiment_id, 'node-3', 230.34),
    (experiment_id, 'node-4', 234.21),
    (experiment_id, 'node-5', 229.57),
    (experiment_id, 'node-6', 232.26),
    (experiment_id, 'node-7', 233.02),
    (experiment_id, 'node-8', 231.77),
    (experiment_id, 'node-9', 234.30);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 503),
    (experiment_id, 'node-10', 575),
    (experiment_id, 'node-11', 540),
    (experiment_id, 'node-12', 574),
    (experiment_id, 'node-2', 590),
    (experiment_id, 'node-3', 597),
    (experiment_id, 'node-4', 601),
    (experiment_id, 'node-5', 535),
    (experiment_id, 'node-6', 556),
    (experiment_id, 'node-7', 612),
    (experiment_id, 'node-8', 621),
    (experiment_id, 'node-9', 546);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 24.35, 11.02),
    (experiment_id, 'node-10', 20.36, 11.04),
    (experiment_id, 'node-11', 21.13, 11.05),
    (experiment_id, 'node-12', 23.33, 11.05),
    (experiment_id, 'node-2', 21.16, 11.01),
    (experiment_id, 'node-3', 17.45, 11.05),
    (experiment_id, 'node-4', 18.52, 10.97),
    (experiment_id, 'node-5', 23.82, 11.10),
    (experiment_id, 'node-6', 22.26, 11.07),
    (experiment_id, 'node-7', 19.59, 11.02),
    (experiment_id, 'node-8', 20.92, 11.10),
    (experiment_id, 'node-9', 21.93, 11.00);
END $$;


-- 16nodes_1024txpb_16rounds_RSA.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('RSA', '16nodes_1024txpb_16rounds_RSA.txt', 16, 1024, 16, 
   37.03, 
   726.81,
   48.04,
   25.28,
   476.765)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 37.16),
    (experiment_id, 'node-10', 36.89),
    (experiment_id, 'node-11', 37.09),
    (experiment_id, 'node-12', 37.05),
    (experiment_id, 'node-13', 37.23),
    (experiment_id, 'node-14', 37.61),
    (experiment_id, 'node-15', 36.90),
    (experiment_id, 'node-16', 36.81),
    (experiment_id, 'node-2', 37.47),
    (experiment_id, 'node-3', 37.23),
    (experiment_id, 'node-4', 36.97),
    (experiment_id, 'node-5', 36.72),
    (experiment_id, 'node-6', 37.04),
    (experiment_id, 'node-7', 36.84),
    (experiment_id, 'node-8', 36.73),
    (experiment_id, 'node-9', 36.73);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 712),
    (experiment_id, 'node-10', 748),
    (experiment_id, 'node-11', 700),
    (experiment_id, 'node-12', 742),
    (experiment_id, 'node-13', 726),
    (experiment_id, 'node-14', 733),
    (experiment_id, 'node-15', 712),
    (experiment_id, 'node-16', 766),
    (experiment_id, 'node-2', 639),
    (experiment_id, 'node-3', 753),
    (experiment_id, 'node-4', 753),
    (experiment_id, 'node-5', 698),
    (experiment_id, 'node-6', 757),
    (experiment_id, 'node-7', 758),
    (experiment_id, 'node-8', 716),
    (experiment_id, 'node-9', 716);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 46.76, 25.10),
    (experiment_id, 'node-10', 46.93, 25.12),
    (experiment_id, 'node-11', 51.56, 25.44),
    (experiment_id, 'node-12', 45.23, 24.61),
    (experiment_id, 'node-13', 46.33, 24.84),
    (experiment_id, 'node-14', 46.52, 25.82),
    (experiment_id, 'node-15', 46.00, 25.33),
    (experiment_id, 'node-16', 49.11, 25.65),
    (experiment_id, 'node-2', 53.17, 25.66),
    (experiment_id, 'node-3', 48.54, 25.22),
    (experiment_id, 'node-4', 51.15, 25.33),
    (experiment_id, 'node-5', 49.98, 25.56),
    (experiment_id, 'node-6', 46.49, 24.96),
    (experiment_id, 'node-7', 48.23, 25.44),
    (experiment_id, 'node-8', 46.63, 25.42),
    (experiment_id, 'node-9', 46.14, 25.00);
END $$;


-- 8nodes_128txpb_16rounds_RSA.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('RSA', '8nodes_128txpb_16rounds_RSA.txt', 8, 128, 16, 
   401.95, 
   379.37,
   17.02,
   10.78,
   10.228)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 399.92),
    (experiment_id, 'node-2', 402.07),
    (experiment_id, 'node-3', 397.36),
    (experiment_id, 'node-4', 405.90),
    (experiment_id, 'node-5', 403.85),
    (experiment_id, 'node-6', 402.79),
    (experiment_id, 'node-7', 403.23),
    (experiment_id, 'node-8', 400.49);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 411),
    (experiment_id, 'node-2', 403),
    (experiment_id, 'node-3', 244),
    (experiment_id, 'node-4', 413),
    (experiment_id, 'node-5', 389),
    (experiment_id, 'node-6', 389),
    (experiment_id, 'node-7', 382),
    (experiment_id, 'node-8', 404);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 15.06, 10.82),
    (experiment_id, 'node-2', 17.02, 10.72),
    (experiment_id, 'node-3', 29.98, 10.85),
    (experiment_id, 'node-4', 13.83, 10.82),
    (experiment_id, 'node-5', 17.41, 10.77),
    (experiment_id, 'node-6', 13.05, 10.79),
    (experiment_id, 'node-7', 14.00, 10.83),
    (experiment_id, 'node-8', 15.84, 10.72);
END $$;

