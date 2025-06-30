terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.24.0"
    }
  }
}

provider "google" {
  project = "aviato-game-fight-rvxirf"
}

resource "google_project_metadata" "oslogin" {
  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_artifact_registry_repository" "container_analysis" {
  provider = google
  location = "global"
  repository_id = "container-analysis"
  format = "DOCKER"
}

resource "google_storage_bucket" "default_uniform_bucket_level_access_1" {
  name                        = "aviato-game-fight-rvxirf.appspot.com"
  location                    = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "default_uniform_bucket_level_access_2" {
  name                        = "aviato-game-fight-rvxirf_bucket"
  location                    = "US"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "default_uniform_bucket_level_access_3" {
  name                        = "staging.aviato-game-fight-rvxirf.appspot.com"
  location                    = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}

resource "google_compute_network" "default" {
  name                    = "default"
  delete_default_routes = true
}

resource "google_compute_subnetwork" "default_asia_northeast2" {
  name          = "default"
  network       = "default"
  region        = "asia-northeast2"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west12" {
  name          = "default"
  network       = "default"
  region        = "europe-west12"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_south2" {
  name          = "default"
  network       = "default"
  region        = "asia-south2"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west4" {
  name          = "default"
  network       = "default"
  region        = "europe-west4"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_south1" {
  name          = "default"
  network       = "default"
  region        = "us-south1"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_australia_southeast2" {
  name          = "default"
  network       = "default"
  region        = "australia-southeast2"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_me_central1" {
  name          = "default"
  network       = "default"
  region        = "me-central1"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_east1" {
  name          = "default"
  network       = "default"
  region        = "us-east1"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_west1" {
  name          = "default"
  network       = "default"
  region        = "us-west1"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west2" {
  name          = "default"
  network       = "default"
  region        = "europe-west2"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_west4" {
  name          = "default"
  network       = "default"
  region        = "us-west4"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_west2" {
  name          = "default"
  network       = "default"
  region        = "us-west2"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west8" {
  name          = "default"
  network       = "default"
  region        = "europe-west8"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_southamerica_west1" {
  name          = "default"
  network       = "default"
  region        = "southamerica-west1"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west9" {
  name          = "default"
  network       = "default"
  region        = "europe-west9"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_northamerica_northeast1" {
  name          = "default"
  network       = "default"
  region        = "northamerica-northeast1"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_east1" {
  name          = "default"
  network       = "default"
  region        = "asia-east1"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_northeast1" {
  name          = "default"
  network       = "default"
  region        = "asia-northeast1"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_east5" {
  name          = "default"
  network       = "default"
  region        = "us-east5"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_east2" {
  name          = "default"
  network       = "default"
  region        = "asia-east2"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_northamerica_northeast2" {
  name          = "default"
  network       = "default"
  region        = "northamerica-northeast2"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_northeast3" {
  name          = "default"
  network       = "default"
  region        = "asia-northeast3"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west10" {
  name          = "default"
  network       = "default"
  region        = "europe-west10"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_north2" {
  name          = "default"
  network       = "default"
  region        = "europe-north2"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_southeast2" {
  name          = "default"
  network       = "default"
  region        = "asia-southeast2"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_southeast1" {
  name          = "default"
  network       = "default"
  region        = "asia-southeast1"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_south1" {
  name          = "default"
  network       = "default"
  region        = "asia-south1"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west3" {
  name          = "default"
  network       = "default"
  region        = "europe-west3"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_australia_southeast1" {
  name          = "default"
  network       = "default"
  region        = "australia-southeast1"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_east4" {
  name          = "default"
  network       = "default"
  region        = "us-east4"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_north1" {
  name          = "default"
  network       = "default"
  region        = "europe-north1"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_southwest1" {
  name          = "default"
  network       = "default"
  region        = "europe-southwest1"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west1" {
  name          = "default"
  network       = "default"
  region        = "europe-west1"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_me_west1" {
  name          = "default"
  network       = "default"
  region        = "me-west1"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_central2" {
  name          = "default"
  network       = "default"
  region        = "europe-central2"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_southamerica_east1" {
  name          = "default"
  network       = "default"
  region        = "southamerica-east1"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_africa_south1" {
  name          = "default"
  network       = "default"
  region        = "africa-south1"
  ip_cidr_range = "10.128.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_service_account" "unused_service_accounts_1" {
  account_id   = "aviato-game-fight-rvxirf@appspot"
  disabled     = true
}

resource "google_service_account" "unused_service_accounts_2" {
  account_id   = "firebase-adminsdk-d21rv@aviato-game-fight-rvxirf"
  disabled     = true
}

resource "google_project_iam_binding" "twitch_login_iam" {
  project = "aviato-game-fight-rvxirf"
  role = "roles/viewer"
  members = [
    "serviceAccount:twitch-login@aviato-game-fight-rvxirf.iam.gserviceaccount.com",
  ]
}

resource "google_project_iam_binding" "default_compute_iam" {
  project = "aviato-game-fight-rvxirf"
  role = "roles/viewer"
  members = [
    "serviceAccount:30647320905-compute@developer.gserviceaccount.com",
  ]
}

resource "google_logging_project_sink" "all_logs_sink" {
  name = "all-logs-sink"
  destination = "google_storage_bucket.all_logs_bucket.name"
  filter = "NOT logName:cloudaudit.googleapis.com/activity OR NOT logName:securitycenter.googleapis.com/sources/1234567890123/findings"
}

resource "google_storage_bucket" "all_logs_bucket" {
  name                        = "all-logs-bucket-aviato-game-fight-rvxirf"
  location                    = "US"
  uniform_bucket_level_access = true
}
