resource "google_compute_network" "default" {
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
  name    = "default-allow-rdp"
  network = "default"
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]

  target_tags = ["rdp"]
}

resource "google_compute_firewall" "ssh" {
  name    = "default-allow-ssh"
  network = "default"
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]

  target_tags = ["ssh"]
}

resource "google_compute_network" "default_network_deletion" {
  name                    = "default"
  project                 = var.project_id
  auto_create_subnetworks = false
  delete_default_routes = true

  lifecycle {
    ignore_changes = [
      auto_create_subnetworks,
    ]
  }
}

resource "google_compute_network" "default_network_dns_logging" {
  name                    = "default"
  project                 = var.project_id
  auto_create_subnetworks = false
  enable_logging = true

  lifecycle {
    ignore_changes = [
      auto_create_subnetworks,
    ]
  }
}

resource "google_compute_subnetwork" "default_subnetworks" {
  for_each     = toset(var.default_subnets)
  name         = each.value
  ip_cidr_range = "10.10.10.0/24"
  network      = "default"
  region       = each.value
  project      = var.project_id
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_project_metadata" "oslogin" {
  project = var.project_id

  metadata = {
    enable-oslogin = "TRUE"
  }
}
