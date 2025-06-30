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
  region  = var.region
}

resource "google_project_service" "artifact_container_analysis" {
  project = var.project_id
  service = "containeranalysis.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudasset" {
  project = var.project_id
  service = "cloudasset.googleapis.com"
  disable_on_destroy = false
}

resource "google_storage_bucket_iam_binding" "uniform_bucket_level_access_aviato_game_fight_rvxirf_appspot_com" {
  bucket = "aviato-game-fight-rvxirf.appspot.com"
  role   = "roles/storage.objectViewer"
  members = [
    "allUsers",
  ]
}

resource "google_storage_bucket_iam_binding" "uniform_bucket_level_access_aviato_game_fight_rvxirf_bucket" {
  bucket = "aviato-game-fight-rvxirf_bucket"
  role   = "roles/storage.objectViewer"
  members = [
    "allUsers",
  ]
}

resource "google_storage_bucket_iam_binding" "uniform_bucket_level_access_staging_aviato_game_fight_rvxirf_appspot_com" {
  bucket = "staging.aviato-game-fight-rvxirf.appspot.com"
  role   = "roles/storage.objectViewer"
  members = [
    "allUsers",
  ]
}

resource "google_storage_bucket_iam_binding" "ensure_uniform_bucket_level_access_aviato_game_fight_rvxirf_appspot_com" {
  bucket = "aviato-game-fight-rvxirf.appspot.com"
  role = "roles/storage.objectViewer"
  members = [
    "allUsers",
  ]
}

resource "google_storage_bucket_iam_binding" "ensure_uniform_bucket_level_access_aviato_game_fight_rvxirf_bucket" {
  bucket = "aviato-game-fight-rvxirf_bucket"
  role = "roles/storage.objectViewer"
  members = [
    "allUsers",
  ]
}

resource "google_storage_bucket_iam_binding" "ensure_uniform_bucket_level_access_staging_aviato_game_fight_rvxirf_appspot_com" {
  bucket = "staging.aviato-game-fight-rvxirf.appspot.com"
  role = "roles/storage.objectViewer"
  members = [
    "allUsers",
  ]
}

resource "google_compute_firewall" "restrict_rdp_access" {
  name    = "restrict-rdp-access"
  project = var.project_id
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = var.default_allowed_rdp_source_ranges
  target_tags   = ["rdp"]
}

resource "google_compute_firewall" "restrict_ssh_access" {
  name    = "restrict-ssh-access"
  project = var.project_id
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.default_allowed_ssh_source_ranges
  target_tags   = ["ssh"]
}

resource "google_compute_network" "default" {
  name                    = "default"
  project                 = var.project_id
  delete_default_routes = true
}

resource "google_compute_subnetwork" "default_asia_east1" {
  name                     = "default"
  ip_cidr_range            = "10.128.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "asia-east1"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_asia_east2" {
  name                     = "default"
  ip_cidr_range            = "10.130.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "asia-east2"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_asia_northeast1" {
  name                     = "default"
  ip_cidr_range            = "10.132.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "asia-northeast1"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_asia_northeast2" {
  name                     = "default"
  ip_cidr_range            = "10.134.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "asia-northeast2"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_asia_northeast3" {
  name                     = "default"
  ip_cidr_range            = "10.136.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "asia-northeast3"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_asia_south1" {
  name                     = "default"
  ip_cidr_range            = "10.138.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "asia-south1"
   enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_asia_south2" {
  name                     = "default"
  ip_cidr_range            = "10.140.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "asia-south2"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_asia_southeast1" {
  name                     = "default"
  ip_cidr_range            = "10.142.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "asia-southeast1"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_asia_southeast2" {
  name                     = "default"
  ip_cidr_range            = "10.144.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "asia-southeast2"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_australia_southeast1" {
  name                     = "default"
  ip_cidr_range            = "10.146.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "australia-southeast1"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_australia_southeast2" {
  name                     = "default"
  ip_cidr_range            = "10.148.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "australia-southeast2"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_europe_central2" {
  name                     = "default"
  ip_cidr_range            = "10.150.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "europe-central2"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_europe_north1" {
  name                     = "default"
  ip_cidr_range            = "10.152.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "europe-north1"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_europe_north2" {
  name                     = "default"
  ip_cidr_range            = "10.154.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "europe-north2"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_europe_southwest1" {
  name                     = "default"
  ip_cidr_range            = "10.156.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "europe-southwest1"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_europe_west1" {
  name                     = "default"
  ip_cidr_range            = "10.158.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "europe-west1"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_europe_west10" {
  name                     = "default"
  ip_cidr_range            = "10.160.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "europe-west10"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_europe_west12" {
  name                     = "default"
  ip_cidr_range            = "10.162.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "europe-west12"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_europe_west2" {
  name                     = "default"
  ip_cidr_range            = "10.164.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "europe-west2"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_europe_west3" {
  name                     = "default"
  ip_cidr_range            = "10.166.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "europe-west3"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_europe_west4" {
  name                     = "default"
  ip_cidr_range            = "10.168.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "europe-west4"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_europe_west6" {
  name                     = "default"
  ip_cidr_range            = "10.170.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "europe-west6"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_europe_west8" {
  name                     = "default"
  ip_cidr_range            = "10.172.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "europe-west8"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_europe_west9" {
  name                     = "default"
  ip_cidr_range            = "10.174.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "europe-west9"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_me_central1" {
  name                     = "default"
  ip_cidr_range            = "10.176.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "me-central1"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_me_central2" {
  name                     = "default"
  ip_cidr_range            = "10.178.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "me-central2"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_me_west1" {
  name                     = "default"
  ip_cidr_range            = "10.180.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "me-west1"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_northamerica_northeast1" {
  name                     = "default"
  ip_cidr_range            = "10.182.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "northamerica-northeast1"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_northamerica_northeast2" {
  name                     = "default"
  ip_cidr_range            = "10.184.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "northamerica-northeast2"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_northamerica_south1" {
  name                     = "default"
  ip_cidr_range            = "10.186.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "northamerica-south1"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_southamerica_east1" {
  name                     = "default"
  ip_cidr_range            = "10.188.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "southamerica-east1"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_southamerica_west1" {
  name                     = "default"
  ip_cidr_range            = "10.190.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "southamerica-west1"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_us_central1" {
  name                     = "default"
  ip_cidr_range            = "10.192.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "us-central1"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_us_east1" {
  name                     = "default"
  ip_cidr_range            = "10.194.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "us-east1"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_us_east4" {
  name                     = "default"
  ip_cidr_range            = "10.196.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "us-east4"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_us_east5" {
  name                     = "default"
  ip_cidr_range            = "10.198.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "us-east5"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_us_south1" {
  name                     = "default"
  ip_cidr_range            = "10.200.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "us-south1"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_us_west1" {
  name                     = "default"
  ip_cidr_range            = "10.202.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "us-west1"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_us_west2" {
  name                     = "default"
  ip_cidr_range            = "10.204.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "us-west2"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_us_west3" {
  name                     = "default"
  ip_cidr_range            = "10.206.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "us-west3"
  enable_flow_logs         = true
}

resource "google_compute_subnetwork" "default_us_west4" {
  name                     = "default"
  ip_cidr_range            = "10.208.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "us-west4"
  enable_flow_logs         = true
}

resource "google_compute_project_metadata" "project_metadata" {
  project = var.project_id

  metadata = {
    enable-oslogin = "TRUE"
  }
}
