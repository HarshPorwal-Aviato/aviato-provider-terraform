resource "google_project_service" "container_scanning" {
  service  = "containerscanning.googleapis.com"
  project  = var.project_id
  disable_on_destroy = false
}
