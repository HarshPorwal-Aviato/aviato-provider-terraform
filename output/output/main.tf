terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.0"
    }
  }
}

provider "google" {
  project = var.project_id
}

provider "google-beta" {
  project = var.project_id
}

resource "google_project_service_identity" "container_analysis" {
  project = var.project_id
  service = "containeranalysis.googleapis.com"
}

resource "google_project_service" "container_analysis" {
  project            = var.project_id
  service            = "containeranalysis.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "container_scanning" {
  project            = var.project_id
  service            = "containerscanning.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudasset" {
  project            = var.project_id
  service            = "cloudasset.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_network" "default" {
  name                    = "default"
  project                 = var.project_id
  delete_default_routes = true

  lifecycle {
    ignore_changes = [
      auto_create_subnetworks,
    ]
  }
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "default-allow-ssh"
  project = var.project_id
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.restricted_ssh_source_ranges
  target_tags   = []

  lifecycle {
    replace_triggered_by = [
      google_compute_network.default
    ]
  }
}

resource "google_compute_firewall" "allow_rdp" {
  name    = "default-allow-rdp"
  project = var.project_id
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = var.restricted_rdp_source_ranges
  target_tags   = []

    lifecycle {
    replace_triggered_by = [
      google_compute_network.default
    ]
  }
}

resource "google_compute_subnetwork" "default_subnet" {
  for_each = toset(var.regions)

  name                     = "default"
  ip_cidr_range            = "10.128.0.0/20"
  region                   = each.value
  network                  = "default"
  project                  = var.project_id
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }

  enable_flow_logs = true

}

resource "google_project_metadata" "default" {
  project = var.project_id

  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_storage_bucket_iam_binding" "no_public_access_static_assets" {
  bucket = "static-assets-for-game-fight"
  role   = "roles/storage.objectViewer"

  members = []
}

resource "google_storage_bucket" "bucket_uniform_level_access1" {
  name          = "aviato-game-fight-rvxirf.appspot.com"
  project       = var.project_id
  location      = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "bucket_uniform_level_access2" {
  name          = "aviato-game-fight-rvxirf_bucket"
  project       = var.project_id
  location      = "US"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "bucket_uniform_level_access3" {
  name          = "staging.aviato-game-fight-rvxirf.appspot.com"
  project       = var.project_id
  location      = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}

resource "google_project_iam_audit_config" "audit_config" {
  project = var.project_id
  service = "allServices"

  audit_log_config {
    log_type = "ADMIN_READ"
  }

  audit_log_config {
    log_type = "DATA_READ"
  }

  audit_log_config {
    log_type = "DATA_WRITE"
  }
}

resource "google_project_service" "artifactregistry" {
  project = var.project_id
  service = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}
