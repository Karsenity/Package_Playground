#resource "google_service_account" "milvus_service_account" {
#  account_id   = "service-account-id"
#  display_name = "Service Account"
#}

resource "google_container_cluster" "kubernetes_cluster" {
  name     = var.CLUSTER_NAME
  location = var.ZONE
  network = google_compute_network.vpc_network.name
  subnetwork = google_compute_subnetwork.network-with-private-secondary-ip-ranges.name
  default_max_pods_per_node = var.MAX_PODS_PER_NODE
  min_master_version = var.NODE_POOL_VERSION

#  release_channel {
#    channel = var.CLUSTER_RELEASE_CHANNEL
#  }

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "kubernetes_node_pool" {
  name       = var.NODE_POOL_NAME
  location   = var.ZONE
  cluster    = google_container_cluster.kubernetes_cluster.name
  node_count = var.NODE_POOL_COUNT
  version = var.NODE_POOL_VERSION
  node_config {
    # preemptible are spot instances that last at most 24 hours
    # can also use spot instances instead, but not on free-tier
    # Using preemptible or spot instances cuts compute costs between 60-91%

    preemptible  = (var.NODE_POOL_INSTANCE_TYPE == "preemptible")

    # Spot is currently only available using google-beta and thus commented out.
    # spot = (var.NODE_POOL_INSTANCE_TYPE == "spot")
    machine_type = var.MACHINE_TYPE
    image_type = var.IMAGE_TYPE
    disk_type = var.DISK_TYPE
    disk_size_gb = var.DISK_SIZE

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
#    service_account = google_service_account.default.email
#    oauth_scopes    = [
#      "https://www.googleapis.com/auth/cloud-platform"
#    ]
  }
}