resource "google_project_service" "containeranalysis" {
  service            = "containeranalysis.googleapis.com"
  disable_on_destroy = false
}

resource "google_container_registry" "container_registry" {
  project = var.project_id
  location = var.region

 depends_on = [google_project_service.containeranalysis]
}
