terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = "us-central1"
}

provider "google" {
  alias   = "gcp"
  project = var.project_id
  region  = "global"
}
