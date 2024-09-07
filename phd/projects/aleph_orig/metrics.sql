--  Database Integration with PostgreSQL
-- The Rust code connects to a PostgreSQL database to log metrics such as transaction throughput, latency, and communication overhead. Ensure PostgreSQL is set up and running, and adjust the connection string accordingly.
-- Install PostgreSQL on AWS or Locally
-- You can set up a PostgreSQL database on AWS RDS or install it locally for testing purposes.

CREATE TABLE metrics (
    id SERIAL PRIMARY KEY,
    node_id INTEGER,
    metric_name TEXT,
    value FLOAT
);
