resource "google_project_service" "cloudasset" {
  service            = "cloudasset.googleapis.com"
  project            = var.project_id
  disable_on_destroy = false
}
