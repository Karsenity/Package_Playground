variable "PROJECT_ID" {
  type = string
  description = "The ID for the project being used on Google Cloud"
}

variable "VPC_NAME" {
  type        = string
  description = "Name of the VPC network"
  default     = "default-vpc"
}

variable "CLUSTER_NAME" {
  type = string
  description = "Name of the Kubernetes cluster"
}

variable "REGION" {
  type = string
  description = "Default region that everything will be created in"
  default = "us-east1"
}

variable "ZONE" {
  type = string
  description = "Default zone for things to be created in"
  default = "us-central1-a"
}

variable "NODE_POOL_NAME" {
  type = string
  description = "Name of the node pool for the Kubernetes cluster"
}

variable "NODE_POOL_COUNT" {
  type = number
  description = "Number of nodes in the node pool"
}

variable "MACHINE_TYPE" {
  type = string
  description = "Type of machine used to create the node pool. e2 machines are cost optimized"
  default = "e2-medium"
}

variable "IMAGE_TYPE" {
  type = string
  description = "Type of image being used for the nodes of the cluster"
}

variable "DISK_TYPE" {
  type = string
  description = "Type of disk to be used for nodes in cluster"
  default = "pd-standard"
}

variable "DISK_SIZE" {
  type = number
  description = "Number of gigabytes to allocate each node"
}

variable "MAX_PODS_PER_NODE" {
  type = number
  description = "Maximum number of pods allowed on each node of the cluster. Documentation seems to imply this should be either 110, 5000, 150000, or 300000. Also implies this only matters for large clusters"
  default = 110
}

variable "NODE_POOL_INSTANCE_TYPE" {
  type = string
  description = "Type of instance to be used for the node pool. By default uses standard instance, but can be specified to preemptible or spot"
  default = null
}

variable "NODE_POOL_VERSION" {
  type = string
  description = "Version of Kubernetes to use for each node in the pool"
  default = "1.23.6-gke.1700"
}

variable "CLUSTER_RELEASE_CHANNEL" {
  type = string
  description = "Release channel for current version of kubernetes. Regular is default, and ensures only well-tested releases are used"
  default = "regular"
}