resource "google_compute_network" "default" {
  provider = google.gcp
  name                    = "default"
  project                 = var.project_id
  auto_create_subnetworks = false

  lifecycle {
    ignore_changes = [
      auto_create_subnetworks,
    ]
  }
}

resource "google_compute_firewall" "rdp" {
  provider = google.gcp
  name    = "default-allow-rdp"
  project = var.project_id
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
  direction     = "INGRESS"
  source_ranges = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}

resource "google_compute_firewall" "ssh" {
  provider = google.gcp
  name    = "default-allow-ssh"
  project = var.project_id
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  direction     = "INGRESS"
  source_ranges = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}

resource "google_compute_network_dns_logging_policy" "default" {
  provider = google.gcp
  name        = "default"
  network     = "default"
  project     = var.project_id
  dns_logging = true
}


resource "google_compute_subnetwork" "default" {
  provider = google.gcp
  for_each = toset(var.regions)
  name                     = "default"
  ip_cidr_range            = "10.128.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = each.key
  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}
