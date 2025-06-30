terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_project_service_identity" "artifact_registry" {
  provider = google
  project  = var.project_id
  service  = "artifactregistry.googleapis.com"
}

resource "google_project_service" "containeranalysis" {
  provider = google
  project  = var.project_id
  service            = "containeranalysis.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudasset" {
  provider = google
  project  = var.project_id
  service            = "cloudasset.googleapis.com"
  disable_on_destroy = false
}

resource "google_storage_bucket_iam_binding" "uniform_bucket_level_access_1" {
  bucket = "aviato-game-fight-rvxirf.appspot.com"
  role   = "roles/storage.objectViewer"
  members = [
    "allUsers",
  ]
}

resource "google_storage_bucket_iam_binding" "uniform_bucket_level_access_2" {
  bucket = "aviato-game-fight-rvxirf_bucket"
  role   = "roles/storage.objectViewer"
  members = [
    "allUsers",
  ]
}

resource "google_storage_bucket_iam_binding" "uniform_bucket_level_access_3" {
  bucket = "staging.aviato-game-fight-rvxirf.appspot.com"
  role   = "roles/storage.objectViewer"
  members = [
    "allUsers",
  ]
}

resource "google_compute_firewall" "default_allow_ssh" {
  name    = "default-allow-ssh"
  project = var.project_id
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = var.default_allow_ssh_source_range
}

resource "google_compute_firewall" "default_allow_rdp" {
  name    = "default-allow-rdp"
  project = var.project_id
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
  source_ranges = var.default_allow_rdp_source_range
}

resource "google_compute_network" "default" {
  name                    = "default"
  project                 = var.project_id
  auto_create_subnetworks = "false"
  delete_default_routes = true
}

resource "google_compute_network_dns_logging_policy" "default" {
  name        = "default"
  project     = var.project_id
  network     = "default"
  logging_config {
    enable_logging = true
  }
}

resource "google_project_metadata" "oslogin" {
  project = var.project_id

  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_compute_subnetwork" "subnet_with_flow_logs" {
  for_each = toset(var.default_vpc_regions)
  name                     = "default"
  project                  = var.project_id
  ip_cidr_range            = "10.128.0.0/20"
  region                   = each.key
  network                  = "default"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}
