resource "google_project_service_identity" "artifact_registry" {
  provider = google.gcp
  project = var.project_id
  service = "artifactregistry.googleapis.com"
}

resource "google_artifact_registry_repository" "default" {
  provider = google.gcp
  project      = var.project_id
  location     = "us-central1"
  repository_id = "my-repo"
  format       = "DOCKER"
}
