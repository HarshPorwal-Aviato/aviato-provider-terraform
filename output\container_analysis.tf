resource "google_container_analysis_occurrence" "artifact_analysis" {
  project = var.project_id
  note_name = "projects/goog-analysis/notes/PACKAGE_VULNERABILITY"
  resource_uri = "https://gcr.io/${var.project_id}/test-image:latest"
}
