terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.68.0"
    }
  }
}

provider "google" {
  project = "aviato-game-fight-rvxirf"
}

resource "google_project_service" "containeranalysis" {
  service            = "containeranalysis.googleapis.com"
  disable_on_destroy = false
}

resource "google_storage_bucket" "default_bucket_uniform_access_1" {
  name          = "aviato-game-fight-rvxirf.appspot.com"
  location      = "AUSTRALIA-SOUTHEAST1"
  force_destroy = true
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "default_bucket_uniform_access_2" {
  name          = "aviato-game-fight-rvxirf_bucket"
  location      = "US"
  force_destroy = true
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "default_bucket_uniform_access_3" {
  name          = "staging.aviato-game-fight-rvxirf.appspot.com"
  location      = "AUSTRALIA-SOUTHEAST1"
  force_destroy = true
  uniform_bucket_level_access = true
}

resource "google_compute_firewall" "ssh" {
  name    = "default-allow-ssh"
  network = "default"
  project = "aviato-game-fight-rvxirf"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["130.211.0.0/22", "35.235.0.0/24"]
}

resource "google_compute_firewall" "rdp" {
  name    = "default-allow-rdp"
  network = "default"
  project = "aviato-game-fight-rvxirf"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["130.211.0.0/22", "35.235.0.0/24"]
}

resource "google_compute_network" "default" {
  name                    = "default"
  project                 = "aviato-game-fight-rvxirf"
  delete_default_routes = true
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false
}

resource "google_compute_network" "default_dns_logging" {
  name                    = "default"
  project                 = "aviato-game-fight-rvxirf"
  delete_default_routes = true
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false
  enable_logging = true
}

resource "google_project_metadata" "project" {
  project = "aviato-game-fight-rvxirf"

  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_compute_subnetwork" "default_asia_northeast2" {
  name          = "default"
  ip_cidr_range = "10.146.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "asia-northeast2"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west12" {
  name          = "default"
  ip_cidr_range = "10.178.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "europe-west12"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_south2" {
  name          = "default"
  ip_cidr_range = "10.158.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "asia-south2"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west4" {
  name          = "default"
  ip_cidr_range = "10.156.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "europe-west4"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_south1" {
  name          = "default"
  ip_cidr_range = "10.164.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "us-south1"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_australia_southeast2" {
  name          = "default"
  ip_cidr_range = "10.142.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "australia-southeast2"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_me_central1" {
  name          = "default"
  ip_cidr_range = "10.186.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "me-central1"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_east1" {
  name          = "default"
  ip_cidr_range = "10.128.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "us-east1"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_west1" {
  name          = "default"
  ip_cidr_range = "10.132.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "us-west1"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west2" {
  name          = "default"
  ip_cidr_range = "10.138.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "europe-west2"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_west4" {
  name          = "default"
  ip_cidr_range = "10.170.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "us-west4"
   log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west8" {
  name          = "default"
  ip_cidr_range = "10.220.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "europe-west8"
   log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_southamerica_west1" {
  name          = "default"
  ip_cidr_range = "10.162.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "southamerica-west1"
   log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west9" {
  name          = "default"
  ip_cidr_range = "10.226.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "europe-west9"
   log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_northamerica_northeast1" {
  name          = "default"
  ip_cidr_range = "10.130.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "northamerica-northeast1"
   log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_east1" {
  name          = "default"
  ip_cidr_range = "10.150.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "asia-east1"
   log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_northeast3" {
  name          = "default"
  ip_cidr_range = "10.166.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "asia-northeast3"
   log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west10" {
  name          = "default"
  ip_cidr_range = "10.232.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "europe-west10"
   log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_north2" {
  name          = "default"
  ip_cidr_range = "10.184.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "europe-north2"
   log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_northeast1" {
  name          = "default"
  ip_cidr_range = "10.140.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "asia-northeast1"
   log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_east5" {
  name          = "default"
  ip_cidr_range = "10.172.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "us-east5"
   log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_northamerica_northeast2" {
  name          = "default"
  ip_cidr_range = "10.174.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "northamerica-northeast2"
   log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_southeast2" {
  name          = "default"
  ip_cidr_range = "10.182.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "asia-southeast2"
   log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_east2" {
  name          = "default"
  ip_cidr_range = "10.224.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "asia-east2"
   log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_southeast1" {
  name          = "default"
  ip_cidr_range = "10.152.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "asia-southeast1"
   log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_south1" {
  name          = "default"
  ip_cidr_range = "10.154.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "asia-south1"
   log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west3" {
  name          = "default"
  ip_cidr_range = "10.148.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "europe-west3"
   log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_australia_southeast1" {
  name          = "default"
  ip_cidr_range = "10.134.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "australia-southeast1"
   log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_east4" {
  name          = "default"
  ip_cidr_range = "10.156.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "us-east4"
   log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_north1" {
  name          = "default"
  ip_cidr_range = "10.160.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "europe-north1"
   log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_southwest1" {
  name          = "default"
  ip_cidr_range = "10.228.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "europe-southwest1"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west1" {
  name          = "default"
  ip_cidr_range = "10.136.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "europe-west1"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_west3" {
  name          = "default"
  ip_cidr_range = "10.152.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "us-west3"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_northamerica_south1" {
  name          = "default"
  ip_cidr_range = "10.230.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "northamerica-south1"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_central1" {
  name          = "default"
  ip_cidr_range = "10.142.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "us-central1"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west6" {
  name          = "default"
  ip_cidr_range = "10.176.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "europe-west6"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_me_west1" {
  name          = "default"
  ip_cidr_range = "10.200.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "me-west1"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_central2" {
  name          = "default"
  ip_cidr_range = "10.234.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "europe-central2"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_southamerica_east1" {
  name          = "default"
  ip_cidr_range = "10.144.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "southamerica-east1"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_africa_south1" {
  name          = "default"
  ip_cidr_range = "10.222.0.0/20"
  network       = "default"
  project     = "aviato-game-fight-rvxirf"
  region        = "africa-south1"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_cloud_asset_project_feed" "feed" {
  feed_id = "asset-feed"
  project = "aviato-game-fight-rvxirf"
  content_type = "RESOURCE"
  asset_types = [
    "storage.googleapis.com/Bucket",
    "compute.googleapis.com/Instance",
    "iam.googleapis.com/ServiceAccount"
  ]

  pubsub_topic = "projects/aviato-game-fight-rvxirf/topics/asset-topic"
}

resource "google_pubsub_topic" "topic" {
  name    = "asset-topic"
  project = "aviato-game-fight-rvxirf"
}
