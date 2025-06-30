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
  region  = var.gcp_region
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

resource "google_compute_firewall" "ssh" {
  name    = "allow-ssh-from-trusted-sources"
  project = var.project_id
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = var.allowed_ssh_cidrs
}

resource "google_compute_firewall" "rdp" {
  name    = "allow-rdp-from-trusted-sources"
  project = var.project_id
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
  source_ranges = var.allowed_rdp_cidrs
}

resource "google_storage_bucket" "default_ubla" {
  for_each = toset(var.bucket_names)
  name     = each.value
  project  = var.project_id
  location = "US" 
  uniform_bucket_level_access = true
}

resource "google_compute_network" "default" {
  name = "default"
  project = var.project_id
  delete_default_routes_on_create = true
  dns_config {
    enable_logging = true
  }
}

resource "google_compute_subnetwork" "default_subnet" {
  for_each = toset(var.default_subnet_regions)
  name                     = "default"
  ip_cidr_range            = "10.128.0.0/20"
  region                   = each.value
  network                  = "default"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_project_metadata" "enable_oslogin" {
  project = var.project_id

  metadata = {
    enable-oslogin = "TRUE"
  }
}
