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
  project                 = "aviato-game-fight-rvxirf"
  delete_default_routes = true
}

resource "google_compute_subnetwork" "default_subnet_asia_east1" {
  name          = "default"
  ip_cidr_range = "10.0.0.0/20"
  network       = "default"
  region        = "asia-east1"
  project     = "aviato-game-fight-rvxirf"
  flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_asia_northeast1" {
  name          = "default"
  ip_cidr_range = "10.0.16.0/20"
  network       = "default"
  region        = "asia-northeast1"
  project     = "aviato-game-fight-rvxirf"
    flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_asia_northeast2" {
  name          = "default"
  ip_cidr_range = "10.0.32.0/20"
  network       = "default"
  region        = "asia-northeast2"
  project     = "aviato-game-fight-rvxirf"
    flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_asia_northeast3" {
  name          = "default"
  ip_cidr_range = "10.0.48.0/20"
  network       = "default"
  region        = "asia-northeast3"
  project     = "aviato-game-fight-rvxirf"
    flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_asia_south1" {
  name          = "default"
  ip_cidr_range = "10.0.64.0/20"
  network       = "default"
  region        = "asia-south1"
  project     = "aviato-game-fight-rvxirf"
    flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_asia_south2" {
  name          = "default"
  ip_cidr_range = "10.0.80.0/20"
  network       = "default"
  region        = "asia-south2"
  project     = "aviato-game-fight-rvxirf"
    flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_asia_southeast1" {
  name          = "default"
  ip_cidr_range = "10.0.96.0/20"
  network       = "default"
  region        = "asia-southeast1"
  project     = "aviato-game-fight-rvxirf"
    flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_asia_southeast2" {
  name          = "default"
  ip_cidr_range = "10.0.112.0/20"
  network       = "default"
  region        = "asia-southeast2"
  project     = "aviato-game-fight-rvxirf"
    flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_australia_southeast1" {
  name          = "default"
  ip_cidr_range = "10.0.128.0/20"
  network       = "default"
  region        = "australia-southeast1"
  project     = "aviato-game-fight-rvxirf"
    flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_australia_southeast2" {
  name          = "default"
  ip_cidr_range = "10.0.144.0/20"
  network       = "default"
  region        = "australia-southeast2"
  project     = "aviato-game-fight-rvxirf"
    flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_europe_central2" {
  name          = "default"
  ip_cidr_range = "10.0.160.0/20"
  network       = "default"
  region        = "europe-central2"
  project     = "aviato-game-fight-rvxirf"
    flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_europe_north1" {
  name          = "default"
  ip_cidr_range = "10.0.176.0/20"
  network       = "default"
  region        = "europe-north1"
  project     = "aviato-game-fight-rvxirf"
    flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_europe_north2" {
  name          = "default"
  ip_cidr_range = "10.0.192.0/20"
  network       = "default"
  region        = "europe-north2"
  project     = "aviato-game-fight-rvxirf"
    flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_europe_southwest1" {
  name          = "default"
  ip_cidr_range = "10.0.208.0/20"
  network       = "default"
  region        = "europe-southwest1"
  project     = "aviato-game-fight-rvxirf"
    flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_europe_west1" {
  name          = "default"
  ip_cidr_range = "10.0.224.0/20"
  network       = "default"
  region        = "europe-west1"
  project     = "aviato-game-fight-rvxirf"
    flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_europe_west10" {
  name          = "default"
  ip_cidr_range = "10.0.240.0/20"
  network       = "default"
  region        = "europe-west10"
  project     = "aviato-game-fight-rvxirf"
    flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_europe_west12" {
  name          = "default"
  ip_cidr_range = "10.0.0.0/20"
  network       = "default"
  region        = "europe-west12"
  project     = "aviato-game-fight-rvxirf"
  flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_europe_west3" {
  name          = "default"
  ip_cidr_range = "10.0.0.0/20"
  network       = "default"
  region        = "europe-west3"
  project     = "aviato-game-fight-rvxirf"
  flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_europe_west4" {
  name          = "default"
  ip_cidr_range = "10.0.0.0/20"
  network       = "default"
  region        = "europe-west4"
  project     = "aviato-game-fight-rvxirf"
  flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_europe_west6" {
  name          = "default"
  ip_cidr_range = "10.0.0.0/20"
  network       = "default"
  region        = "europe-west6"
  project     = "aviato-game-fight-rvxirf"
  flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_europe_west8" {
  name          = "default"
  ip_cidr_range = "10.0.0.0/20"
  network       = "default"
  region        = "europe-west8"
  project     = "aviato-game-fight-rvxirf"
  flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_me_central1" {
  name          = "default"
  ip_cidr_range = "10.0.0.0/20"
  network       = "default"
  region        = "me-central1"
  project     = "aviato-game-fight-rvxirf"
  flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_me_central2" {
  name          = "default"
  ip_cidr_range = "10.0.0.0/20"
  network       = "default"
  region        = "me-central2"
  project     = "aviato-game-fight-rvxirf"
  flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_me_west1" {
  name          = "default"
  ip_cidr_range = "10.0.0.0/20"
  network       = "default"
  region        = "me-west1"
  project     = "aviato-game-fight-rvxirf"
  flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_northamerica_northeast1" {
  name          = "default"
  ip_cidr_range = "10.0.0.0/20"
  network       = "default"
  region        = "northamerica-northeast1"
  project     = "aviato-game-fight-rvxirf"
  flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_northamerica_northeast2" {
  name          = "default"
  ip_cidr_range = "10.0.0.0/20"
  network       = "default"
  region        = "northamerica-northeast2"
  project     = "aviato-game-fight-rvxirf"
  flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_southamerica_east1" {
  name          = "default"
  ip_cidr_range = "10.0.0.0/20"
  network       = "default"
  region        = "southamerica-east1"
  project     = "aviato-game-fight-rvxirf"
  flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_southamerica_west1" {
  name          = "default"
  ip_cidr_range = "10.0.0.0/20"
  network       = "default"
  region        = "southamerica-west1"
  project     = "aviato-game-fight-rvxirf"
  flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_us_central1" {
  name          = "default"
  ip_cidr_range = "10.0.0.0/20"
  network       = "default"
  region        = "us-central1"
  project     = "aviato-game-fight-rvxirf"
  flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_us_east1" {
  name          = "default"
  ip_cidr_range = "10.0.0.0/20"
  network       = "default"
  region        = "us-east1"
  project     = "aviato-game-fight-rvxirf"
  flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_us_east4" {
  name          = "default"
  ip_cidr_range = "10.0.0.0/20"
  network       = "default"
  region        = "us-east4"
  project     = "aviato-game-fight-rvxirf"
  flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_us_east5" {
  name          = "default"
  ip_cidr_range = "10.0.0.0/20"
  network       = "default"
  region        = "us-east5"
  project     = "aviato-game-fight-rvxirf"
  flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_us_south1" {
  name          = "default"
  ip_cidr_range = "10.0.0.0/20"
  network       = "default"
  region        = "us-south1"
  project     = "aviato-game-fight-rvxirf"
  flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_us_west1" {
  name          = "default"
  ip_cidr_range = "10.0.0.0/20"
  network       = "default"
  region        = "us-west1"
  project     = "aviato-game-fight-rvxirf"
  flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_us_west2" {
  name          = "default"
  ip_cidr_range = "10.0.0.0/20"
  network       = "default"
  region        = "us-west2"
  project     = "aviato-game-fight-rvxirf"
  flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_us_west3" {
  name          = "default"
  ip_cidr_range = "10.0.0.0/20"
  network       = "default"
  region        = "us-west3"
  project     = "aviato-game-fight-rvxirf"
  flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_subnet_us_west4" {
  name          = "default"
  ip_cidr_range = "10.0.0.0/20"
  network       = "default"
  region        = "us-west4"
  project     = "aviato-game-fight-rvxirf"
  flow_logs {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_project_metadata" "project_metadata" {
  project = "aviato-game-fight-rvxirf"
  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_logging_project_sink" "default" {
  name = "aviato-game-fight-rvxirf"
  destination = "storage.googleapis.com/${google_storage_bucket.default.name}"
  filter = "TRUE"
}

resource "google_storage_bucket" "default" {
  name          = "gcp-logging-bucket-20250708"
  project       = "aviato-game-fight-rvxirf"
  location      = "US"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "appspot_bucket" {
  name                        = "aviato-game-fight-rvxirf.appspot.com"
  project                     = "aviato-game-fight-rvxirf"
  location                    = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "staging_bucket" {
  name                        = "staging.aviato-game-fight-rvxirf.appspot.com"
  project                     = "aviato-game-fight-rvxirf"
  location                    = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "default_bucket" {
  name                        = "aviato-game-fight-rvxirf_bucket"
  project                     = "aviato-game-fight-rvxirf"
  location                    = "US"
  uniform_bucket_level_access = true
}

resource "google_compute_firewall" "default_allow_ssh" {
  name    = "default-allow-ssh"
  network = "default"
  project = "aviato-game-fight-rvxirf"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"] 
}

resource "google_compute_firewall" "default_allow_rdp" {
  name    = "default-allow-rdp"
  network = "default"
  project = "aviato-game-fight-rvxirf"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_cloudfunctions_function" "function" {
  name                       = "gcp-logging-functions"
  description                = "Deletes unused service accounts"
  available_memory           = 128
  project = "aviato-game-fight-rvxirf"
  region = "us-central1"
  runtime                    = "python39"
  source_archive_bucket  = "gcp-logging-functions-source"
  source_archive_object = "archive.zip"
  trigger_http               = true
  entry_point                = "hello_http"
}

resource "google_apikeys_key" "browser_key" {
  name         = "browser-key-new"
  project      = "aviato-game-fight-rvxirf"
  restrictions {
    browser_key {
      allowed_referrers = ["*"]
    }
    api_targets {
      service = "translate.googleapis.com"
      methods = ["TranslateText"]
    }
  }
}

resource "google_project_iam_member" "service_account_token_creator" {
  project = "aviato-game-fight-rvxirf"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "user:manan@aviato.consulting"
}

resource "google_project_iam_member" "service_account_user" {
  project = "aviato-game-fight-rvxirf"
  role    = "roles/iam.serviceAccountUser"
  member  = "user:manan@aviato.consulting"
}

resource "google_project_iam_binding" "twitch_login_binding" {
  project = "aviato-game-fight-rvxirf"
  role    = "roles/firebase.sdkAdminServiceAgent"
  members = ["serviceAccount:twitch-login@aviato-game-fight-rvxirf.iam.gserviceaccount.com"]
}

resource "google_project_iam_binding" "editor_binding" {
  project = "aviato-game-fight-rvxirf"
  role    = "roles/editor"
  members = [
    "serviceAccount:aviato-game-fight-rvxirf@appspot.gserviceaccount.com",
    "serviceAccount:30647320905-compute@developer.gserviceaccount.com"
  ]
}
