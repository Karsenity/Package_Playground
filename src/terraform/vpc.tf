resource "google_compute_network" "vpc_network" {
  name = var.VPC_NAME
  auto_create_subnetworks = false
  routing_mode = "GLOBAL"
}

resource "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
  name          = "test-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-east1"
  network       = google_compute_network.vpc_network.id
#  secondary_ip_range {
#    range_name    = "tf-test-secondary-range-update1"
#    ip_cidr_range = "192.168.10.0/24"
#  }
}


resource "google_compute_firewall" "milvus_ingress_firewall_rule" {
  name    = "milvus-ingress"
  network = google_compute_network.vpc_network.name
  description = "Allow ingress traffic for Milvus on port 19530"
  source_ranges = ["0.0.0.0/0"]
  priority = 1000
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports = ["19530"]
  }
}
