PROJECT_ID = "nomadic-flame-354021"
VPC_NAME = "prod-milvus-vpc"
CLUSTER_NAME = "milvus-prod-cluster"
REGION = "us-east1"
ZONE = "us-east1-b"
NODE_POOL_NAME = "milvus-prod-node-pool"
NODE_POOL_COUNT = 2

MACHINE_TYPE = "e2-standard-4"
IMAGE_TYPE = "COS_CONTAINERD"
DISK_TYPE = "pd-standard"
DISK_SIZE = 25
MAX_PODS_PER_NODE = 110
NODE_POOL_INSTANCE_TYPE = "preemptible"
