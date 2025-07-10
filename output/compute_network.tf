resource "google_compute_network" "default" {
  name                    = "default"
  project                 = var.project_id
  auto_create_subnetworks = false
  delete_default_routes   = true
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "default-allow-ssh"
  project = var.project_id
  network = google_compute_network.default.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["10.0.0.0/8"]
}

resource "google_compute_firewall" "allow_rdp" {
  name    = "default-allow-rdp"
  project = var.project_id
  network = google_compute_network.default.name
  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
  source_ranges = ["10.0.0.0/8"]
}

resource "google_compute_subnet" "default" {
  for_each = toset(var.regions)

  name                     = "default"
  project                  = var.project_id
  region                   = each.value
  network                  = google_compute_network.default.name
  ip_cidr_range            = "10.10.0.0/20"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_global_network_endpoint_group" "default" {
  count                   = google_compute_network.default.name != "default" ? 1 : 0
  name                    = "default-global-neg"
  project                 = var.project_id
  network                 = google_compute_network.default.name
  default_port            = 80
}
