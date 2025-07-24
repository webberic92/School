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


-- t3m_16nodes_16txpb_16rounds_MERKLE.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('MERKLE', 't3m_16nodes_16txpb_16rounds_MERKLE.txt', 16, 16, 16, 
   16.0, 
   656.37,
   9.53,
   28.47,
   13.289)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 33.55),
    (experiment_id, 'node-10', 33.39),
    (experiment_id, 'node-11', 33.99),
    (experiment_id, 'node-12', 33.59),
    (experiment_id, 'node-13', 33.54),
    (experiment_id, 'node-14', 33.33),
    (experiment_id, 'node-15', 34.02),
    (experiment_id, 'node-16', 34.10),
    (experiment_id, 'node-2', 34.00),
    (experiment_id, 'node-3', 33.59),
    (experiment_id, 'node-4', 33.65),
    (experiment_id, 'node-5', 33.53),
    (experiment_id, 'node-6', 33.52),
    (experiment_id, 'node-7', 33.93),
    (experiment_id, 'node-8', 33.49),
    (experiment_id, 'node-9', 33.55);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 646),
    (experiment_id, 'node-10', 665),
    (experiment_id, 'node-11', 665),
    (experiment_id, 'node-12', 664),
    (experiment_id, 'node-13', 642),
    (experiment_id, 'node-14', 662),
    (experiment_id, 'node-15', 662),
    (experiment_id, 'node-16', 642),
    (experiment_id, 'node-2', 663),
    (experiment_id, 'node-3', 640),
    (experiment_id, 'node-4', 679),
    (experiment_id, 'node-5', 663),
    (experiment_id, 'node-6', 610),
    (experiment_id, 'node-7', 677),
    (experiment_id, 'node-8', 641),
    (experiment_id, 'node-9', 681);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 9.34, 28.50),
    (experiment_id, 'node-10', 8.99, 28.45),
    (experiment_id, 'node-11', 9.29, 28.55),
    (experiment_id, 'node-12', 9.27, 28.49),
    (experiment_id, 'node-13', 9.86, 28.53),
    (experiment_id, 'node-14', 10.38, 28.44),
    (experiment_id, 'node-15', 8.59, 28.50),
    (experiment_id, 'node-16', 9.24, 28.46),
    (experiment_id, 'node-2', 8.77, 28.41),
    (experiment_id, 'node-3', 9.20, 28.44),
    (experiment_id, 'node-4', 8.98, 28.51),
    (experiment_id, 'node-5', 10.20, 28.40),
    (experiment_id, 'node-6', 10.67, 28.49),
    (experiment_id, 'node-7', 9.72, 28.48),
    (experiment_id, 'node-8', 9.08, 28.48),
    (experiment_id, 'node-9', 11.00, 28.42);
END $$;


-- t3m_16nodes_16txpb_16rounds_RSA.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('RSA', 't3m_16nodes_16txpb_16rounds_RSA.txt', 16, 16, 16, 
   16.0, 
   862.62,
   27.13,
   28.34,
   9.337)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 60.90),
    (experiment_id, 'node-10', 60.26),
    (experiment_id, 'node-11', 60.37),
    (experiment_id, 'node-12', 60.79),
    (experiment_id, 'node-13', 61.11),
    (experiment_id, 'node-14', 61.06),
    (experiment_id, 'node-15', 59.94),
    (experiment_id, 'node-16', 60.89),
    (experiment_id, 'node-2', 61.07),
    (experiment_id, 'node-3', 60.88),
    (experiment_id, 'node-4', 60.29),
    (experiment_id, 'node-5', 61.89),
    (experiment_id, 'node-6', 60.50),
    (experiment_id, 'node-7', 60.21),
    (experiment_id, 'node-8', 60.62),
    (experiment_id, 'node-9', 60.36);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 806),
    (experiment_id, 'node-10', 823),
    (experiment_id, 'node-11', 887),
    (experiment_id, 'node-12', 870),
    (experiment_id, 'node-13', 872),
    (experiment_id, 'node-14', 873),
    (experiment_id, 'node-15', 858),
    (experiment_id, 'node-16', 854),
    (experiment_id, 'node-2', 889),
    (experiment_id, 'node-3', 873),
    (experiment_id, 'node-4', 818),
    (experiment_id, 'node-5', 876),
    (experiment_id, 'node-6', 896),
    (experiment_id, 'node-7', 830),
    (experiment_id, 'node-8', 902),
    (experiment_id, 'node-9', 875);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 27.63, 28.45),
    (experiment_id, 'node-10', 27.63, 28.47),
    (experiment_id, 'node-11', 24.95, 28.46),
    (experiment_id, 'node-12', 27.48, 28.43),
    (experiment_id, 'node-13', 29.32, 28.23),
    (experiment_id, 'node-14', 19.01, 28.33),
    (experiment_id, 'node-15', 23.19, 28.52),
    (experiment_id, 'node-16', 29.21, 28.20),
    (experiment_id, 'node-2', 25.42, 28.42),
    (experiment_id, 'node-3', 20.14, 28.36),
    (experiment_id, 'node-4', 25.75, 28.40),
    (experiment_id, 'node-5', 25.77, 28.41),
    (experiment_id, 'node-6', 23.03, 28.42),
    (experiment_id, 'node-7', 20.10, 28.41),
    (experiment_id, 'node-8', 34.33, 28.09),
    (experiment_id, 'node-9', 51.27, 27.96);
END $$;


-- t3m_5nodes_128txpb_16rounds_MERKLE_BROKE.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('MERKLE', 't3m_5nodes_128txpb_16rounds_MERKLE_BROKE.txt', 5, 128, 16, 
   128.0, 
   216.0,
   44.56,
   28.41,
   10.138)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 373.91),
    (experiment_id, 'node-2', 378.40),
    (experiment_id, 'node-3', 373.38),
    (experiment_id, 'node-4', 375.11),
    (experiment_id, 'node-5', 372.37);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 222),
    (experiment_id, 'node-2', 196),
    (experiment_id, 'node-3', 230),
    (experiment_id, 'node-4', 202),
    (experiment_id, 'node-5', 230);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 38.70, 28.50),
    (experiment_id, 'node-2', 58.34, 28.84),
    (experiment_id, 'node-3', 42.46, 28.25),
    (experiment_id, 'node-4', 28.77, 28.32),
    (experiment_id, 'node-5', 54.56, 28.17);
END $$;


-- t3m_5nodes_128txpb_16rounds_RSA.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('RSA', 't3m_5nodes_128txpb_16rounds_RSA.txt', 5, 128, 16, 
   128.0, 
   216.0,
   44.56,
   28.41,
   10.138)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 373.91),
    (experiment_id, 'node-2', 378.40),
    (experiment_id, 'node-3', 373.38),
    (experiment_id, 'node-4', 375.11),
    (experiment_id, 'node-5', 372.37);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 222),
    (experiment_id, 'node-2', 196),
    (experiment_id, 'node-3', 230),
    (experiment_id, 'node-4', 202),
    (experiment_id, 'node-5', 230);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 38.70, 28.50),
    (experiment_id, 'node-2', 58.34, 28.84),
    (experiment_id, 'node-3', 42.46, 28.25),
    (experiment_id, 'node-4', 28.77, 28.32),
    (experiment_id, 'node-5', 54.56, 28.17);
END $$;


-- t3m_5nodes_16txpb_5rounds_MERKLE.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('MERKLE', 't3m_5nodes_16txpb_5rounds_MERKLE.txt', 5, 16, 5, 
   16.0, 
   65.2,
   42.53,
   28.28,
   5.717)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 180.52),
    (experiment_id, 'node-2', 181.58),
    (experiment_id, 'node-3', 184.58),
    (experiment_id, 'node-4', 180.16),
    (experiment_id, 'node-5', 176.81);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 63),
    (experiment_id, 'node-2', 66),
    (experiment_id, 'node-3', 63),
    (experiment_id, 'node-4', 63),
    (experiment_id, 'node-5', 71);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 38.33, 28.29),
    (experiment_id, 'node-2', 38.49, 28.63),
    (experiment_id, 'node-3', 30.61, 28.36),
    (experiment_id, 'node-4', 49.32, 28.27),
    (experiment_id, 'node-5', 55.92, 27.87);
END $$;


-- t3m_5nodes_16txpb_5rounds_RSA.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('RSA', 't3m_5nodes_16txpb_5rounds_RSA.txt', 5, 16, 5, 
   16.0, 
   98.4,
   48.93,
   28.59,
   4.748)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 220.44),
    (experiment_id, 'node-2', 219.90),
    (experiment_id, 'node-3', 222.18),
    (experiment_id, 'node-4', 221.95),
    (experiment_id, 'node-5', 226.80);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 77),
    (experiment_id, 'node-2', 101),
    (experiment_id, 'node-3', 103),
    (experiment_id, 'node-4', 107),
    (experiment_id, 'node-5', 104);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 67.09, 28.56),
    (experiment_id, 'node-2', 53.75, 28.47),
    (experiment_id, 'node-3', 31.88, 28.51),
    (experiment_id, 'node-4', 34.29, 28.74),
    (experiment_id, 'node-5', 57.67, 28.70);
END $$;


-- t3m_5nodes_32txpb_5rounds_MERKLE.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('MERKLE', 't3m_5nodes_32txpb_5rounds_MERKLE.txt', 5, 32, 5, 
   32.0, 
   64.6,
   34.95,
   28.27,
   5.576)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 229.35),
    (experiment_id, 'node-2', 228.81),
    (experiment_id, 'node-3', 226.25),
    (experiment_id, 'node-4', 231.71),
    (experiment_id, 'node-5', 226.35);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 70),
    (experiment_id, 'node-2', 69),
    (experiment_id, 'node-3', 59),
    (experiment_id, 'node-4', 70),
    (experiment_id, 'node-5', 55);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 18.35, 28.31),
    (experiment_id, 'node-2', 58.32, 28.10),
    (experiment_id, 'node-3', 31.64, 28.32),
    (experiment_id, 'node-4', 41.71, 28.28),
    (experiment_id, 'node-5', 24.77, 28.37);
END $$;


-- t3m_5nodes_32txpb_5rounds_RSA.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('RSA', 't3m_5nodes_32txpb_5rounds_RSA.txt', 5, 32, 5, 
   32.0, 
   85.0,
   41.93,
   28.4,
   4.391)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 332.97),
    (experiment_id, 'node-2', 331.61),
    (experiment_id, 'node-3', 332.11),
    (experiment_id, 'node-4', 351.88),
    (experiment_id, 'node-5', 343.46);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 96),
    (experiment_id, 'node-2', 95),
    (experiment_id, 'node-3', 93),
    (experiment_id, 'node-4', 50),
    (experiment_id, 'node-5', 91);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 42.69, 27.88),
    (experiment_id, 'node-2', 32.47, 28.47),
    (experiment_id, 'node-3', 32.89, 28.40),
    (experiment_id, 'node-4', 69.22, 28.76),
    (experiment_id, 'node-5', 32.39, 28.50);
END $$;


-- t3m_5nodes_5txpb_5rounds_MERKLE.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('MERKLE', 't3m_5nodes_5txpb_5rounds_MERKLE.txt', 5, 5, 5, 
   5.0, 
   64.6,
   41.93,
   28.24,
   5.822)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 70.09),
    (experiment_id, 'node-2', 71.95),
    (experiment_id, 'node-3', 68.63),
    (experiment_id, 'node-4', 71.68),
    (experiment_id, 'node-5', 71.40);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 67),
    (experiment_id, 'node-2', 68),
    (experiment_id, 'node-3', 67),
    (experiment_id, 'node-4', 62),
    (experiment_id, 'node-5', 59);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 27.13, 28.29),
    (experiment_id, 'node-2', 49.44, 28.03),
    (experiment_id, 'node-3', 40.35, 28.30),
    (experiment_id, 'node-4', 51.35, 28.26),
    (experiment_id, 'node-5', 41.41, 28.33);
END $$;


-- t3m_5nodes_5txpb_5rounds_RSA.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('RSA', 't3m_5nodes_5txpb_5rounds_RSA.txt', 5, 5, 5, 
   5.0, 
   113.8,
   43.47,
   28.46,
   5.658)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 84.56),
    (experiment_id, 'node-2', 81.45),
    (experiment_id, 'node-3', 88.16),
    (experiment_id, 'node-4', 84.50),
    (experiment_id, 'node-5', 84.19);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 109),
    (experiment_id, 'node-2', 119),
    (experiment_id, 'node-3', 120),
    (experiment_id, 'node-4', 104),
    (experiment_id, 'node-5', 117);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 43.89, 28.54),
    (experiment_id, 'node-2', 40.89, 28.42),
    (experiment_id, 'node-3', 36.74, 28.39),
    (experiment_id, 'node-4', 35.08, 28.52),
    (experiment_id, 'node-5', 60.77, 28.46);
END $$;


-- t3m_5nodes_64txpb_5rounds_MERKLE.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('MERKLE', 't3m_5nodes_64txpb_5rounds_MERKLE.txt', 5, 64, 5, 
   64.0, 
   63.4,
   51.98,
   28.21,
   5.537)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 299.90),
    (experiment_id, 'node-2', 294.01),
    (experiment_id, 'node-3', 294.46),
    (experiment_id, 'node-4', 291.75),
    (experiment_id, 'node-5', 304.34);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 63),
    (experiment_id, 'node-2', 65),
    (experiment_id, 'node-3', 62),
    (experiment_id, 'node-4', 63),
    (experiment_id, 'node-5', 64);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 50.45, 28.39),
    (experiment_id, 'node-2', 46.14, 27.77),
    (experiment_id, 'node-3', 51.26, 28.37),
    (experiment_id, 'node-4', 50.25, 28.32),
    (experiment_id, 'node-5', 61.84, 28.24);
END $$;


-- t3m_5nodes_64txpb_5rounds_RSA.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('RSA', 't3m_5nodes_64txpb_5rounds_RSA.txt', 5, 64, 5, 
   64.0, 
   65.6,
   41.4,
   28.24,
   3.873)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 570.12),
    (experiment_id, 'node-2', 478.21),
    (experiment_id, 'node-3', 474.95),
    (experiment_id, 'node-4', 358.90),
    (experiment_id, 'node-5', 475.14);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 61),
    (experiment_id, 'node-2', 76),
    (experiment_id, 'node-3', 75),
    (experiment_id, 'node-4', 35),
    (experiment_id, 'node-5', 81);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 49.23, 28.20),
    (experiment_id, 'node-2', 29.36, 28.13),
    (experiment_id, 'node-3', 29.55, 28.38),
    (experiment_id, 'node-4', 69.83, 28.21),
    (experiment_id, 'node-5', 29.07, 28.29);
END $$;


-- t3m_8nodes_8txpb_8rounds_MERKLE.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('MERKLE', 't3m_8nodes_8txpb_8rounds_MERKLE.txt', 8, 8, 8, 
   8.0, 
   157.25,
   47.37,
   28.21,
   5.043)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 61.62),
    (experiment_id, 'node-2', 61.02),
    (experiment_id, 'node-3', 61.68),
    (experiment_id, 'node-4', 60.68),
    (experiment_id, 'node-5', 62.29),
    (experiment_id, 'node-6', 60.54),
    (experiment_id, 'node-7', 61.65),
    (experiment_id, 'node-8', 61.84);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 161),
    (experiment_id, 'node-2', 131),
    (experiment_id, 'node-3', 165),
    (experiment_id, 'node-4', 162),
    (experiment_id, 'node-5', 165),
    (experiment_id, 'node-6', 161),
    (experiment_id, 'node-7', 154),
    (experiment_id, 'node-8', 159);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 48.06, 28.42),
    (experiment_id, 'node-2', 66.73, 27.98),
    (experiment_id, 'node-3', 41.45, 28.05),
    (experiment_id, 'node-4', 46.32, 28.23),
    (experiment_id, 'node-5', 37.38, 28.22),
    (experiment_id, 'node-6', 46.11, 28.32),
    (experiment_id, 'node-7', 50.54, 28.32),
    (experiment_id, 'node-8', 42.39, 28.20);
END $$;


-- t3m_8nodes_8txpb_8rounds_RSA.txt
DO $$
DECLARE
  experiment_id INTEGER;
BEGIN
  INSERT INTO experiment_summary 
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
  VALUES 
  ('RSA', 't3m_8nodes_8txpb_8rounds_RSA.txt', 8, 8, 8, 
   8.0, 
   232.75,
   35.41,
   28.34,
   5.591)
  RETURNING id INTO experiment_id;

  INSERT INTO node_tps (experiment_id, node_id, tps)
  VALUES
    (experiment_id, 'node-1', 98.30),
    (experiment_id, 'node-2', 98.13),
    (experiment_id, 'node-3', 99.35),
    (experiment_id, 'node-4', 98.30),
    (experiment_id, 'node-5', 97.77),
    (experiment_id, 'node-6', 98.23),
    (experiment_id, 'node-7', 97.61),
    (experiment_id, 'node-8', 94.96);

  INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
  VALUES
    (experiment_id, 'node-1', 224),
    (experiment_id, 'node-2', 239),
    (experiment_id, 'node-3', 232),
    (experiment_id, 'node-4', 227),
    (experiment_id, 'node-5', 227),
    (experiment_id, 'node-6', 234),
    (experiment_id, 'node-7', 238),
    (experiment_id, 'node-8', 241);

  INSERT INTO node_resource_utilization (experiment_id, node_id, cpu_util, mem_util)
  VALUES
    (experiment_id, 'node-1', 29.96, 28.32),
    (experiment_id, 'node-2', 29.27, 28.48),
    (experiment_id, 'node-3', 60.23, 28.13),
    (experiment_id, 'node-4', 32.57, 28.50),
    (experiment_id, 'node-5', 29.45, 28.24),
    (experiment_id, 'node-6', 22.50, 28.37),
    (experiment_id, 'node-7', 44.69, 28.38),
    (experiment_id, 'node-8', 34.63, 28.31);
END $$;

