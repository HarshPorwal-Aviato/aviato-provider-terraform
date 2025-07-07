terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.68.0"
    }
  }
}

provider "google" {
  project = var.project_id
}

resource "google_project_service_identity" "artifact_registry" {
  provider = google
  project  = var.project_id
  service  = "artifactregistry.googleapis.com"
}

resource "google_artifact_registry_repository" "default" {
  provider = google
  project  = var.project_id
  location = "us-central1"
  repository_id = "default-repository"
  format = "DOCKER"
}

resource "google_project_service" "artifactregistry" {
  provider = google
  project            = var.project_id
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "containeranalysis" {
  provider = google
  project            = var.project_id
  service            = "containeranalysis.googleapis.com"
  disable_on_destroy = false

  depends_on = [google_project_service_identity.artifact_registry, google_artifact_registry_repository.default, google_project_service.artifactregistry]
}

resource "google_container_analysis_occurrence" "default" {
  provider = google
  project = var.project_id
  note_name = "providers/goog-gke-os-vulnscan/notes/ubuntu"
  resource_uri = "https://us-central1-docker.pkg.dev/cloudrun/container/hello:latest"
}

resource "google_project_service" "cloudasset" {
  provider = google
  project            = var.project_id
  service            = "cloudasset.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_iam_member" "cloudasset_member" {
  project = var.project_id
  role    = "roles/cloudasset.viewer"
  member  = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-cloudasset.iam.gserviceaccount.com"
  depends_on = [google_project_service.cloudasset]
}

data "google_project" "project" {
  project_id = var.project_id
}

resource "google_compute_default_network" "default" {
  provider = google
  project  = var.project_id  
  action = "delete"
}

resource "google_compute_network" "default" {
  provider = google
  project = var.project_id
  name = var.default_network_name
  delete_default_routes = true
}

resource "google_project_service" "oslogin" {
  provider = google
  project = var.project_id
  service = "oslogin.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_project_metadata" "default" {
  provider = google
  project = var.project_id
  metadata = {
    enable-oslogin = "TRUE"
  }

  depends_on = [google_project_service.oslogin]
}

resource "google_logging_project_sink" "default" {
  provider = google
  name = "all-logs"
  project = var.project_id
  destination = "storage.googleapis.com/${var.project_id}-logs"
  filter = "NOT logName:\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND NOT logName:\"projects/${var.project_id}/logs/system.gke.io%2Faudit\""
}

resource "google_compute_firewall" "rdp" {
  provider = google
  name    = "default-allow-rdp"
  project = var.project_id
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["rdp"]
}

resource "google_compute_firewall" "ssh" {
  provider = google
  name    = "default-allow-ssh"
  project = var.project_id
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["ssh"]
}

resource "google_storage_bucket" "default" {
  provider = google
  name          = var.bucket_names[0]
  project       = var.project_id
  location      = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "bucket2" {
  provider = google
  name          = var.bucket_names[1]
  project       = var.project_id
  location      = "US"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "bucket3" {
  provider = google
  name          = var.bucket_names[2]
  project       = var.project_id
  location      = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}

resource "google_compute_subnetwork" "default" {
  for_each = toset(var.regions)
  name                     = "default"
  ip_cidr_range          = "10.10.10.0/24"
  network                  = "default"
  region                   = each.value
  project                  = var.project_id
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}
