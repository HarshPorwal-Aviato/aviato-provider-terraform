resource "google_project_service_identity" "container_scanning" {
  project = var.project_id
  service = "containeranalysis.googleapis.com"
}
