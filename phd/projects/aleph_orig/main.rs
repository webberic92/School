use tokio::sync::{Arc, Mutex};
use std::collections::{HashMap, HashSet};
use tokio::task;
use tracing::{info, error};
use postgres::{Client, NoTls};

// Define the Node struct, which represents each node in the network.
struct Node {
    id: usize,  // Unique identifier for the node.
    total_nodes: usize,  // Total number of nodes in the network.
    f: usize,  // Fault tolerance (number of Byzantine nodes the network can tolerate).
    round: usize,  // Current round number the node is processing.
    received_propose: bool,  // Flag to check if the node has already received a propose message in the current round.
    storage: Arc<Mutex<HashMap<usize, Vec<u8>>>>,  // Shared storage for data received by the node.
}

// Define the MerkleTree struct to represent a Merkle tree for data integrity checks.
#[derive(Clone, Debug)]
struct MerkleTree {
    root: Vec<u8>,  // Root hash of the Merkle tree.
    branches: HashMap<usize, Vec<u8>>,  // Merkle branches per node (used for verifying data).
}

// Implement methods for the MerkleTree struct.
impl MerkleTree {
    fn new(data: &[u8], n: usize) -> Self {
        let root = data.to_vec();  // Simplified representation of the Merkle root.
        let branches = (0..n).map(|i| (i, data.to_vec())).collect();  // Generate branches (simplified).
        MerkleTree { root, branches }  // Return the newly created MerkleTree struct.
    }

    fn branch(&self, index: usize) -> Option<Vec<u8>> {
        self.branches.get(&index).cloned()  // Return a clone of the Merkle branch if it exists.
    }
}

// Implement methods for the Node struct.
impl Node {
    fn new(id: usize, total_nodes: usize, f: usize, storage: Arc<Mutex<HashMap<usize, Vec<u8>>>>) -> Self {
        Node { id, total_nodes, f, round: 0, received_propose: false, storage }  // Initialize a new node with the given parameters.
    }

    async fn propose(&self, data: Vec<u8>) {
        let shares: Vec<Vec<u8>> = (0..self.total_nodes).map(|_| data.clone()).collect();
        let merkle_tree = MerkleTree::new(&data, self.total_nodes);
        for i in 0..self.total_nodes {
            let branch = merkle_tree.branch(i).unwrap();
            self.send_propose(i, merkle_tree.root.clone(), branch, shares[i].clone()).await;
        }
    }

    async fn send_propose(&self, to: usize, root: Vec<u8>, branch: Vec<u8>, share: Vec<u8>) {
        info!("Node {} sends propose to {} with root {:?} and share {:?}", self.id, to, root, share);
    }

    async fn handle_propose(&mut self, root: Vec<u8>, branch: Vec<u8>, share: Vec<u8>) {
        if self.received_propose {
            return;
        }

        if self.check_size(&share) {
            self.wait_for_dag().await;
            self.multicast_prevote(root.clone(), branch, share).await;
        }

        self.received_propose = true;
    }

    fn check_size(&self, share: &Vec<u8>) -> bool {
        let size_limit = 1024;
        share.len() <= size_limit
    }

    async fn wait_for_dag(&self) {
        info!("Node {} waits for DAG to reach round {}", self.id, self.round - 1);
    }

    async fn multicast_prevote(&self, root: Vec<u8>, branch: Vec<u8>, share: Vec<u8>) {
        info!("Node {} multicasts prevote with root {:?} and share {:?}", self.id, root, share);
    }

    async fn handle_prevote(&self, root: Vec<u8>, shares: Vec<Vec<u8>>) {
        let unit = shares.concat();
        if !self.is_valid_unit(&unit) {
            return;
        }

        self.wait_for_parents().await;
        self.multicast_commit(root).await;
    }

    fn is_valid_unit(&self, unit: &[u8]) -> bool {
        !unit.is_empty()
    }

    async fn wait_for_parents(&self) {
        info!("Node {} waits for all parents to be received", self.id);
    }

    async fn multicast_commit(&self, root: Vec<u8>) {
        info!("Node {} multicasts commit with root {:?}", self.id, root);
    }
}

#[tokio::main]
async fn main() {
    tracing_subscriber::fmt::init(); // Initialize the tracing subscriber for logging

    let storage = Arc::new(Mutex::new(HashMap::new()));
    let nodes: Vec<Node> = (0..5).map(|id| Node::new(id, 5, 1, storage.clone())).collect();

    nodes[0].propose(vec![1, 2, 3, 4]).await; // Node 0 proposes a unit

    // Example connection to PostgreSQL database for storing results
    match Client::connect("host=localhost user=postgres", NoTls) {
        Ok(mut client) => {
            client.batch_execute("
                CREATE TABLE IF NOT EXISTS metrics (
                    id SERIAL PRIMARY KEY,
                    node_id INTEGER,
                    metric_name TEXT,
                    value FLOAT
                )
            ").unwrap();
            info!("Connected to PostgreSQL and ensured table exists.");
        },
        Err(e) => error!("Failed to connect to PostgreSQL: {}", e),
    }
}
