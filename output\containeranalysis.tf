resource "google_container_analysis_occurrence" "container_analysis" {
  project = var.project_id
  note_name = "projects/${var.project_id}/notes/container-analysis-note"
  resource_uri = "https://gcr.io/${var.project_id}/container-image"
}

resource "google_container_analysis_note" "container_analysis_note" {
  project = var.project_id
  name = "container-analysis-note"
  discovery {
    analysis_kind = "DISCOVERY"
  }
}

resource "google_container_analysis_occurrence" "gcr_container_scanning" {
  project = var.project_id
  note_name = "providers/goog-gcr.io/notes/package-vulnerability"
  resource_uri = "gcr.io/${var.project_id}/container-image"
}
