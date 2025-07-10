resource "google_project_service" "apikeys" {
  service            = "apikeys.googleapis.com"
  disable_on_destroy = false
}

data "google_project" "project" {
  project_id = var.project_id
}

resource "google_api_gateway_api" "api" {
  provider    = google
  name        = "api-gateway-example"
  project     = data.google_project.project.project_id
  managed_service = "managed.example.com"

 depends_on = [google_project_service.apikeys]
}

resource "google_project_iam_binding" "apikeys_iam" {
  project = data.google_project.project.project_id
  role    = "roles/apikeys.viewer"
  members = ["serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com}"]

}
