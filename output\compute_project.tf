resource "google_compute_project_metadata" "project" {
  provider = google.gcp
  project = var.project_id
  metadata = {
    enable-oslogin = "TRUE"
  }
}
