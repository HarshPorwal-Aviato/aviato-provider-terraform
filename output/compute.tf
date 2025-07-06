resource "google_compute_network" "default" {
  name                    = "default"
  project                 = var.project_id
  delete_default_routes = true
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "default-allow-ssh"
  project = var.project_id
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.default_ssh_source_ranges
}

resource "google_compute_firewall" "allow_rdp" {
  name    = "default-allow-rdp"
  project = var.project_id
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = var.default_rdp_source_ranges
}

resource "google_compute_subnetwork" "default_europe_west4" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.132.0.0/20"
  region        = "europe-west4"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_europe_west1" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.128.0.0/20"
  region        = "europe-west1"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_europe_west8" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.164.0.0/20"
  region        = "europe-west8"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_northamerica_south1" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.154.0.0/20"
  region        = "northamerica-south1"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_europe_west10" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.166.0.0/20"
  region        = "europe-west10"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_asia_southeast1" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.156.0.0/20"
  region        = "asia-southeast1"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_asia_east2" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.160.0.0/20"
  region        = "asia-east2"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_us_east4" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.142.0.0/20"
  region        = "us-east4"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_australia_southeast2" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.178.0.0/20"
  region        = "australia-southeast2"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_asia_northeast3" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.168.0.0/20"
  region        = "asia-northeast3"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_asia_south1" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.152.0.0/20"
  region        = "asia-south1"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_europe_west6" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.162.0.0/20"
  region        = "europe-west6"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_us_west2" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.146.0.0/20"
  region        = "us-west2"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_europe_west3" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.130.0.0/20"
  region        = "europe-west3"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_europe_southwest1" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.174.0.0/20"
  region        = "europe-southwest1"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_us_west3" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.148.0.0/20"
  region        = "us-west3"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_us_south1" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.172.0.0/20"
  region        = "us-south1"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_asia_east1" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.140.0.0/20"
  region        = "asia-east1"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_europe_west12" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.176.0.0/20"
  region        = "europe-west12"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_europe_central2" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.170.0.0/20"
  region        = "europe-central2"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_us_east1" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.128.0.0/20"
  region        = "us-east1"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_me_central1" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.158.0.0/20"
  region        = "me-central1"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_asia_northeast2" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.166.0.0/20"
  region        = "asia-northeast2"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_europe_north2" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.136.0.0/20"
  region        = "europe-north2"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_southamerica_west1" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.150.0.0/20"
  region        = "southamerica-west1"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_africa_south1" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.150.0.0/20"
  region        = "africa-south1"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_australia_southeast1" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.140.0.0/20"
  region        = "australia-southeast1"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_us_east5" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.160.0.0/20"
  region        = "us-east5"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_asia_south2" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.176.0.0/20"
  region        = "asia-south2"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_asia_northeast1" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.134.0.0/20"
  region        = "asia-northeast1"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_northamerica_northeast1" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.130.0.0/20"
  region        = "northamerica-northeast1"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_europe_west2" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.144.0.0/20"
  region        = "europe-west2"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_me_west1" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.162.0.0/20"
  region        = "me-west1"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_compute_subnetwork" "default_us_west1" {
  name          = "default"
  project       = var.project_id
  ip_cidr_range = "10.142.0.0/20"
  region        = "us-west1"
  network       = "default"
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL"
  }
}

resource "google_project_metadata" "metadata" {
  provider = google
  project = var.project_id
  metadata = {
    enable-oslogin = "TRUE"
  }
}
