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
  region  = var.location
}

resource "google_project_service" "containeranalysis" {
  service            = "containeranalysis.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "containerscanning" {
  service            = "containerscanning.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudasset" {
  service            = "cloudasset.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_network" "default" {
  name                    = "default"
  project                 = var.project_id
  delete_default_routes = true
}

resource "google_compute_subnetwork" "default_subnet_flow_logs" {
  for_each = toset(var.default_vpc_regions)

  name                     = "default"
  network                  = "default"
  project                  = var.project_id
  ip_cidr_range            = "10.128.0.0/20"
  region                   = each.value
  private_ip_google_access = true
  flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_storage_bucket" "static_assets_for_game_fight" {
  name                        = "static-assets-for-game-fight"
  project                     = var.project_id
  location                    = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "aviato_game_fight_rvxirf_appspot_com" {
  name                        = "aviato-game-fight-rvxirf.appspot.com"
  project                     = var.project_id
  location                    = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "aviato_game_fight_rvxirf_bucket" {
  name                        = "aviato-game-fight-rvxirf_bucket"
  project                     = var.project_id
  location                    = "US"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "staging_aviato_game_fight_rvxirf_appspot_com" {
  name                        = "staging.aviato-game-fight-rvxirf.appspot.com"
  project                     = var.project_id
  location                    = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}

resource "google_compute_project_metadata" "metadata" {
  project = var.project_id
  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_compute_firewall" "default-allow-ssh" {
  name    = "default-allow-ssh"
  project = var.project_id
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}

resource "google_compute_firewall" "default-allow-rdp" {
  name    = "default-allow-rdp"
  project = var.project_id
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}
