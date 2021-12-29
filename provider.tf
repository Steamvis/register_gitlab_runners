terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.2.0"
    }
  }
}

provider "google" {
  credentials = file("${path.module}/credentials.json")

  project = var.project_id
  region  = var.region
  zone    = var.zone
}