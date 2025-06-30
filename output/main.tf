terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = "us-central1"
}

resource "google_project_metadata" "project_metadata" {
  project = var.project_id

  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_project_service" "artifactregistry" {
  project = var.project_id
  service = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "containeranalysis" {
  project = var.project_id
  service = "containeranalysis.googleapis.com"
  disable_on_destroy = false
  depends_on = [google_project_service.artifactregistry]
}

resource "google_project_service" "cloudasset" {
  project = var.project_id
  service = "cloudasset.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_network" "default" {
  name                    = "default"
  project                 = var.project_id
  delete_default_routes = true
}

resource "google_compute_network" "vpc_network" {
  name                    = "vpc-network"
  project                 = var.project_id
  auto_create_subnetworks = "false"
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh-from-defined-range"
  network = google_compute_network.vpc_network.name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.default_ssh_source_range
}

resource "google_compute_firewall" "allow_rdp" {
  name    = "allow-rdp-from-defined-range"
  network = google_compute_network.vpc_network.name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = var.default_rdp_source_range
}

resource "google_compute_subnetwork" "default_subnet" {
  for_each = toset(var.regions_with_default_subnet)

  name          = "default"
  ip_cidr_range = "10.10.10.0/24"
  network       = google_compute_network.vpc_network.name
  region        = each.value
  project = var.project_id
  enable_flow_logs = true
}

resource "google_storage_bucket" "gcs_logging_bucket" {
  name          = var.gcs_logging_bucket
  project       = var.project_id
  location      = "US"
  force_destroy = true
  uniform_bucket_level_access = true
}

resource "google_logging_project_sink" "gcp_logging_sink" {
  name        = "all-logs-to-gcs"
  project     = var.project_id
  destination = "storage.googleapis.com/${google_storage_bucket.gcs_logging_bucket.name}"
  filter      = "NOT logName:\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Fdata_access\""
}

resource "google_storage_bucket" "gcs_buckets" {
  for_each = toset(var.gcs_buckets_uniform_acl)

  name          = each.key
  project       = var.project_id
  location      = "AUSTRALIA-SOUTHEAST1"
  force_destroy = true
  uniform_bucket_level_access = true
}

resource "google_iam_policy" "compute_default_service_account_policy" {
  name = "computeDefaultSAPolicy"
  policy_data = data.google_iam_policy.compute_default_service_account_iam_policy.policy_data
}

data "google_iam_policy" "compute_default_service_account_iam_policy" {
  binding {
    role = "roles/viewer"
    members = [
      "serviceAccount:${var.project_id}@appspot.gserviceaccount.com",
      "serviceAccount:firebase-adminsdk-d21rv@${var.project_id}.iam.gserviceaccount.com",
      "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com",
    ]
  }
}

data "google_project" "project" {
  project_id = var.project_id
}

resource "google_project_iam_member" "no_admin_twitch_login" {
  project = var.project_id
  role    = "roles/viewer"
  member  = "serviceAccount:twitch-login@${var.project_id}.iam.gserviceaccount.com"
}
