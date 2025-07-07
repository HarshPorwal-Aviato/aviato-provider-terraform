terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.24.0"
    }
  }
}

provider "google" {
  project = var.project_id
}

resource "google_project_service_identity" "default" {
  provider = google
  project  = var.project_id
  service  = "containerregistry.googleapis.com"
}

resource "google_project_service" "artifactregistry" {
  provider           = google
  project            = var.project_id
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_artifact_registry_repository" "default" {
  provider      = google
  project       = var.project_id
  location      = "us"
  repository_id = "my-repo"
  format        = "DOCKER"
}

resource "google_container_analysis_occurrence" "default" {
  provider = google
  project  = var.project_id
  note_name = "projects/goog-vulnscan/notes/PACKAGE_VULNERABILITY"
  resource_uri = "https://gcr.io/cloud-marketplace/nginx:1.16.0"
}

resource "google_project_iam_member" "container_analysis" {
  project = var.project_id
  role    = "roles/containeranalysis.occurrences.viewer"
  member  = "serviceAccount:${google_project_service_identity.default.email}"
}

resource "google_project_service" "cloudasset" {
  provider           = google
  project            = var.project_id
  service            = "cloudasset.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "oslogin" {
  provider           = google
  project            = var.project_id
  service            = "oslogin.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_network" "default" {
  provider = google
  name                    = "default"
  project                 = var.project_id
  delete_default_routes = true
}

resource "google_compute_network" "vpc_networks" {
  for_each = toset(var.default_networks)
  provider = google
  name = each.value
  project = var.project_id
  auto_create_subnetworks = false
  delete_default_routes = true
}

resource "google_compute_firewall" "disable_default_rdp_ssh" {
  for_each = toset(var.default_firewall_rules)
  provider = google
  name    = each.value
  project = var.project_id
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["0"]
  }

  direction = "INGRESS"

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["default"]
}

resource "google_compute_subnetwork" "subnetworks" {
  for_each = toset(var.regions)
  provider = google
  name                     = "default"
  project                  = var.project_id
  region                   = each.value
  network                  = "default"
  ip_cidr_range            = "10.0.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_storage_bucket" "buckets" {
  for_each = toset(var.buckets)
  provider = google
  name          = each.value
  project       = var.project_id
  location      = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}

resource "google_logging_project_sink" "default" {
  provider = google
  name        = "all-logs"
  project     = var.project_id
  destination = "bigquery.googleapis.com/projects/${var.project_id}/datasets/logging_dataset"
  filter      = "NOT logName:projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Fdata_access"
}

resource "google_bigquery_dataset" "default" {
  provider = google
  name    = "logging_dataset"
  project = var.project_id
  location = "US"
}
