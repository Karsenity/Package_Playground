terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("milvus-testing-e9b82122e656.json")

  project = "milvus-testing"
  region  = "us-east1"
  zone    = "us-east1-b"
}

