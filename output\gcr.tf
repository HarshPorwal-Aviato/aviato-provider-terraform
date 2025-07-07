resource "google_container_registry" "default" {
  provider = google.gcp
  project = var.project_id
  location = "US"
}
