resource "google_compute_network" "default" {
  name                    = "default"
  project                 = var.project_id
  auto_create_subnetworks = false
  delete_default_routes_on_create = true
}

resource "google_compute_network_dns_policy" "dns_logging_default" {
  network = "default"
  project = var.project_id

  enable_logging = true
}

resource "google_compute_subnetwork" "default_asia_east1" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "asia-east1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_east2" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "asia-east2"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_northeast1" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "asia-northeast1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_northeast2" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "asia-northeast2"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_northeast3" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "asia-northeast3"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_south1" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "asia-south1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_south2" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "asia-south2"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_southeast1" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "asia-southeast1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_southeast2" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "asia-southeast2"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_australia_southeast1" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "australia-southeast1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_australia_southeast2" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "australia-southeast2"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_central2" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "europe-central2"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_north1" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "europe-north1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_north2" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "europe-north2"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_southwest1" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "europe-southwest1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west1" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "europe-west1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west10" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "europe-west10"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west12" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "europe-west12"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west2" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "europe-west2"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west3" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "europe-west3"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west4" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "europe-west4"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west6" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "europe-west6"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west8" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "europe-west8"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west9" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
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
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "me-central1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_me_central2" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "me-central2"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_me_west1" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "me-west1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_northamerica_northeast1" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "northamerica-northeast1"
  private_ip_google_access = true
 log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_northamerica_northeast2" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "northamerica-northeast2"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_northamerica_south1" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "northamerica-south1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_southamerica_east1" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "southamerica-east1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_southamerica_west1" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "southamerica-west1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_central1" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "us-central1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_east1" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "us-east1"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_east4" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "us-east4"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_east5" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "us-east5"
  private_ip_google_access = true
 log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_south1" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "us-south1"
  private_ip_google_access = true
 log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_west1" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "us-west1"
  private_ip_google_access = true
 log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_west2" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "us-west2"
  private_ip_google_access = true
 log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_west3" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "us-west3"
  private_ip_google_access = true
 log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_west4" {
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = "us-west4"
  private_ip_google_access = true
 log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_project_metadata" "project_metadata" {
  project = var.project_id

  metadata = {
    enable-oslogin = "TRUE"
  }
}
