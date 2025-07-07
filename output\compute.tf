resource "google_compute_network" "default" {
  name                    = var.default_network_name
  project                 = var.project_id
  auto_create_subnetworks = false
  delete_default_routes   = true
}

resource "google_compute_network" "default_dns_logging" {
  name                    = var.default_network_name
  project                 = var.project_id
  auto_create_subnetworks = false
  delete_default_routes   = true
  depends_on = [
    google_compute_network.default
  ]
}

resource "google_compute_subnetwork" "default_subnet_flow_logs" {
  for_each   = toset(var.regions)
  name          = "default"
  ip_cidr_range = "10.0.0.0/20"
  network       = "default"
  region        = each.value
  project     = var.project_id
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
  depends_on = [
    google_compute_network.default_dns_logging
  ]
}

resource "google_compute_project_metadata" "oslogin" {
  project = var.project_id

  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_compute_firewall" "rdp" {
  name    = "default-allow-rdp"
  project = var.project_id
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["10.0.0.0/8"]
}

resource "google_compute_firewall" "ssh" {
  name    = "default-allow-ssh"
  project = var.project_id
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["10.0.0.0/8"]
}
