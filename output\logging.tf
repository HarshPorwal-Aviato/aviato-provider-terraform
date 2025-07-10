resource "google_project_service" "logging" {
  service = "logging.googleapis.com"
  disable_on_destroy = false
}

data "google_project" "project" {
  project_id = var.project_id
}

resource "google_logging_project_sink" "log_sink" {
  name = "aviato-game-fight-rvxirf-sink"
  project = data.google_project.project.project_id
  destination = "storage.googleapis.com/your-bucket-name"
  filter = "severity>=INFO" # Adjust filter as needed

 depends_on = [google_project_service.logging]
}
