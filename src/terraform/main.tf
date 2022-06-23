terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
  backend "gcs" {
    bucket = "al-tf-states"
    prefix = "milvus-cluster"
  }
}

provider "google" {
  project = var.PROJECT_ID
  region  = var.REGION
  zone    = var.ZONE
}