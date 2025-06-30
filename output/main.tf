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
  region  = "us-central1"
}

resource "google_project_service" "containeranalysis" {
  service            = "containeranalysis.googleapis.com"
  disable_on_destroy = false
}

resource "google_storage_bucket" "default_bucket_uniform_access" {
  name          = "aviato-game-fight-rvxirf.appspot.com"
  location      = "AUSTRALIA-SOUTHEAST1"
  force_destroy = false
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "bucket_uniform_access" {
  name          = "aviato-game-fight-rvxirf_bucket"
  location      = "US"
  force_destroy = false
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "staging_bucket_uniform_access" {
  name          = "staging.aviato-game-fight-rvxirf.appspot.com"
  location      = "AUSTRALIA-SOUTHEAST1"
  force_destroy = false
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

  source_ranges = ["130.211.0.0/22", "35.235.240.0/20"]

}

resource "google_compute_firewall" "rdp" {
  name    = "default-allow-rdp"
  network = "default"
  project = "aviato-game-fight-rvxirf"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["130.211.0.0/22", "35.235.240.0/20"]
}

resource "google_compute_network" "default_network" {
  name                    = "default"
  project                 = "aviato-game-fight-rvxirf"
  auto_create_subnetworks = "false"

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_compute_network_dns_policy" "default_network_dns_logging" {
  project = "aviato-game-fight-rvxirf"
  network = "default"
  enable_logging = true
}

resource "google_project_metadata" "project" {
  project = "aviato-game-fight-rvxirf"

  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_compute_subnet" "default_asia_northeast2" {
  name          = "default"
  ip_cidr_range = "10.132.0.0/20"
  region        = "asia-northeast2"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_europe_west12" {
  name          = "default"
  ip_cidr_range = "10.168.0.0/20"
  region        = "europe-west12"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_asia_south2" {
  name          = "default"
  ip_cidr_range = "10.166.0.0/20"
  region        = "asia-south2"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_europe_west4" {
  name          = "default"
  ip_cidr_range = "10.156.0.0/20"
  region        = "europe-west4"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_us_south1" {
  name          = "default"
  ip_cidr_range = "10.154.0.0/20"
  region        = "us-south1"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_australia_southeast2" {
  name          = "default"
  ip_cidr_range = "10.130.0.0/20"
  region        = "australia-southeast2"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_me_central1" {
  name          = "default"
  ip_cidr_range = "10.134.0.0/20"
  region        = "me-central1"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_us_east1" {
  name          = "default"
  ip_cidr_range = "10.128.0.0/20"
  region        = "us-east1"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_us_west1" {
  name          = "default"
  ip_cidr_range = "10.152.0.0/20"
  region        = "us-west1"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_europe_west2" {
  name          = "default"
  ip_cidr_range = "10.142.0.0/20"
  region        = "europe-west2"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_us_west4" {
  name          = "default"
  ip_cidr_range = "10.164.0.0/20"
  region        = "us-west4"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_europe_west8" {
  name          = "default"
  ip_cidr_range = "10.148.0.0/20"
  region        = "europe-west8"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_southamerica_west1" {
  name          = "default"
  ip_cidr_range = "10.170.0.0/20"
  region        = "southamerica-west1"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_europe_west9" {
  name          = "default"
  ip_cidr_range = "10.172.0.0/20"
  region        = "europe-west9"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_northamerica_northeast1" {
  name          = "default"
  ip_cidr_range = "10.150.0.0/20"
  region        = "northamerica-northeast1"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_asia_east1" {
  name          = "default"
  ip_cidr_range = "10.140.0.0/20"
  region        = "asia-east1"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_asia_northeast3" {
  name          = "default"
  ip_cidr_range = "10.160.0.0/20"
  region        = "asia-northeast3"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_europe_west10" {
  name          = "default"
  ip_cidr_range = "10.174.0.0/20"
  region        = "europe-west10"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_europe_north2" {
  name          = "default"
  ip_cidr_range = "10.176.0.0/20"
  region        = "europe-north2"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_asia_northeast1" {
  name          = "default"
  ip_cidr_range = "10.146.0.0/20"
  region        = "asia-northeast1"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_us_east5" {
  name          = "default"
  ip_cidr_range = "10.178.0.0/20"
  region        = "us-east5"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_northamerica_northeast2" {
  name          = "default"
  ip_cidr_range = "10.180.0.0/20"
  region        = "northamerica-northeast2"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_asia_southeast2" {
  name          = "default"
  ip_cidr_range = "10.182.0.0/20"
  region        = "asia-southeast2"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_asia_east2" {
  name          = "default"
  ip_cidr_range = "10.184.0.0/20"
  region        = "asia-east2"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_asia_southeast1" {
  name          = "default"
  ip_cidr_range = "10.158.0.0/20"
  region        = "asia-southeast1"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_asia_south1" {
  name          = "default"
  ip_cidr_range = "10.162.0.0/20"
  region        = "asia-south1"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_europe_west3" {
  name          = "default"
  ip_cidr_range = "10.144.0.0/20"
  region        = "europe-west3"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_australia_southeast1" {
  name          = "default"
  ip_cidr_range = "10.136.0.0/20"
  region        = "australia-southeast1"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_us_east4" {
  name          = "default"
  ip_cidr_range = "10.144.0.0/20"
  region        = "us-east4"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_europe_north1" {
  name          = "default"
  ip_cidr_range = "10.164.0.0/20"
  region        = "europe-north1"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_europe_southwest1" {
  name          = "default"
  ip_cidr_range = "10.186.0.0/20"
  region        = "europe-southwest1"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_europe_west1" {
  name          = "default"
  ip_cidr_range = "10.138.0.0/20"
  region        = "europe-west1"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_us_west3" {
  name          = "default"
  ip_cidr_range = "10.168.0.0/20"
  region        = "us-west3"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_northamerica_south1" {
  name          = "default"
  ip_cidr_range = "10.172.0.0/20"
  region        = "northamerica-south1"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_us_central1" {
  name          = "default"
  ip_cidr_range = "10.142.0.0/20"
  region        = "us-central1"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_europe_west6" {
  name          = "default"
  ip_cidr_range = "10.140.0.0/20"
  region        = "europe-west6"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_me_west1" {
  name          = "default"
  ip_cidr_range = "10.188.0.0/20"
  region        = "me-west1"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_europe_central2" {
  name          = "default"
  ip_cidr_range = "10.190.0.0/20"
  region        = "europe-central2"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_southamerica_east1" {
  name          = "default"
  ip_cidr_range = "10.146.0.0/20"
  region        = "southamerica-east1"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnet" "default_africa_south1" {
  name          = "default"
  ip_cidr_range = "10.156.0.0/20"
  region        = "africa-south1"
  network       = "default"
  project = "aviato-game-fight-rvxirf"
    log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_project_service" "cloudasset" {
  project = "aviato-game-fight-rvxirf"
  service = "cloudasset.googleapis.com"
  disable_on_destroy = false
}
