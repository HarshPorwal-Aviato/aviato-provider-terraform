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

resource "google_project_service_identity" "gcp_sa_asset" {
  provider = google
  project  = "aviato-game-fight-rvxirf"
  service  = "cloudasset.googleapis.com"
}

resource "google_project_service" "artifactregistry" {
  project            = "aviato-game-fight-rvxirf"
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "containeranalysis" {
  project            = "aviato-game-fight-rvxirf"
  service            = "containeranalysis.googleapis.com"
  disable_on_destroy = false
  depends_on = [google_project_service_identity.gcp_sa_asset]
}

resource "google_compute_network" "default" {
  name                    = "default"
  project                 = "aviato-game-fight-rvxirf"
  delete_default_routes = true
}

resource "google_compute_subnetwork" "default_asia_east2" {
  name                     = "default"
  ip_cidr_range            = "10.132.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "asia-east2"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_southeast2" {
  name                     = "default"
  ip_cidr_range            = "10.164.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "asia-southeast2"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_east5" {
  name                     = "default"
  ip_cidr_range            = "10.158.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "us-east5"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west8" {
  name                     = "default"
  ip_cidr_range            = "10.128.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "europe-west8"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west3" {
  name                     = "default"
  ip_cidr_range            = "10.138.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "europe-west3"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west9" {
  name                     = "default"
  ip_cidr_range            = "10.156.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "europe-west9"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_me_central1" {
  name                     = "default"
  ip_cidr_range            = "10.162.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "me-central1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_south2" {
  name                     = "default"
  ip_cidr_range            = "10.170.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "asia-south2"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_northeast3" {
  name                     = "default"
  ip_cidr_range            = "10.166.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "asia-northeast3"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_australia_southeast1" {
  name                     = "default"
  ip_cidr_range            = "10.134.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "australia-southeast1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_south1" {
  name                     = "default"
  ip_cidr_range            = "10.152.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "asia-south1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_northamerica_south1" {
  name                     = "default"
  ip_cidr_range            = "10.168.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "northamerica-south1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_me_west1" {
  name                     = "default"
  ip_cidr_range            = "10.154.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "me-west1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_northeast2" {
  name                     = "default"
  ip_cidr_range            = "10.146.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "asia-northeast2"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west2" {
  name                     = "default"
  ip_cidr_range            = "10.130.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "europe-west2"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_northeast1" {
  name                     = "default"
  ip_cidr_range            = "10.140.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "asia-northeast1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_me_central2" {
  name                     = "default"
  ip_cidr_range            = "10.172.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "me-central2"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_northamerica_northeast1" {
  name                     = "default"
  ip_cidr_range            = "10.174.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "northamerica-northeast1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_southamerica_west1" {
  name                     = "default"
  ip_cidr_range            = "10.144.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "southamerica-west1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west6" {
  name                     = "default"
  ip_cidr_range            = "10.142.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "europe-west6"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_australia_southeast2" {
  name                     = "default"
  ip_cidr_range            = "10.176.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "australia-southeast2"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west12" {
  name                     = "default"
  ip_cidr_range            = "10.178.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "europe-west12"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_south1" {
  name                     = "default"
  ip_cidr_range            = "10.150.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "us-south1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_central2" {
  name                     = "default"
  ip_cidr_range            = "10.159.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "europe-central2"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west4" {
  name                     = "default"
  ip_cidr_range            = "10.148.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "europe-west4"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west10" {
  name                     = "default"
  ip_cidr_range            = "10.180.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "europe-west10"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_southeast1" {
  name                     = "default"
  ip_cidr_range            = "10.156.8.0/21"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "asia-southeast1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_east1" {
  name                     = "default"
  ip_cidr_range            = "10.142.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "asia-east1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_west1" {
  name                     = "default"
  ip_cidr_range            = "10.138.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "us-west1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west1" {
  name                     = "default"
  ip_cidr_range            = "10.132.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "europe-west1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_northamerica_northeast1_1" {
  name                     = "default"
  ip_cidr_range            = "10.174.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "northamerica-northeast1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_north1" {
  name                     = "default"
  ip_cidr_range            = "10.140.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "europe-north1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_africa_south1" {
  name                     = "default"
  ip_cidr_range            = "10.182.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "africa-south1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_southamerica_east1" {
  name                     = "default"
  ip_cidr_range            = "10.156.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "southamerica-east1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_west3" {
  name                     = "default"
  ip_cidr_range            = "10.150.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "us-west3"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_east4" {
  name                     = "default"
  ip_cidr_range            = "10.146.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "us-east4"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_central1" {
  name                     = "default"
  ip_cidr_range            = "10.128.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "us-central1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_west2" {
  name                     = "default"
  ip_cidr_range            = "10.134.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "us-west2"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_southwest1" {
  name                     = "default"
  ip_cidr_range            = "10.184.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "europe-southwest1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_east1" {
  name                     = "default"
  ip_cidr_range            = "10.142.0.0/20"
  network                  = "default"
  project                  = "aviato-game-fight-rvxirf"
  region                   = "us-east1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_project_metadata" "metadata" {
  project = "aviato-game-fight-rvxirf"
  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_storage_bucket" "default_bucket" {
  name                        = "aviato-game-fight-rvxirf.appspot.com"
  project                     = "aviato-game-fight-rvxirf"
  location                    = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "default_bucket_2" {
  name                        = "aviato-game-fight-rvxirf_bucket"
  project                     = "aviato-game-fight-rvxirf"
  location                    = "US"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "default_bucket_3" {
  name                        = "staging.aviato-game-fight-rvxirf.appspot.com"
  project                     = "aviato-game-fight-rvxirf"
  location                    = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}

resource "google_compute_firewall" "default_allow_ssh" {
  name    = "default-allow-ssh"
  project = "aviato-game-fight-rvxirf"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
}

resource "google_compute_firewall" "default_allow_rdp" {
  name    = "default-allow-rdp"
  project = "aviato-game-fight-rvxirf"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
}

resource "google_logging_project_sink" "sink" {
  name = "aviato-game-fight-rvxirf"
  project = "aviato-game-fight-rvxirf"
  destination = "storage.googleapis.com/${google_storage_bucket.default_bucket.name}"
  filter = "NOT logName:\"projects/${"aviato-game-fight-rvxirf"}/logs/cloudaudit.googleapis.com%2Fdata_access\""
}

resource "google_project_service" "cloudasset" {
  project = "aviato-game-fight-rvxirf"
  service = "cloudasset.googleapis.com"
  disable_on_destroy = false
}
