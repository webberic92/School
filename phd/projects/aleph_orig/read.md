# Aleph Protocol Setup and Deployment Guide

## Table of Contents

1. [Set Up Rust Environment](#1-set-up-rust-environment)
2. [Install and Configure PostgreSQL](#2-install-and-configure-postgresql)
3. [Run the Rust Program](#3-run-the-rust-program)
4. [Set Up AWS CDK for Infrastructure Deployment](#4-set-up-aws-cdk-for-infrastructure-deployment)
5. [Analyze Metrics with Jupyter Notebooks](#5-analyze-metrics-with-jupyter-notebooks)

## 1. Set Up Rust Environment

To implement and test the original Aleph protocol with Merkle trees, follow these steps to set up your Rust development environment.

### Steps:

1. **Install Rust and Cargo:**
   - If Rust is not installed, download it from [Rust's official website](https://www.rust-lang.org/tools/install).
   - Run the following command to install Rust and Cargo:
     ```sh
     curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
     ```
   - Follow the on-screen instructions and restart your terminal.

2. **Clone the Aleph Protocol Repository:**
   - Clone the repository for the Aleph protocol or create a new Rust project:
     ```sh
     git clone <aleph-protocol-repo-url>
     cd aleph-protocol-repo
     ```
   - If you are creating a new project:
     ```sh
     cargo new aleph_protocol --bin
     cd aleph_protocol
     ```

3. **Add Dependencies to `Cargo.toml`:**
   - Open the `Cargo.toml` file and add the following dependencies:
     ```toml
     [dependencies]
     tokio = { version = "1", features = ["full"] }
     tracing = "0.1"
     tracing-subscriber = "0.2"
     postgres = "0.19"
     ```
   - Save the `Cargo.toml` file.

## 2. Install and Configure PostgreSQL

The Rust program uses PostgreSQL to log metrics such as transaction throughput, latency, and communication overhead. Follow these steps to set up PostgreSQL.

### Steps:

1. **Install PostgreSQL:**
   - **Locally:** Follow the instructions on [PostgreSQL's official website](https://www.postgresql.org/download/) for your operating system.
   - **On AWS RDS:** You can also set up PostgreSQL on AWS RDS. Follow the AWS [RDS documentation](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_CreatePostgreSQLInstance.html).

2. **Create a PostgreSQL Database and Table:**
   - Log in to PostgreSQL using `psql` or any other client:
     ```sh
     psql -U postgres
     ```
   - Create a new database:
     ```sql
     CREATE DATABASE aleph_protocol;
     \c aleph_protocol;
     ```
   - Create the `metrics` table:
     ```sql
     CREATE TABLE metrics (
         id SERIAL PRIMARY KEY,
         node_id INTEGER,
         metric_name TEXT,
         value FLOAT
     );
     ```

3. **Configure the Database Connection:**
   - Update the database connection string in the Rust code (`main.rs`) if necessary:
     ```rust
     match Client::connect("host=localhost user=postgres dbname=aleph_protocol", NoTls) { ... }
     ```
   - Adjust the connection string to match your setup (e.g., username, host, database name).

## 3. Run the Rust Program

With Rust and PostgreSQL set up, you can now run the Rust program to implement the original Aleph protocol.

### Steps:

1. **Compile the Rust Code:**
   - Open your terminal in the root directory of the project.
   - Run the following command to build the project:
     ```sh
     cargo build
     ```

2. **Run the Rust Program:**
   - Execute the program with:
     ```sh
     cargo run
     ```
   - The program should start executing the Aleph protocol and log output to the console.

3. **Check Logging and Metrics:**
   - Ensure that logs are being output to the console via the `tracing` crate.
   - Verify that metrics are being recorded in the PostgreSQL `metrics` table:
     ```sql
     SELECT * FROM metrics;
     ```

## 4. Set Up AWS CDK for Infrastructure Deployment

We will use AWS Cloud Development Kit (CDK) to deploy the necessary infrastructure for running the Aleph protocol on AWS.

### Steps:

1. **Install AWS CDK:**
   - Install AWS CDK globally using npm:
     ```sh
     npm install -g aws-cdk
     ```

2. **Create a New CDK Application:**
   - Navigate to your project directory and initialize a new CDK application:
     ```sh
     mkdir aleph-cdk
     cd aleph-cdk
     cdk init app --language=typescript
     ```

3. **Add AWS CDK Dependencies:**
   - Install necessary AWS CDK dependencies:
     ```sh
     npm install @aws-cdk/aws-ec2 @aws-cdk/aws-rds @aws-cdk/aws-ssm constructs
     ```

4. **Create AWS Infrastructure:**
   - Use the provided `cdk_infrastructure.ts` code to define the infrastructure:
   - Open `lib/aleph-cdk-stack.ts` and replace its content with the AWS CDK code provided.

5. **Deploy the Infrastructure:**
   - Run the following command to deploy the CDK stack:
     ```sh
     cdk deploy
     ```
   - Follow the prompts to approve the deployment.

6. **Access Database Information:**
   - After deployment, use AWS Systems Manager (SSM) to retrieve the PostgreSQL endpoint and credentials created by the CDK.

## 5. Analyze Metrics with Jupyter Notebooks

Once the experiments are complete and metrics have been collected, use Jupyter Notebooks to analyze and visualize the data.

### Steps:

1. **Install Jupyter Notebooks:**
   - Install Jupyter Notebooks if you haven't already:
     ```sh
     pip install notebook
     ```

2. **Start Jupyter Notebooks:**
   - Run the following command to start Jupyter:
     ```sh
     jupyter notebook
     ```
   - Open your browser to the provided URL.

3. **Connect to PostgreSQL Database:**
   - Use a Python library like `psycopg2` or `SQLAlchemy` to connect to the PostgreSQL database:
   ```python
   import psycopg2
   import pandas as pd

   # Connect to the PostgreSQL database
   conn = psycopg2.connect(
       host="your-db-host",
       database="aleph_protocol",
       user="postgres",
       password="your-db-password"
   )

   # Query the metrics table
   df = pd.read_sql("SELECT * FROM metrics", conn)

   # Display the data
   print(df)
<!-- import matplotlib.pyplot as plt
import seaborn as sns

# Plot transaction throughput
sns.lineplot(x="node_id", y="value", hue="metric_name", data=df)
plt.title("Transaction Throughput by Node")
plt.show() -->
