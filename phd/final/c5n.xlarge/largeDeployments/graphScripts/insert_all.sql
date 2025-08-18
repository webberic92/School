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

-- 104nodes_1024txpb_3rounds_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', '104nodes_1024txpb_3rounds_RSA.txt', 104, 1024, 3,
   4.88,
   1297.5,
   19.13,
   38.71,
   1126.556);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 4.83 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 4.70 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-100' AS node_id, 4.88 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-101' AS node_id, 5.01 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-102' AS node_id, 4.58 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-103' AS node_id, 4.86 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-104' AS node_id, 4.77 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 4.64 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 5.07 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 4.95 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 4.80 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 4.67 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 5.97 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 4.88 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-18' AS node_id, 4.94 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 4.26 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 5.45 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 5.00 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 4.71 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 4.67 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 4.80 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 5.29 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 4.83 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 5.05 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 6.11 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 5.05 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 5.06 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 4.54 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 5.24 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 5.14 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 4.71 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-33' AS node_id, 5.09 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-34' AS node_id, 4.62 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-35' AS node_id, 5.01 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-36' AS node_id, 4.74 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-37' AS node_id, 4.82 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-38' AS node_id, 3.93 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-39' AS node_id, 4.71 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 4.72 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-40' AS node_id, 4.00 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-41' AS node_id, 4.80 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-42' AS node_id, 4.76 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-43' AS node_id, 5.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-44' AS node_id, 4.97 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-45' AS node_id, 4.95 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-46' AS node_id, 4.33 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-47' AS node_id, 5.30 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-48' AS node_id, 4.89 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-49' AS node_id, 5.13 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 4.67 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-50' AS node_id, 4.63 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-51' AS node_id, 4.73 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-52' AS node_id, 5.04 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-53' AS node_id, 4.71 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-54' AS node_id, 4.09 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-55' AS node_id, 5.94 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-56' AS node_id, 5.06 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-57' AS node_id, 5.63 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-58' AS node_id, 4.62 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-59' AS node_id, 5.97 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 5.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-60' AS node_id, 4.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-61' AS node_id, 5.19 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-62' AS node_id, 4.69 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-63' AS node_id, 4.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-64' AS node_id, 4.82 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-65' AS node_id, 4.87 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-66' AS node_id, 4.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-67' AS node_id, 4.70 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-68' AS node_id, 4.92 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-69' AS node_id, 4.93 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 4.12 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-70' AS node_id, 5.07 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-71' AS node_id, 4.67 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-72' AS node_id, 5.53 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-73' AS node_id, 4.71 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-74' AS node_id, 4.75 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-75' AS node_id, 5.19 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-76' AS node_id, 4.95 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-77' AS node_id, 4.76 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-78' AS node_id, 4.83 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-79' AS node_id, 4.88 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 5.02 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-80' AS node_id, 4.07 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-81' AS node_id, 4.73 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-82' AS node_id, 4.94 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-83' AS node_id, 5.01 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-84' AS node_id, 4.91 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-85' AS node_id, 4.71 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-86' AS node_id, 5.01 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-87' AS node_id, 5.14 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-88' AS node_id, 5.04 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-89' AS node_id, 4.68 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 4.88 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-90' AS node_id, 5.22 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-91' AS node_id, 4.52 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-92' AS node_id, 4.41 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-93' AS node_id, 4.89 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-94' AS node_id, 4.62 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-95' AS node_id, 4.97 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-96' AS node_id, 5.01 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-97' AS node_id, 4.73 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-98' AS node_id, 4.61 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-99' AS node_id, 5.04 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 1427 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 1461 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-100' AS node_id, 1146 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-101' AS node_id, 1425 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-102' AS node_id, 1247 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-103' AS node_id, 1151 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-104' AS node_id, 1419 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 1418 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 1249 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 1223 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 1412 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 1257 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 1269 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 1197 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-18' AS node_id, 1436 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 1068 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 1418 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 1438 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 1430 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 1401 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 1259 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 1218 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 1296 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 1422 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 1122 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 1375 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 1417 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 1433 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 1296 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 1391 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 1390 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-33' AS node_id, 1435 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-34' AS node_id, 1426 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-35' AS node_id, 1370 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-36' AS node_id, 1365 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-37' AS node_id, 1365 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-38' AS node_id, 1237 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-39' AS node_id, 1194 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 1310 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-40' AS node_id, 1041 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-41' AS node_id, 1214 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-42' AS node_id, 1198 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-43' AS node_id, 1265 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-44' AS node_id, 1257 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-45' AS node_id, 1318 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-46' AS node_id, 1233 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-47' AS node_id, 1209 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-48' AS node_id, 1367 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-49' AS node_id, 1172 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 1283 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-50' AS node_id, 1212 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-51' AS node_id, 1348 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-52' AS node_id, 1243 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-53' AS node_id, 1390 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-54' AS node_id, 1312 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-55' AS node_id, 1274 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-56' AS node_id, 1163 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-57' AS node_id, 1281 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-58' AS node_id, 1159 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-59' AS node_id, 1287 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 1357 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-60' AS node_id, 1438 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-61' AS node_id, 1303 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-62' AS node_id, 1194 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-63' AS node_id, 1250 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-64' AS node_id, 1335 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-65' AS node_id, 1160 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-66' AS node_id, 1179 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-67' AS node_id, 1422 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-68' AS node_id, 1416 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-69' AS node_id, 1406 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 1023 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-70' AS node_id, 1415 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-71' AS node_id, 1377 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-72' AS node_id, 1245 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-73' AS node_id, 1295 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-74' AS node_id, 1435 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-75' AS node_id, 1421 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-76' AS node_id, 1406 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-77' AS node_id, 1296 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-78' AS node_id, 1230 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-79' AS node_id, 1358 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 1049 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-80' AS node_id, 1308 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-81' AS node_id, 1419 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-82' AS node_id, 1175 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-83' AS node_id, 1210 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-84' AS node_id, 1411 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-85' AS node_id, 1197 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-86' AS node_id, 1240 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-87' AS node_id, 1241 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-88' AS node_id, 1162 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-89' AS node_id, 1360 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 1327 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-90' AS node_id, 1412 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-91' AS node_id, 1324 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-92' AS node_id, 1007 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-93' AS node_id, 1360 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-94' AS node_id, 1124 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-95' AS node_id, 1425 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-96' AS node_id, 1425 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-97' AS node_id, 1395 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-98' AS node_id, 1218 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-99' AS node_id, 1151 AS overhead_messages FROM __exp
);


-- 104nodes_5txpb_3rounds_MERKLE.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('MERKLE', '104nodes_5txpb_3rounds_MERKLE.txt', 104, 5, 3,
   0.49,
   1029.59,
   28.98,
   14.09,
   52.657);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 0.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 0.50 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-100' AS node_id, 0.49 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-101' AS node_id, 0.46 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-102' AS node_id, 0.51 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-103' AS node_id, 0.45 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-104' AS node_id, 0.50 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 0.59 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 0.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 0.51 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 0.49 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 0.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 0.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 0.45 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-18' AS node_id, 0.46 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 0.42 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 0.52 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 0.50 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 0.42 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 0.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 0.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 0.46 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 0.45 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 0.50 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 0.46 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 0.48 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 0.52 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 0.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 0.45 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 0.46 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 0.64 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-33' AS node_id, 0.49 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-34' AS node_id, 0.46 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-35' AS node_id, 0.43 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-36' AS node_id, 0.44 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-37' AS node_id, 0.51 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-38' AS node_id, 0.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-39' AS node_id, 0.44 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 0.43 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-40' AS node_id, 0.50 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-41' AS node_id, 0.50 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-42' AS node_id, 0.46 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-43' AS node_id, 0.63 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-44' AS node_id, 0.49 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-45' AS node_id, 0.44 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-46' AS node_id, 0.46 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-47' AS node_id, 0.45 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-48' AS node_id, 0.48 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-49' AS node_id, 0.55 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 0.46 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-50' AS node_id, 0.50 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-51' AS node_id, 0.50 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-52' AS node_id, 0.53 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-53' AS node_id, 0.54 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-54' AS node_id, 0.45 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-55' AS node_id, 0.44 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-56' AS node_id, 0.46 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-57' AS node_id, 0.46 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-58' AS node_id, 0.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-59' AS node_id, 0.52 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 0.50 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-60' AS node_id, 0.51 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-61' AS node_id, 0.54 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-62' AS node_id, 0.58 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-63' AS node_id, 0.51 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-64' AS node_id, 0.48 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-65' AS node_id, 0.50 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-66' AS node_id, 0.49 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-67' AS node_id, 0.57 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-68' AS node_id, 0.50 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-69' AS node_id, 0.44 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 0.42 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-70' AS node_id, 0.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-71' AS node_id, 0.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-72' AS node_id, 0.44 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-73' AS node_id, 0.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-74' AS node_id, 0.43 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-75' AS node_id, 0.48 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-76' AS node_id, 0.48 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-77' AS node_id, 0.49 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-78' AS node_id, 0.51 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-79' AS node_id, 0.53 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 0.59 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-80' AS node_id, 0.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-81' AS node_id, 0.62 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-82' AS node_id, 0.48 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-83' AS node_id, 0.48 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-84' AS node_id, 0.58 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-85' AS node_id, 0.55 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-86' AS node_id, 0.45 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-87' AS node_id, 0.44 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-88' AS node_id, 0.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-89' AS node_id, 0.46 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 0.49 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-90' AS node_id, 0.42 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-91' AS node_id, 0.44 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-92' AS node_id, 0.49 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-93' AS node_id, 0.52 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-94' AS node_id, 0.46 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-95' AS node_id, 0.51 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-96' AS node_id, 0.46 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-97' AS node_id, 0.44 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-98' AS node_id, 0.48 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-99' AS node_id, 0.50 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 1086 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 974 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-100' AS node_id, 1099 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-101' AS node_id, 1021 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-102' AS node_id, 990 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-103' AS node_id, 1058 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-104' AS node_id, 1190 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 967 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 911 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 1036 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 1107 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 1178 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 981 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 1034 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-18' AS node_id, 977 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 990 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 895 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 698 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 960 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 955 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 931 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 1012 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 906 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 1093 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 1039 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 1070 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 816 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 1033 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 936 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 1129 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 1007 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-33' AS node_id, 1194 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-34' AS node_id, 1100 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-35' AS node_id, 849 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-36' AS node_id, 999 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-37' AS node_id, 947 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-38' AS node_id, 876 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-39' AS node_id, 1096 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 1164 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-40' AS node_id, 1096 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-41' AS node_id, 950 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-42' AS node_id, 1172 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-43' AS node_id, 919 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-44' AS node_id, 1037 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-45' AS node_id, 848 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-46' AS node_id, 1181 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-47' AS node_id, 1005 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-48' AS node_id, 881 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-49' AS node_id, 897 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 1004 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-50' AS node_id, 1087 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-51' AS node_id, 896 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-52' AS node_id, 983 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-53' AS node_id, 1164 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-54' AS node_id, 1041 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-55' AS node_id, 1158 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-56' AS node_id, 1165 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-57' AS node_id, 1078 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-58' AS node_id, 1178 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-59' AS node_id, 1005 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 714 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-60' AS node_id, 1244 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-61' AS node_id, 1057 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-62' AS node_id, 981 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-63' AS node_id, 833 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-64' AS node_id, 952 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-65' AS node_id, 1207 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-66' AS node_id, 941 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-67' AS node_id, 1065 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-68' AS node_id, 1162 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-69' AS node_id, 1242 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 1180 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-70' AS node_id, 958 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-71' AS node_id, 1154 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-72' AS node_id, 1084 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-73' AS node_id, 988 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-74' AS node_id, 1137 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-75' AS node_id, 1129 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-76' AS node_id, 1217 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-77' AS node_id, 1170 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-78' AS node_id, 952 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-79' AS node_id, 1154 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 972 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-80' AS node_id, 699 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-81' AS node_id, 1158 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-82' AS node_id, 1154 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-83' AS node_id, 949 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-84' AS node_id, 924 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-85' AS node_id, 892 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-86' AS node_id, 1127 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-87' AS node_id, 1059 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-88' AS node_id, 1010 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-89' AS node_id, 1151 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 906 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-90' AS node_id, 1131 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-91' AS node_id, 1160 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-92' AS node_id, 1166 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-93' AS node_id, 762 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-94' AS node_id, 1110 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-95' AS node_id, 991 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-96' AS node_id, 1100 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-97' AS node_id, 975 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-98' AS node_id, 980 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-99' AS node_id, 1132 AS overhead_messages FROM __exp
);


-- 104nodes_5txpb_3rounds_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', '104nodes_5txpb_3rounds_RSA.txt', 104, 5, 3,
   6.66,
   1301.47,
   6.53,
   11.11,
   8.959);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 6.57 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 6.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-100' AS node_id, 7.16 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-101' AS node_id, 6.15 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-102' AS node_id, 6.55 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-103' AS node_id, 6.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-104' AS node_id, 7.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 6.30 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 6.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 6.75 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 6.59 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 6.79 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 6.54 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 6.38 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-18' AS node_id, 6.41 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 7.62 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 6.96 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 6.41 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 6.63 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 6.68 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 6.41 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 6.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 7.04 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 6.97 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 7.17 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 5.51 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 6.95 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 6.58 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 6.93 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 6.27 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 6.18 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-33' AS node_id, 6.37 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-34' AS node_id, 5.74 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-35' AS node_id, 6.41 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-36' AS node_id, 6.48 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-37' AS node_id, 6.44 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-38' AS node_id, 6.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-39' AS node_id, 7.57 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 7.17 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-40' AS node_id, 6.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-41' AS node_id, 6.79 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-42' AS node_id, 6.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-43' AS node_id, 7.14 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-44' AS node_id, 6.58 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-45' AS node_id, 6.75 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-46' AS node_id, 6.70 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-47' AS node_id, 6.79 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-48' AS node_id, 5.86 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-49' AS node_id, 6.74 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 6.84 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-50' AS node_id, 6.53 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-51' AS node_id, 6.41 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-52' AS node_id, 6.58 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-53' AS node_id, 6.59 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-54' AS node_id, 6.49 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-55' AS node_id, 6.84 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-56' AS node_id, 6.52 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-57' AS node_id, 6.58 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-58' AS node_id, 6.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-59' AS node_id, 6.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 6.75 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-60' AS node_id, 6.54 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-61' AS node_id, 6.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-62' AS node_id, 7.15 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-63' AS node_id, 6.51 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-64' AS node_id, 7.51 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-65' AS node_id, 7.77 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-66' AS node_id, 6.77 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-67' AS node_id, 6.52 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-68' AS node_id, 6.69 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-69' AS node_id, 6.33 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 6.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-70' AS node_id, 6.64 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-71' AS node_id, 6.39 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-72' AS node_id, 6.62 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-73' AS node_id, 6.51 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-74' AS node_id, 7.77 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-75' AS node_id, 6.80 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-76' AS node_id, 6.39 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-77' AS node_id, 6.67 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-78' AS node_id, 6.42 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-79' AS node_id, 7.31 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 6.69 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-80' AS node_id, 7.29 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-81' AS node_id, 6.55 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-82' AS node_id, 6.53 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-83' AS node_id, 6.66 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-84' AS node_id, 6.62 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-85' AS node_id, 6.60 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-86' AS node_id, 6.84 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-87' AS node_id, 6.82 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-88' AS node_id, 5.60 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-89' AS node_id, 6.40 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 6.33 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-90' AS node_id, 6.73 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-91' AS node_id, 6.54 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-92' AS node_id, 6.48 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-93' AS node_id, 6.54 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-94' AS node_id, 6.35 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-95' AS node_id, 6.45 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-96' AS node_id, 6.32 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-97' AS node_id, 6.82 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-98' AS node_id, 6.86 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-99' AS node_id, 6.39 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 1354 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 1426 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-100' AS node_id, 988 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-101' AS node_id, 1270 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-102' AS node_id, 1389 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-103' AS node_id, 1424 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-104' AS node_id, 989 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 1403 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 1250 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 1176 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 1345 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 1295 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 1428 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 1410 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-18' AS node_id, 1412 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 1294 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 1312 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 1300 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 1408 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 1424 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 1376 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 1184 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 1177 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 1138 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 1265 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 1228 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 1158 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 1376 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 1215 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 1420 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 1212 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-33' AS node_id, 1322 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-34' AS node_id, 1270 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-35' AS node_id, 1171 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-36' AS node_id, 1285 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-37' AS node_id, 1311 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-38' AS node_id, 1278 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-39' AS node_id, 1185 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 1222 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-40' AS node_id, 1381 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-41' AS node_id, 1379 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-42' AS node_id, 1389 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-43' AS node_id, 1187 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-44' AS node_id, 1240 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-45' AS node_id, 1137 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-46' AS node_id, 1370 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-47' AS node_id, 1245 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-48' AS node_id, 1391 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-49' AS node_id, 1426 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 1371 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-50' AS node_id, 1347 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-51' AS node_id, 1406 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-52' AS node_id, 1320 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-53' AS node_id, 1419 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-54' AS node_id, 1335 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-55' AS node_id, 1421 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-56' AS node_id, 1214 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-57' AS node_id, 1225 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-58' AS node_id, 1157 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-59' AS node_id, 1273 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 1339 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-60' AS node_id, 1303 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-61' AS node_id, 1303 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-62' AS node_id, 1091 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-63' AS node_id, 1411 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-64' AS node_id, 1195 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-65' AS node_id, 1111 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-66' AS node_id, 1379 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-67' AS node_id, 1263 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-68' AS node_id, 1360 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-69' AS node_id, 1319 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 1256 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-70' AS node_id, 1326 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-71' AS node_id, 1350 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-72' AS node_id, 1178 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-73' AS node_id, 1249 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-74' AS node_id, 1254 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-75' AS node_id, 1322 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-76' AS node_id, 1414 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-77' AS node_id, 1366 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-78' AS node_id, 1415 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-79' AS node_id, 1267 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 1427 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-80' AS node_id, 1248 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-81' AS node_id, 1417 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-82' AS node_id, 1318 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-83' AS node_id, 1379 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-84' AS node_id, 1345 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-85' AS node_id, 1375 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-86' AS node_id, 1408 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-87' AS node_id, 1312 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-88' AS node_id, 1306 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-89' AS node_id, 1264 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 1253 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-90' AS node_id, 1359 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-91' AS node_id, 1153 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-92' AS node_id, 1366 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-93' AS node_id, 1414 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-94' AS node_id, 1289 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-95' AS node_id, 1376 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-96' AS node_id, 1420 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-97' AS node_id, 1198 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-98' AS node_id, 1200 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-99' AS node_id, 1332 AS overhead_messages FROM __exp
);


-- 64nodes_128txpb_3rounds_MERKLE.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('MERKLE', '64nodes_128txpb_3rounds_MERKLE.txt', 64, 128, 3,
   1.6,
   836.15,
   56.6,
   29.08,
   355.59);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 1.54 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 1.60 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 1.57 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 1.46 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 1.60 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 1.64 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 1.53 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 1.41 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 1.49 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-18' AS node_id, 1.64 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 1.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 1.58 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 1.49 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 1.54 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 1.59 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 1.77 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 1.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 1.73 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 1.80 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 1.73 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 1.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 1.51 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 1.79 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 1.53 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 1.58 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 1.45 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-33' AS node_id, 1.54 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-34' AS node_id, 1.68 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-35' AS node_id, 1.69 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-36' AS node_id, 1.54 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-37' AS node_id, 1.75 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-38' AS node_id, 1.55 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-39' AS node_id, 1.85 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 1.48 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-40' AS node_id, 1.71 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-41' AS node_id, 1.56 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-42' AS node_id, 1.60 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-43' AS node_id, 1.41 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-44' AS node_id, 1.44 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-45' AS node_id, 1.50 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-46' AS node_id, 1.71 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-47' AS node_id, 1.67 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-48' AS node_id, 1.54 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-49' AS node_id, 1.63 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 1.69 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-50' AS node_id, 1.64 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-51' AS node_id, 1.52 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-52' AS node_id, 1.75 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-53' AS node_id, 1.61 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-54' AS node_id, 1.57 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-55' AS node_id, 1.56 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-56' AS node_id, 1.54 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-57' AS node_id, 1.67 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-58' AS node_id, 1.50 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-59' AS node_id, 1.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 1.39 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-60' AS node_id, 1.61 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-61' AS node_id, 1.55 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-62' AS node_id, 1.69 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-63' AS node_id, 1.60 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-64' AS node_id, 1.58 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 1.60 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 1.51 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 1.73 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 928 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 775 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 757 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 940 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 820 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 854 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 894 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 950 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 883 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-18' AS node_id, 716 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 898 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 807 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 966 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 464 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 925 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 694 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 918 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 727 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 820 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 717 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 816 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 1001 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 586 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 795 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 661 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 898 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-33' AS node_id, 897 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-34' AS node_id, 597 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-35' AS node_id, 827 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-36' AS node_id, 920 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-37' AS node_id, 811 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-38' AS node_id, 972 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-39' AS node_id, 751 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 909 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-40' AS node_id, 568 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-41' AS node_id, 968 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-42' AS node_id, 950 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-43' AS node_id, 717 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-44' AS node_id, 768 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-45' AS node_id, 670 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-46' AS node_id, 897 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-47' AS node_id, 926 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-48' AS node_id, 1061 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-49' AS node_id, 837 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 754 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-50' AS node_id, 994 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-51' AS node_id, 772 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-52' AS node_id, 636 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-53' AS node_id, 988 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-54' AS node_id, 796 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-55' AS node_id, 888 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-56' AS node_id, 708 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-57' AS node_id, 855 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-58' AS node_id, 909 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-59' AS node_id, 751 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 772 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-60' AS node_id, 1014 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-61' AS node_id, 962 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-62' AS node_id, 945 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-63' AS node_id, 1091 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-64' AS node_id, 788 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 912 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 928 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 795 AS overhead_messages FROM __exp
);


-- 64nodes_128txpb_3rounds_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', '64nodes_128txpb_3rounds_RSA.txt', 64, 128, 3,
   15.63,
   806.98,
   18.03,
   11.98,
   46.518);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 13.43 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 15.26 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 16.21 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 14.84 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 15.57 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 16.57 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 16.01 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 15.26 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 15.98 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-18' AS node_id, 16.34 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 16.48 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 15.57 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 13.82 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 15.26 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 14.60 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 15.91 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 16.01 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 16.40 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 17.28 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 14.58 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 15.44 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 15.79 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 14.55 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 16.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 14.58 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 14.86 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-33' AS node_id, 16.18 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-34' AS node_id, 15.46 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-35' AS node_id, 16.60 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-36' AS node_id, 15.97 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-37' AS node_id, 14.11 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-38' AS node_id, 14.25 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-39' AS node_id, 17.06 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 15.28 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-40' AS node_id, 15.68 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-41' AS node_id, 17.41 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-42' AS node_id, 15.24 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-43' AS node_id, 15.71 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-44' AS node_id, 15.71 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-45' AS node_id, 17.00 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-46' AS node_id, 16.10 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-47' AS node_id, 15.93 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-48' AS node_id, 15.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-49' AS node_id, 15.63 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 16.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-50' AS node_id, 15.33 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-51' AS node_id, 16.39 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-52' AS node_id, 15.72 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-53' AS node_id, 16.20 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-54' AS node_id, 14.08 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-55' AS node_id, 16.09 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-56' AS node_id, 15.26 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-57' AS node_id, 16.21 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-58' AS node_id, 15.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-59' AS node_id, 16.30 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 15.86 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-60' AS node_id, 16.68 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-61' AS node_id, 16.78 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-62' AS node_id, 14.12 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-63' AS node_id, 14.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-64' AS node_id, 15.51 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 13.75 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 16.21 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 15.62 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 874 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 707 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 797 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 756 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 738 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 784 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 849 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 855 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 822 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-18' AS node_id, 816 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 804 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 792 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 802 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 798 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 742 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 863 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 901 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 852 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 698 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 833 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 721 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 864 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 881 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 886 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 843 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 804 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-33' AS node_id, 797 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-34' AS node_id, 763 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-35' AS node_id, 820 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-36' AS node_id, 875 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-37' AS node_id, 872 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-38' AS node_id, 903 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-39' AS node_id, 701 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 756 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-40' AS node_id, 702 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-41' AS node_id, 883 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-42' AS node_id, 870 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-43' AS node_id, 731 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-44' AS node_id, 885 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-45' AS node_id, 680 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-46' AS node_id, 721 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-47' AS node_id, 870 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-48' AS node_id, 813 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-49' AS node_id, 857 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 884 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-50' AS node_id, 879 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-51' AS node_id, 778 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-52' AS node_id, 871 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-53' AS node_id, 853 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-54' AS node_id, 760 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-55' AS node_id, 877 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-56' AS node_id, 865 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-57' AS node_id, 838 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-58' AS node_id, 743 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-59' AS node_id, 759 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 878 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-60' AS node_id, 792 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-61' AS node_id, 774 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-62' AS node_id, 665 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-63' AS node_id, 872 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-64' AS node_id, 750 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 722 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 753 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 753 AS overhead_messages FROM __exp
);


-- 64nodes_256txpb_3rounds_MERKLE.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('MERKLE', '64nodes_256txpb_3rounds_MERKLE.txt', 64, 256, 3,
   0.44,
   945.68,
   51.88,
   38.38,
   3121.902);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 1.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-18' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 1.69 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 1.90 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 1.83 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 1.80 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-33' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-34' AS node_id, 1.66 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-35' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-36' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-37' AS node_id, 1.79 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-38' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-39' AS node_id, 1.84 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-40' AS node_id, 1.67 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-41' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-42' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-43' AS node_id, 1.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-44' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-45' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-46' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-47' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-48' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-49' AS node_id, 1.78 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-50' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-51' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-52' AS node_id, 1.79 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-53' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-54' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-55' AS node_id, 1.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-56' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-57' AS node_id, 1.85 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-58' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-59' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-60' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-61' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-62' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-63' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-64' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 0.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 1.70 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 753 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 972 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 878 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 1026 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 1134 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 1018 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 904 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 1036 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 1085 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-18' AS node_id, 1048 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 653 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 818 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 1065 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 626 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 811 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 739 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 587 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 1186 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 1044 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 1189 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 1117 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 1115 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 1166 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 895 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 836 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 906 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-33' AS node_id, 793 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-34' AS node_id, 548 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-35' AS node_id, 1124 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-36' AS node_id, 1218 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-37' AS node_id, 640 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-38' AS node_id, 1041 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-39' AS node_id, 630 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 970 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-40' AS node_id, 727 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-41' AS node_id, 1112 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-42' AS node_id, 1042 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-43' AS node_id, 676 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-44' AS node_id, 1112 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-45' AS node_id, 983 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-46' AS node_id, 1196 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-47' AS node_id, 996 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-48' AS node_id, 972 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-49' AS node_id, 723 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 1049 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-50' AS node_id, 1197 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-51' AS node_id, 1178 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-52' AS node_id, 722 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-53' AS node_id, 1038 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-54' AS node_id, 1158 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-55' AS node_id, 711 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-56' AS node_id, 1015 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-57' AS node_id, 453 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-58' AS node_id, 968 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-59' AS node_id, 1179 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 1211 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-60' AS node_id, 917 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-61' AS node_id, 1016 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-62' AS node_id, 999 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-63' AS node_id, 716 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-64' AS node_id, 1093 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 1105 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 996 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 693 AS overhead_messages FROM __exp
);


-- 64nodes_256txpb_3rounds_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', '64nodes_256txpb_3rounds_RSA.txt', 64, 256, 3,
   14.95,
   794.81,
   15.58,
   12.95,
   93.804);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 12.47 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 16.60 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 15.26 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 12.74 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 15.55 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 13.42 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 15.73 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 15.09 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 14.12 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-18' AS node_id, 15.88 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 14.40 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 16.02 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 15.02 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 13.97 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 14.40 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 15.40 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 13.73 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 14.20 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 17.50 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 15.84 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 15.99 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 13.86 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 13.92 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 14.92 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 16.52 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 14.34 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-33' AS node_id, 14.30 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-34' AS node_id, 15.20 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-35' AS node_id, 15.05 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-36' AS node_id, 13.36 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-37' AS node_id, 14.12 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-38' AS node_id, 14.84 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-39' AS node_id, 15.66 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 16.19 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-40' AS node_id, 15.49 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-41' AS node_id, 16.67 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-42' AS node_id, 17.16 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-43' AS node_id, 15.61 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-44' AS node_id, 14.58 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-45' AS node_id, 14.98 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-46' AS node_id, 17.34 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-47' AS node_id, 13.60 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-48' AS node_id, 14.97 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-49' AS node_id, 12.61 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 15.10 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-50' AS node_id, 14.24 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-51' AS node_id, 15.46 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-52' AS node_id, 14.41 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-53' AS node_id, 13.62 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-54' AS node_id, 15.52 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-55' AS node_id, 14.33 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-56' AS node_id, 14.22 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-57' AS node_id, 15.83 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-58' AS node_id, 15.54 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-59' AS node_id, 13.11 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 14.01 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-60' AS node_id, 15.83 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-61' AS node_id, 15.68 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-62' AS node_id, 12.78 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-63' AS node_id, 17.06 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-64' AS node_id, 16.00 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 13.91 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 15.86 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 15.80 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 676 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 837 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 853 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 686 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 720 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 748 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 747 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 891 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 839 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-18' AS node_id, 843 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 707 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 868 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 889 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 846 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 897 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 793 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 758 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 850 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 740 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 842 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 771 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 846 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 858 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 747 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 865 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 770 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-33' AS node_id, 713 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-34' AS node_id, 807 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-35' AS node_id, 864 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-36' AS node_id, 715 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-37' AS node_id, 855 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-38' AS node_id, 785 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-39' AS node_id, 812 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 826 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-40' AS node_id, 706 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-41' AS node_id, 755 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-42' AS node_id, 733 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-43' AS node_id, 819 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-44' AS node_id, 826 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-45' AS node_id, 778 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-46' AS node_id, 796 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-47' AS node_id, 810 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-48' AS node_id, 868 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-49' AS node_id, 764 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 728 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-50' AS node_id, 648 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-51' AS node_id, 701 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-52' AS node_id, 860 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-53' AS node_id, 758 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-54' AS node_id, 664 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-55' AS node_id, 865 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-56' AS node_id, 845 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-57' AS node_id, 811 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-58' AS node_id, 867 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-59' AS node_id, 798 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 852 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-60' AS node_id, 836 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-61' AS node_id, 855 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-62' AS node_id, 671 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-63' AS node_id, 781 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-64' AS node_id, 766 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 868 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 833 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 742 AS overhead_messages FROM __exp
);


-- 64nodes_5txpb_3rounds_MERKLE.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('MERKLE', '64nodes_5txpb_3rounds_MERKLE.txt', 64, 5, 3,
   1.78,
   661.71,
   24.19,
   11.5,
   18.269);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 1.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 1.79 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 1.73 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 1.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 1.73 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 1.87 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 1.85 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 1.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 1.78 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-18' AS node_id, 1.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 1.69 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 1.84 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 1.89 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 1.90 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 1.73 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 1.83 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 1.80 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 1.87 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 1.87 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 1.74 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 1.67 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 1.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 1.78 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 1.68 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 1.80 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 1.86 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-33' AS node_id, 1.68 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-34' AS node_id, 1.66 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-35' AS node_id, 1.67 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-36' AS node_id, 1.84 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-37' AS node_id, 1.79 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-38' AS node_id, 1.76 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-39' AS node_id, 1.84 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 1.76 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-40' AS node_id, 1.67 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-41' AS node_id, 1.76 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-42' AS node_id, 1.77 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-43' AS node_id, 1.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-44' AS node_id, 1.85 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-45' AS node_id, 1.68 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-46' AS node_id, 1.74 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-47' AS node_id, 1.73 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-48' AS node_id, 1.95 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-49' AS node_id, 1.78 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 1.65 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-50' AS node_id, 1.78 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-51' AS node_id, 1.84 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-52' AS node_id, 1.79 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-53' AS node_id, 1.83 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-54' AS node_id, 1.79 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-55' AS node_id, 1.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-56' AS node_id, 1.70 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-57' AS node_id, 1.85 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-58' AS node_id, 1.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-59' AS node_id, 1.83 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 1.86 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-60' AS node_id, 1.79 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-61' AS node_id, 1.74 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-62' AS node_id, 1.79 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-63' AS node_id, 1.73 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-64' AS node_id, 1.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 1.76 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 1.73 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 1.70 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 753 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 612 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 702 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 747 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 635 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 483 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 655 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 722 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 608 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-18' AS node_id, 731 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 653 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 739 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 576 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 626 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 687 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 739 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 587 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 419 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 677 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 597 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 693 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 610 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 560 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 657 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 683 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 588 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-33' AS node_id, 631 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-34' AS node_id, 548 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-35' AS node_id, 771 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-36' AS node_id, 621 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-37' AS node_id, 640 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-38' AS node_id, 635 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-39' AS node_id, 630 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 754 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-40' AS node_id, 727 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-41' AS node_id, 753 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-42' AS node_id, 784 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-43' AS node_id, 676 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-44' AS node_id, 765 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-45' AS node_id, 565 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-46' AS node_id, 657 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-47' AS node_id, 760 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-48' AS node_id, 705 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-49' AS node_id, 723 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 595 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-50' AS node_id, 731 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-51' AS node_id, 707 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-52' AS node_id, 722 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-53' AS node_id, 668 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-54' AS node_id, 704 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-55' AS node_id, 711 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-56' AS node_id, 639 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-57' AS node_id, 453 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-58' AS node_id, 740 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-59' AS node_id, 777 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 490 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-60' AS node_id, 545 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-61' AS node_id, 617 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-62' AS node_id, 785 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-63' AS node_id, 766 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-64' AS node_id, 569 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 728 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 626 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 693 AS overhead_messages FROM __exp
);


-- 64nodes_5txpb_3rounds_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', '64nodes_5txpb_3rounds_RSA.txt', 64, 5, 3,
   13.94,
   816.15,
   14.35,
   10.93,
   6.794);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 14.60 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 13.71 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 14.04 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 14.56 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 13.10 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 13.79 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 14.01 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 15.09 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 14.22 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-18' AS node_id, 13.59 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 13.28 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 13.71 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 13.53 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 14.54 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 14.06 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 14.78 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 13.48 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 13.64 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 13.38 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 13.42 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 14.77 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 13.18 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 13.94 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 13.40 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 13.18 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 13.32 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-33' AS node_id, 13.48 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-34' AS node_id, 14.13 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-35' AS node_id, 14.80 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-36' AS node_id, 14.69 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-37' AS node_id, 14.17 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-38' AS node_id, 14.17 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-39' AS node_id, 13.18 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 14.05 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-40' AS node_id, 13.32 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-41' AS node_id, 13.90 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-42' AS node_id, 13.70 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-43' AS node_id, 14.13 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-44' AS node_id, 13.56 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-45' AS node_id, 14.15 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-46' AS node_id, 13.24 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-47' AS node_id, 13.74 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-48' AS node_id, 14.43 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-49' AS node_id, 13.68 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 13.66 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-50' AS node_id, 13.45 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-51' AS node_id, 13.28 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-52' AS node_id, 12.84 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-53' AS node_id, 14.20 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-54' AS node_id, 15.18 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-55' AS node_id, 13.59 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-56' AS node_id, 13.67 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-57' AS node_id, 13.54 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-58' AS node_id, 15.17 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-59' AS node_id, 13.51 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 13.11 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-60' AS node_id, 15.10 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-61' AS node_id, 14.26 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-62' AS node_id, 14.57 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-63' AS node_id, 13.30 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-64' AS node_id, 14.70 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 14.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 14.02 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 15.25 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 890 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 817 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 734 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 658 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 843 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 847 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 882 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 877 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 705 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-18' AS node_id, 807 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 860 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 769 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 756 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 887 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 755 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 726 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 707 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 701 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 810 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 869 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 830 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 887 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 823 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 883 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 866 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 767 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-33' AS node_id, 891 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-34' AS node_id, 882 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-35' AS node_id, 881 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-36' AS node_id, 730 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-37' AS node_id, 879 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-38' AS node_id, 799 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-39' AS node_id, 794 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 714 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-40' AS node_id, 892 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-41' AS node_id, 821 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-42' AS node_id, 857 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-43' AS node_id, 885 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-44' AS node_id, 878 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-45' AS node_id, 876 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-46' AS node_id, 720 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-47' AS node_id, 752 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-48' AS node_id, 890 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-49' AS node_id, 631 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 751 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-50' AS node_id, 766 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-51' AS node_id, 889 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-52' AS node_id, 836 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-53' AS node_id, 894 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-54' AS node_id, 766 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-55' AS node_id, 884 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-56' AS node_id, 888 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-57' AS node_id, 809 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-58' AS node_id, 894 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-59' AS node_id, 723 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 892 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-60' AS node_id, 877 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-61' AS node_id, 796 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-62' AS node_id, 857 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-63' AS node_id, 884 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-64' AS node_id, 775 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 701 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 890 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 734 AS overhead_messages FROM __exp
);


-- 86nodes_5txpb_3rounds_MERKLE.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('MERKLE', '86nodes_5txpb_3rounds_MERKLE.txt', 86, 5, 3,
   0.86,
   850.63,
   32.45,
   12.8,
   31.913);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 0.87 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 0.84 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 0.82 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 0.97 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 0.80 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 0.83 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 0.90 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 0.84 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 0.84 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-18' AS node_id, 0.80 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 0.78 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 0.86 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 0.77 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 0.93 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 0.83 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 0.78 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 0.88 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 0.82 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 0.83 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 0.82 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 0.88 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 0.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 0.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 0.82 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 0.86 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 0.86 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-33' AS node_id, 0.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-34' AS node_id, 0.90 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-35' AS node_id, 0.84 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-36' AS node_id, 0.89 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-37' AS node_id, 0.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-38' AS node_id, 0.92 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-39' AS node_id, 0.99 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 0.89 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-40' AS node_id, 0.79 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-41' AS node_id, 0.87 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-42' AS node_id, 0.86 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-43' AS node_id, 0.89 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-44' AS node_id, 0.80 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-45' AS node_id, 0.86 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-46' AS node_id, 0.85 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-47' AS node_id, 0.80 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-48' AS node_id, 0.85 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-49' AS node_id, 0.85 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 0.85 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-50' AS node_id, 0.80 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-51' AS node_id, 0.82 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-52' AS node_id, 0.95 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-53' AS node_id, 0.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-54' AS node_id, 0.93 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-55' AS node_id, 0.97 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-56' AS node_id, 0.84 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-57' AS node_id, 0.83 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-58' AS node_id, 0.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-59' AS node_id, 0.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 0.87 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-60' AS node_id, 0.79 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-61' AS node_id, 1.14 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-62' AS node_id, 0.84 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-63' AS node_id, 0.84 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-64' AS node_id, 1.00 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-65' AS node_id, 0.86 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-66' AS node_id, 0.96 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-67' AS node_id, 0.83 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-68' AS node_id, 0.98 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-69' AS node_id, 0.87 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 0.85 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-70' AS node_id, 0.83 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-71' AS node_id, 0.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-72' AS node_id, 0.82 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-73' AS node_id, 0.92 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-74' AS node_id, 1.18 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-75' AS node_id, 0.79 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-76' AS node_id, 0.88 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-77' AS node_id, 0.76 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-78' AS node_id, 0.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-79' AS node_id, 0.83 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 0.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-80' AS node_id, 0.79 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-81' AS node_id, 0.85 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-82' AS node_id, 0.81 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-83' AS node_id, 0.86 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-84' AS node_id, 0.78 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-85' AS node_id, 0.79 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-86' AS node_id, 0.86 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 0.89 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 635 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 834 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 841 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 878 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 780 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 895 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 881 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 856 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 769 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-18' AS node_id, 835 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 1020 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 973 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 815 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 643 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 864 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 915 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 726 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 884 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 796 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 829 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 700 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 1001 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 976 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 880 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 856 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 831 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-33' AS node_id, 916 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-34' AS node_id, 604 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-35' AS node_id, 755 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-36' AS node_id, 626 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-37' AS node_id, 878 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-38' AS node_id, 512 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-39' AS node_id, 901 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 692 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-40' AS node_id, 831 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-41' AS node_id, 953 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-42' AS node_id, 818 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-43' AS node_id, 638 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-44' AS node_id, 937 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-45' AS node_id, 611 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-46' AS node_id, 790 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-47' AS node_id, 967 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-48' AS node_id, 824 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-49' AS node_id, 834 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 844 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-50' AS node_id, 843 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-51' AS node_id, 688 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-52' AS node_id, 741 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-53' AS node_id, 873 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-54' AS node_id, 855 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-55' AS node_id, 965 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-56' AS node_id, 881 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-57' AS node_id, 890 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-58' AS node_id, 936 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-59' AS node_id, 852 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 805 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-60' AS node_id, 982 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-61' AS node_id, 941 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-62' AS node_id, 994 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-63' AS node_id, 976 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-64' AS node_id, 928 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-65' AS node_id, 805 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-66' AS node_id, 788 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-67' AS node_id, 971 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-68' AS node_id, 986 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-69' AS node_id, 842 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 887 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-70' AS node_id, 957 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-71' AS node_id, 947 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-72' AS node_id, 873 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-73' AS node_id, 616 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-74' AS node_id, 621 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-75' AS node_id, 980 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-76' AS node_id, 997 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-77' AS node_id, 947 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-78' AS node_id, 765 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-79' AS node_id, 965 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 858 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-80' AS node_id, 1002 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-81' AS node_id, 884 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-82' AS node_id, 977 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-83' AS node_id, 973 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-84' AS node_id, 976 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-85' AS node_id, 955 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-86' AS node_id, 872 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 717 AS overhead_messages FROM __exp
);


-- 86nodes_5txpb_3rounds_RSA.txt
INSERT INTO experiment_summary
  (protocol, filename, nodes, txpb, rounds, avg_tps, avg_overhead, avg_cpu, avg_mem, latency_seconds)
VALUES
  ('RSA', '86nodes_5txpb_3rounds_RSA.txt', 86, 5, 3,
   9.59,
   1054.51,
   8.02,
   11.07,
   7.808);

DELETE FROM __exp;
INSERT INTO __exp(id) VALUES (last_insert_rowid());

INSERT INTO node_tps (experiment_id, node_id, tps)
SELECT id, node_id, tps FROM (
  SELECT id, 'node-1' AS node_id, 9.97 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 9.59 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 9.96 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 9.50 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 9.97 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 9.35 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 10.03 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 9.40 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 9.38 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-18' AS node_id, 9.63 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 10.02 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 8.69 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 9.44 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 9.66 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 9.87 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 9.78 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 9.22 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 9.26 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 9.44 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 9.52 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 9.01 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 9.41 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 9.92 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 9.48 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 9.96 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 9.61 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-33' AS node_id, 10.05 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-34' AS node_id, 9.90 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-35' AS node_id, 9.61 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-36' AS node_id, 9.75 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-37' AS node_id, 9.99 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-38' AS node_id, 9.74 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-39' AS node_id, 9.71 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 9.93 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-40' AS node_id, 9.06 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-41' AS node_id, 9.37 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-42' AS node_id, 9.55 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-43' AS node_id, 8.58 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-44' AS node_id, 10.01 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-45' AS node_id, 9.20 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-46' AS node_id, 9.33 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-47' AS node_id, 9.86 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-48' AS node_id, 9.61 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-49' AS node_id, 8.15 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 10.33 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-50' AS node_id, 8.96 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-51' AS node_id, 9.22 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-52' AS node_id, 9.79 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-53' AS node_id, 9.06 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-54' AS node_id, 9.84 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-55' AS node_id, 9.20 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-56' AS node_id, 9.96 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-57' AS node_id, 9.69 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-58' AS node_id, 9.54 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-59' AS node_id, 9.95 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 9.46 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-60' AS node_id, 9.89 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-61' AS node_id, 10.10 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-62' AS node_id, 9.07 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-63' AS node_id, 9.82 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-64' AS node_id, 9.41 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-65' AS node_id, 10.95 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-66' AS node_id, 9.28 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-67' AS node_id, 9.14 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-68' AS node_id, 9.86 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-69' AS node_id, 9.68 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 9.16 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-70' AS node_id, 9.70 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-71' AS node_id, 9.01 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-72' AS node_id, 8.40 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-73' AS node_id, 9.91 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-74' AS node_id, 9.63 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-75' AS node_id, 9.88 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-76' AS node_id, 9.75 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-77' AS node_id, 9.56 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-78' AS node_id, 8.52 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-79' AS node_id, 10.82 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 9.48 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-80' AS node_id, 8.61 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-81' AS node_id, 9.37 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-82' AS node_id, 9.63 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-83' AS node_id, 9.78 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-84' AS node_id, 10.04 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-85' AS node_id, 10.94 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-86' AS node_id, 10.14 AS tps FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 10.15 AS tps FROM __exp
);

INSERT INTO node_overhead (experiment_id, node_id, overhead_messages)
SELECT id, node_id, overhead_messages FROM (
  SELECT id, 'node-1' AS node_id, 1022 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-10' AS node_id, 1139 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-11' AS node_id, 979 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-12' AS node_id, 1141 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-13' AS node_id, 1040 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-14' AS node_id, 1104 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-15' AS node_id, 1139 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-16' AS node_id, 988 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-17' AS node_id, 1133 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-18' AS node_id, 951 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-19' AS node_id, 1036 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-2' AS node_id, 1106 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-20' AS node_id, 936 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-21' AS node_id, 1066 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-22' AS node_id, 1126 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-23' AS node_id, 989 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-24' AS node_id, 1094 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-25' AS node_id, 1086 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-26' AS node_id, 1116 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-27' AS node_id, 1144 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-28' AS node_id, 973 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-29' AS node_id, 1034 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-3' AS node_id, 967 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-30' AS node_id, 1132 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-31' AS node_id, 1097 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-32' AS node_id, 1135 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-33' AS node_id, 1123 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-34' AS node_id, 1111 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-35' AS node_id, 968 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-36' AS node_id, 940 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-37' AS node_id, 1128 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-38' AS node_id, 1116 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-39' AS node_id, 1129 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-4' AS node_id, 1111 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-40' AS node_id, 1087 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-41' AS node_id, 1147 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-42' AS node_id, 1093 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-43' AS node_id, 966 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-44' AS node_id, 1110 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-45' AS node_id, 954 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-46' AS node_id, 1043 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-47' AS node_id, 1079 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-48' AS node_id, 1137 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-49' AS node_id, 1146 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-5' AS node_id, 984 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-50' AS node_id, 1121 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-51' AS node_id, 1022 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-52' AS node_id, 1076 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-53' AS node_id, 1019 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-54' AS node_id, 1043 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-55' AS node_id, 1145 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-56' AS node_id, 1086 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-57' AS node_id, 838 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-58' AS node_id, 1097 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-59' AS node_id, 958 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-6' AS node_id, 1132 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-60' AS node_id, 1014 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-61' AS node_id, 1049 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-62' AS node_id, 1104 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-63' AS node_id, 1134 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-64' AS node_id, 956 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-65' AS node_id, 979 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-66' AS node_id, 1129 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-67' AS node_id, 1098 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-68' AS node_id, 1111 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-69' AS node_id, 1002 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-7' AS node_id, 1024 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-70' AS node_id, 1116 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-71' AS node_id, 1024 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-72' AS node_id, 916 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-73' AS node_id, 1010 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-74' AS node_id, 1034 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-75' AS node_id, 1078 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-76' AS node_id, 1016 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-77' AS node_id, 1079 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-78' AS node_id, 863 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-79' AS node_id, 938 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-8' AS node_id, 1101 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-80' AS node_id, 1050 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-81' AS node_id, 1060 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-82' AS node_id, 1002 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-83' AS node_id, 1143 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-84' AS node_id, 1034 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-85' AS node_id, 940 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-86' AS node_id, 1126 AS overhead_messages FROM __exp
  UNION ALL
  SELECT id, 'node-9' AS node_id, 976 AS overhead_messages FROM __exp
);

