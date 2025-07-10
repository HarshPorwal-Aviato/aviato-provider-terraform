resource "google_project_service" "apikeys" {
  service            = "apikeys.googleapis.com"
  project            = var.project_id
  disable_on_destroy = false
}
