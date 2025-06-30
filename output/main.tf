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
  region  = var.location
}

resource "google_project_service" "containeranalysis" {
  project = var.project_id
  service = "containeranalysis.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudasset" {
  project = var.project_id
  service = "cloudasset.googleapis.com"
  disable_on_destroy = false
}

resource "google_storage_bucket_iam_binding" "uniform_bucket_level_access_aviato" {
  bucket = "aviato-game-fight-rvxirf.appspot.com"
  role   = "roles/storage.objectViewer"
  members = [
    "allUsers",
  ]
}

resource "google_storage_bucket" "bucket_aviato" {
  name                        = "aviato-game-fight-rvxirf.appspot.com"
  location                    = "AUSTRALIA-SOUTHEAST1"
  force_destroy               = false
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_iam_binding" "uniform_bucket_level_access_fight" {
  bucket = "aviato-game-fight-rvxirf_bucket"
  role   = "roles/storage.objectViewer"
  members = [
    "allUsers",
  ]
}

resource "google_storage_bucket" "bucket_fight" {
  name                        = "aviato-game-fight-rvxirf_bucket"
  location                    = "US"
  force_destroy               = false
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_iam_binding" "uniform_bucket_level_access_staging" {
  bucket = "staging.aviato-game-fight-rvxirf.appspot.com"
  role   = "roles/storage.objectViewer"
  members = [
    "allUsers",
  ]
}

resource "google_storage_bucket" "bucket_staging" {
  name                        = "staging.aviato-game-fight-rvxirf.appspot.com"
  location                    = "AUSTRALIA-SOUTHEAST1"
  force_destroy               = false
  uniform_bucket_level_access = true
}

resource "google_compute_firewall" "ssh" {
  name    = "allow-ssh-from-internal"
  project = var.project_id
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.default_ssh_source_range
}

resource "google_compute_firewall" "rdp" {
  name    = "allow-rdp-from-internal"
  project = var.project_id
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = var.default_rdp_source_range
}

resource "google_compute_network" "default" {
  name                    = "default"
  project                 = var.project_id
  delete_default_routes = true
  depends_on = [
      google_compute_firewall.ssh,
      google_compute_firewall.rdp
  ]
}

resource "google_compute_network_dns_policy" "default" {
    name = "default"
    project = var.project_id
    network = "default"
    enable_logging = true
}

resource "google_project_metadata" "oslogin" {
  project = var.project_id

  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_logging_project_sink" "default_sink" {
  name = "default-sink"
  project = var.project_id
  destination = "storage.googleapis.com/${var.log_sink_destination}"
  filter = var.log_sink_filter
}

resource "google_compute_subnetwork" "default" {
  for_each = toset(var.default_regions)
  name                     = "default"
  ip_cidr_range            = "10.128.0.0/20"
  region                   = each.value
  network                  = "default"
  project                  = var.project_id
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_iam_binding" "twitch_login" {
  project = var.project_id
  role    = "roles/viewer"
  members = [
    "serviceAccount:twitch-login@aviato-game-fight-rvxirf.iam.gserviceaccount.com",
  ]
}

resource "google_iam_binding" "compute_account" {
  project = var.project_id
  role    = "roles/viewer"
  members = [
    "serviceAccount:30647320905-compute@developer.gserviceaccount.com",
  ]
}

resource "google_iam_binding" "firebase_account" {
  project = var.project_id
  role    = "roles/storage.objectViewer"
  members = [
    "serviceAccount:firebase-adminsdk-d21rv@aviato-game-fight-rvxirf.iam.gserviceaccount.com",
  ]
}
