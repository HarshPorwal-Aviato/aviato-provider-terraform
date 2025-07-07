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

resource "google_project_service_identity" "gcs_service_account" {
  provider = google
  project  = var.project_id
  service  = "storage.googleapis.com"
}

resource "google_project_service" "artifactregistry" {
  provider           = google
  project            = var.project_id
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "containeranalysis" {
  provider           = google
  project            = var.project_id
  service            = "containeranalysis.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudasset" {
  provider           = google
  project            = var.project_id
  service            = "cloudasset.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "dns" {
  provider           = google
  project            = var.project_id
  service            = "dns.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "logging" {
  provider           = google
  project            = var.project_id
  service            = "logging.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "oslogin" {
  provider           = google
  project            = var.project_id
  service            = "oslogin.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "compute" {
  provider           = google
  project            = var.project_id
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}

resource "google_artifact_registry_repository" "container_repository" {
  provider      = google
  project       = var.project_id
  location      = "us"
  repository_id = "container-repo"
  format        = "DOCKER"
}

resource "google_container_analysis_occurrence" "container_occurrence" {
  provider = google

  project  = var.project_id
  note_name = "projects/goog-analysis/notes/PACKAGE_VULNERABILITY"

  resource_uri = "https://us-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.container_repository.name}/test-image:latest"

  package_issue {
    affected_location {
      cpe_uri = "cpe:/o:debian:debian_linux:8"
      package = "foo"
      version {
        epoch = "1"
        name  = "1.0"
      }
    }
    effective_severity = "HIGH"
    fixed_location {
      cpe_uri = "cpe:/o:debian:debian_linux:9"
      package = "foo"
      version {
        epoch = "2"
        name  = "2.0"
      }
    }
  }
}

resource "google_compute_default_network" "default" {
  provider = google
  project  = var.project_id
  name     = "default"

  deletion_protection = var.default_network_deletion
}

resource "google_compute_network_dns_policies" "default" {
  provider = google
  project  = var.project_id
  name     = "default"
  network  = "default"
  enable_inbound_forwarding = true
}

resource "google_project_iam_member" "cloud_asset_inventory_role" {
  project = var.project_id
  role    = "roles/cloudasset.serviceAgent"
  member  = "serviceAccount:${data.google_project.project.number}@gcp-sa-cloudasset.iam.gserviceaccount.com"
}

data "google_project" "project" {
  project_id = var.project_id
}

resource "google_project_default_service_accounts" "default_service_accounts" {
  provider = google
  project  = var.project_id
  action   = "DISABLE_DELETE"
}

resource "google_compute_subnetwork" "default" {
  provider = google
  for_each = toset(var.regions)

  name                     = "default"
  ip_cidr_range            = "10.10.10.0/24"
  region                   = each.key
  network                  = "default"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_logging_project_sink" "default" {
  name = "default-sink"
  description = "Copies of all log entries"
  project = var.project_id
  destination = "storage.googleapis.com/${var.project_id}-central-logs"
  filter = "NOT logName:projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity AND NOT logName:projects/${var.project_id}/logs/system.slice AND NOT logName:projects/${var.project_id}/logs/events"
  unique_writer_identity = true
}
