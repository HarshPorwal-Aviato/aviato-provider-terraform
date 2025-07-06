resource "google_project_service_identity" "apikeys_service_identity" {
  provider = google
  project = var.project_id
  service = "apikeys.googleapis.com"
}

resource "google_api_gateway_api_config_iam_member" "apikeys_iam_binding" {
  provider = google
  api_config = ""
  api = ""
  member = "serviceAccount:${google_project_service_identity.apikeys_service_identity.email}"
  role = "roles/apikeys.serviceAgent"
}
