resource "google_logging_project_sink" "default" {
  name        = "all-logs-to-gcs"
  project     = var.project_id
  destination = "storage.googleapis.com/${var.project_id}-logs"
  filter      = "NOT logName:projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Fdata_access"

}
