resource "google_project_service" "containeranalysis" {
  provider = google
  project = var.project_id
  service = "containeranalysis.googleapis.com"
  disable_on_destroy = false
}
