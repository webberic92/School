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


-- 32nodes_1024txpb_16rounds_MERKLE.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('MERKLE', '32nodes_1024txpb_16rounds_MERKLE.txt', 32, 1024, 16, 
   8.52, 
   2172.6,
   60.11,
   60.08,
   2065.805)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 8.51),
    (experiment_id, 'node-10', 8.52),
    (experiment_id, 'node-11', 8.59),
    (experiment_id, 'node-12', 8.53),
    (experiment_id, 'node-13', 8.54),
    (experiment_id, 'node-14', 8.50),
    (experiment_id, 'node-15', 8.54),
    (experiment_id, 'node-16', 8.51),
    (experiment_id, 'node-17', 8.54),
    (experiment_id, 'node-19', 8.51),
    (experiment_id, 'node-2', 8.48),
    (experiment_id, 'node-20', 8.52),
    (experiment_id, 'node-21', 8.56),
    (experiment_id, 'node-22', 8.49),
    (experiment_id, 'node-23', 8.52),
    (experiment_id, 'node-24', 8.51),
    (experiment_id, 'node-25', 8.56),
    (experiment_id, 'node-26', 8.56),
    (experiment_id, 'node-27', 8.49),
    (experiment_id, 'node-28', 8.47),
    (experiment_id, 'node-29', 8.53),
    (experiment_id, 'node-3', 8.55),
    (experiment_id, 'node-30', 8.52),
    (experiment_id, 'node-31', 8.54),
    (experiment_id, 'node-32', 8.48),
    (experiment_id, 'node-4', 8.55),
    (experiment_id, 'node-5', 8.54),
    (experiment_id, 'node-6', 8.51),
    (experiment_id, 'node-7', 8.53),
    (experiment_id, 'node-8', 8.51);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 2293),
    (experiment_id, 'node-10', 2045),
    (experiment_id, 'node-11', 2250),
    (experiment_id, 'node-12', 2022),
    (experiment_id, 'node-13', 2215),
    (experiment_id, 'node-14', 2228),
    (experiment_id, 'node-15', 1966),
    (experiment_id, 'node-16', 2114),
    (experiment_id, 'node-17', 2093),
    (experiment_id, 'node-19', 2195),
    (experiment_id, 'node-2', 1952),
    (experiment_id, 'node-20', 2027),
    (experiment_id, 'node-21', 2238),
    (experiment_id, 'node-22', 2262),
    (experiment_id, 'node-23', 2234),
    (experiment_id, 'node-24', 2046),
    (experiment_id, 'node-25', 2237),
    (experiment_id, 'node-26', 2196),
    (experiment_id, 'node-27', 2249),
    (experiment_id, 'node-28', 2203),
    (experiment_id, 'node-29', 2262),
    (experiment_id, 'node-3', 2111),
    (experiment_id, 'node-30', 2173),
    (experiment_id, 'node-31', 2203),
    (experiment_id, 'node-32', 2287),
    (experiment_id, 'node-4', 2175),
    (experiment_id, 'node-5', 2202),
    (experiment_id, 'node-6', 2177),
    (experiment_id, 'node-7', 2379),
    (experiment_id, 'node-8', 2144);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 55.67, 54.63),
    (experiment_id, 'node-10', 64.60, 63.43),
    (experiment_id, 'node-11', 60.43, 60.84),
    (experiment_id, 'node-12', 60.85, 58.21),
    (experiment_id, 'node-13', 55.76, 55.03),
    (experiment_id, 'node-14', 58.41, 57.59),
    (experiment_id, 'node-15', 63.60, 62.83),
    (experiment_id, 'node-16', 60.17, 57.67),
    (experiment_id, 'node-17', 60.56, 56.96),
    (experiment_id, 'node-19', 59.73, 59.82),
    (experiment_id, 'node-2', 64.84, 62.49),
    (experiment_id, 'node-20', 58.77, 60.43),
    (experiment_id, 'node-21', 60.28, 62.64),
    (experiment_id, 'node-22', 56.99, 56.69),
    (experiment_id, 'node-23', 58.43, 60.66),
    (experiment_id, 'node-24', 64.59, 63.25),
    (experiment_id, 'node-25', 58.45, 59.60),
    (experiment_id, 'node-26', 57.31, 59.95),
    (experiment_id, 'node-27', 59.55, 58.11),
    (experiment_id, 'node-28', 59.57, 60.50),
    (experiment_id, 'node-29', 60.98, 61.01),
    (experiment_id, 'node-3', 63.72, 61.47),
    (experiment_id, 'node-30', 61.28, 62.33),
    (experiment_id, 'node-31', 62.49, 62.79),
    (experiment_id, 'node-32', 60.26, 60.39),
    (experiment_id, 'node-4', 53.53, 58.72),
    (experiment_id, 'node-5', 59.79, 61.42),
    (experiment_id, 'node-6', 62.06, 57.14),
    (experiment_id, 'node-7', 58.95, 59.78),
    (experiment_id, 'node-8', 61.79, 66.22);
END $$;


-- 5nodes_1024txpb_16rounds_MERKLE.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('MERKLE', '5nodes_1024txpb_16rounds_MERKLE.txt', 5, 1024, 16, 
   262.02, 
   184.8,
   31.64,
   13.32,
   68.894)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 263.07),
    (experiment_id, 'node-2', 260.56),
    (experiment_id, 'node-3', 261.67),
    (experiment_id, 'node-4', 262.48),
    (experiment_id, 'node-5', 262.30);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 179),
    (experiment_id, 'node-2', 177),
    (experiment_id, 'node-3', 191),
    (experiment_id, 'node-4', 188),
    (experiment_id, 'node-5', 189);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 30.74, 13.24),
    (experiment_id, 'node-2', 32.07, 13.32),
    (experiment_id, 'node-3', 30.01, 13.27),
    (experiment_id, 'node-4', 33.90, 13.46),
    (experiment_id, 'node-5', 31.50, 13.32);
END $$;


-- 5nodes_128txpb_16rounds_MERKLE.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('MERKLE', '5nodes_128txpb_16rounds_MERKLE.txt', 5, 128, 16, 
   374.5, 
   191.8,
   18.35,
   10.84,
   11.179)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 373.74),
    (experiment_id, 'node-2', 373.39),
    (experiment_id, 'node-3', 376.68),
    (experiment_id, 'node-4', 371.72),
    (experiment_id, 'node-5', 376.95);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 197),
    (experiment_id, 'node-2', 188),
    (experiment_id, 'node-3', 191),
    (experiment_id, 'node-4', 188),
    (experiment_id, 'node-5', 195);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 27.56, 10.85),
    (experiment_id, 'node-2', 17.15, 10.84),
    (experiment_id, 'node-3', 19.38, 10.78),
    (experiment_id, 'node-4', 14.18, 10.88),
    (experiment_id, 'node-5', 13.52, 10.85);
END $$;


-- 5nodes_512txpb_16rounds_MERKLE.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('MERKLE', '5nodes_512txpb_16rounds_MERKLE.txt', 5, 512, 16, 
   320.9, 
   185.6,
   29.09,
   11.81,
   32.743)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 321.41),
    (experiment_id, 'node-2', 319.03),
    (experiment_id, 'node-3', 323.33),
    (experiment_id, 'node-4', 320.96),
    (experiment_id, 'node-5', 319.75);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 186),
    (experiment_id, 'node-2', 180),
    (experiment_id, 'node-3', 187),
    (experiment_id, 'node-4', 185),
    (experiment_id, 'node-5', 190);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 28.29, 11.79),
    (experiment_id, 'node-2', 27.37, 11.81),
    (experiment_id, 'node-3', 28.69, 11.75),
    (experiment_id, 'node-4', 30.62, 11.88),
    (experiment_id, 'node-5', 30.50, 11.86);
END $$;


-- 5nodes_5txpb_16rounds_MERKLE.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('MERKLE', '5nodes_5txpb_16rounds_MERKLE.txt', 5, 5, 16, 
   70.97, 
   190.4,
   17.0,
   10.67,
   5.279)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 70.87),
    (experiment_id, 'node-2', 71.23),
    (experiment_id, 'node-3', 71.22),
    (experiment_id, 'node-4', 70.85),
    (experiment_id, 'node-5', 70.66);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 191),
    (experiment_id, 'node-2', 193),
    (experiment_id, 'node-3', 185),
    (experiment_id, 'node-4', 188),
    (experiment_id, 'node-5', 195);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 25.46, 10.65),
    (experiment_id, 'node-2', 16.54, 10.62),
    (experiment_id, 'node-3', 11.98, 10.72),
    (experiment_id, 'node-4', 13.31, 10.73),
    (experiment_id, 'node-5', 17.76, 10.63);
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


-- 32nodes_1024txpb_16rounds_RSA.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('RSA', '32nodes_1024txpb_16rounds_RSA.txt', 32, 1024, 16, 
   45.93, 
   1694.0,
   21.51,
   19.12,
   392.993)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 45.94),
    (experiment_id, 'node-10', 46.25),
    (experiment_id, 'node-11', 45.61),
    (experiment_id, 'node-12', 45.82),
    (experiment_id, 'node-13', 45.65),
    (experiment_id, 'node-14', 46.16),
    (experiment_id, 'node-15', 45.19),
    (experiment_id, 'node-16', 46.05),
    (experiment_id, 'node-17', 46.14),
    (experiment_id, 'node-18', 46.01),
    (experiment_id, 'node-19', 46.04),
    (experiment_id, 'node-2', 46.39),
    (experiment_id, 'node-20', 45.89),
    (experiment_id, 'node-21', 46.51),
    (experiment_id, 'node-22', 46.27),
    (experiment_id, 'node-23', 46.26),
    (experiment_id, 'node-24', 45.67),
    (experiment_id, 'node-25', 45.79),
    (experiment_id, 'node-26', 45.89),
    (experiment_id, 'node-27', 45.59),
    (experiment_id, 'node-28', 46.15),
    (experiment_id, 'node-29', 45.80),
    (experiment_id, 'node-3', 45.52),
    (experiment_id, 'node-30', 46.49),
    (experiment_id, 'node-31', 45.58),
    (experiment_id, 'node-32', 45.83),
    (experiment_id, 'node-4', 46.44),
    (experiment_id, 'node-5', 45.25),
    (experiment_id, 'node-6', 46.19),
    (experiment_id, 'node-7', 45.00),
    (experiment_id, 'node-8', 46.31),
    (experiment_id, 'node-9', 45.95);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 1638),
    (experiment_id, 'node-10', 1723),
    (experiment_id, 'node-11', 1699),
    (experiment_id, 'node-12', 1636),
    (experiment_id, 'node-13', 1778),
    (experiment_id, 'node-14', 1744),
    (experiment_id, 'node-15', 1654),
    (experiment_id, 'node-16', 1693),
    (experiment_id, 'node-17', 1700),
    (experiment_id, 'node-18', 1682),
    (experiment_id, 'node-19', 1709),
    (experiment_id, 'node-2', 1655),
    (experiment_id, 'node-20', 1738),
    (experiment_id, 'node-21', 1746),
    (experiment_id, 'node-22', 1733),
    (experiment_id, 'node-23', 1734),
    (experiment_id, 'node-24', 1603),
    (experiment_id, 'node-25', 1668),
    (experiment_id, 'node-26', 1739),
    (experiment_id, 'node-27', 1748),
    (experiment_id, 'node-28', 1591),
    (experiment_id, 'node-29', 1751),
    (experiment_id, 'node-3', 1720),
    (experiment_id, 'node-30', 1755),
    (experiment_id, 'node-31', 1723),
    (experiment_id, 'node-32', 1630),
    (experiment_id, 'node-4', 1701),
    (experiment_id, 'node-5', 1505),
    (experiment_id, 'node-6', 1723),
    (experiment_id, 'node-7', 1777),
    (experiment_id, 'node-8', 1656),
    (experiment_id, 'node-9', 1656);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 24.86, 19.73),
    (experiment_id, 'node-10', 21.04, 18.30),
    (experiment_id, 'node-11', 21.12, 18.49),
    (experiment_id, 'node-12', 18.02, 18.20),
    (experiment_id, 'node-13', 21.97, 18.69),
    (experiment_id, 'node-14', 18.00, 19.68),
    (experiment_id, 'node-15', 26.97, 19.35),
    (experiment_id, 'node-16', 20.56, 19.29),
    (experiment_id, 'node-17', 21.89, 20.15),
    (experiment_id, 'node-18', 18.73, 19.29),
    (experiment_id, 'node-19', 19.82, 18.72),
    (experiment_id, 'node-2', 20.91, 18.80),
    (experiment_id, 'node-20', 19.34, 19.93),
    (experiment_id, 'node-21', 23.44, 19.45),
    (experiment_id, 'node-22', 19.04, 18.42),
    (experiment_id, 'node-23', 24.85, 18.75),
    (experiment_id, 'node-24', 19.76, 19.83),
    (experiment_id, 'node-25', 20.69, 18.98),
    (experiment_id, 'node-26', 19.65, 18.78),
    (experiment_id, 'node-27', 20.94, 19.16),
    (experiment_id, 'node-28', 24.56, 19.11),
    (experiment_id, 'node-29', 18.95, 18.96),
    (experiment_id, 'node-3', 22.55, 18.74),
    (experiment_id, 'node-30', 20.99, 19.49),
    (experiment_id, 'node-31', 25.96, 19.72),
    (experiment_id, 'node-32', 18.03, 18.87),
    (experiment_id, 'node-4', 21.86, 20.48),
    (experiment_id, 'node-5', 26.03, 18.03),
    (experiment_id, 'node-6', 23.08, 18.60),
    (experiment_id, 'node-7', 23.79, 19.44),
    (experiment_id, 'node-8', 21.51, 19.29),
    (experiment_id, 'node-9', 19.65, 19.28);
END $$;


-- 5nodes_1024txpb_16rounds_RSA.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('RSA', '5nodes_1024txpb_16rounds_RSA.txt', 5, 1024, 16, 
   570.39, 
   195.4,
   24.58,
   11.42,
   34.797)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 554.90),
    (experiment_id, 'node-2', 571.95),
    (experiment_id, 'node-3', 569.12),
    (experiment_id, 'node-4', 589.78),
    (experiment_id, 'node-5', 566.19);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 171),
    (experiment_id, 'node-2', 178),
    (experiment_id, 'node-3', 233),
    (experiment_id, 'node-4', 177),
    (experiment_id, 'node-5', 218);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 21.97, 11.44),
    (experiment_id, 'node-2', 22.71, 11.41),
    (experiment_id, 'node-3', 20.34, 11.44),
    (experiment_id, 'node-4', 34.86, 11.34),
    (experiment_id, 'node-5', 23.03, 11.51);
END $$;


-- 5nodes_128txpb_16rounds_RSA.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('RSA', '5nodes_128txpb_16rounds_RSA.txt', 5, 128, 16, 
   579.04, 
   207.8,
   16.85,
   10.74,
   8.541)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 579.17),
    (experiment_id, 'node-2', 578.85),
    (experiment_id, 'node-3', 579.30),
    (experiment_id, 'node-4', 578.75),
    (experiment_id, 'node-5', 579.14);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 217),
    (experiment_id, 'node-2', 204),
    (experiment_id, 'node-3', 208),
    (experiment_id, 'node-4', 206),
    (experiment_id, 'node-5', 204);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 23.45, 10.54),
    (experiment_id, 'node-2', 12.81, 11.02),
    (experiment_id, 'node-3', 13.18, 10.77),
    (experiment_id, 'node-4', 18.42, 10.69),
    (experiment_id, 'node-5', 16.43, 10.71);
END $$;


-- 5nodes_512txpb_16rounds_RSA.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('RSA', '5nodes_512txpb_16rounds_RSA.txt', 5, 512, 16, 
   463.15, 
   195.6,
   24.07,
   11.04,
   24.762)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 470.08),
    (experiment_id, 'node-2', 454.33),
    (experiment_id, 'node-3', 454.65),
    (experiment_id, 'node-4', 481.60),
    (experiment_id, 'node-5', 455.07);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 175),
    (experiment_id, 'node-2', 226),
    (experiment_id, 'node-3', 221),
    (experiment_id, 'node-4', 129),
    (experiment_id, 'node-5', 227);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 21.11, 11.02),
    (experiment_id, 'node-2', 18.23, 11.06),
    (experiment_id, 'node-3', 16.04, 11.04),
    (experiment_id, 'node-4', 47.07, 11.07),
    (experiment_id, 'node-5', 17.92, 11.03);
END $$;


-- 5nodes_5txpb_16rounds_RSA.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('RSA', '5nodes_5txpb_16rounds_RSA.txt', 5, 5, 16, 
   91.04, 
   234.4,
   20.85,
   10.57,
   5.609)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 90.07),
    (experiment_id, 'node-2', 90.63),
    (experiment_id, 'node-3', 90.66),
    (experiment_id, 'node-4', 91.73),
    (experiment_id, 'node-5', 92.09);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 235),
    (experiment_id, 'node-2', 234),
    (experiment_id, 'node-3', 229),
    (experiment_id, 'node-4', 237),
    (experiment_id, 'node-5', 237);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 18.37, 10.60),
    (experiment_id, 'node-2', 21.91, 10.57),
    (experiment_id, 'node-3', 24.56, 10.59),
    (experiment_id, 'node-4', 20.12, 10.57),
    (experiment_id, 'node-5', 19.31, 10.57);
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

