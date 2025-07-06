resource "google_project_service" "containerscanning" {
  provider = google
  project = var.project_id
  service = "containerscanning.googleapis.com"
  disable_on_destroy = false
}
