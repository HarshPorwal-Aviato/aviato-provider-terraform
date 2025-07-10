resource "google_compute_project_metadata" "oslogin_config" {
  project = var.project_id
  metadata = {
    enable-oslogin = "TRUE"
  }
}
