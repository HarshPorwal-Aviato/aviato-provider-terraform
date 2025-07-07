resource "google_project_service_identity" "cloudasset" {
  provider = google
  project  = var.project_id
  service  = "cloudasset.googleapis.com"
}

resource "google_project_iam_member" "cloudasset_member" {
  provider = google
  project  = var.project_id
  role   = "roles/cloudasset.serviceAgent"
  member = "serviceAccount:${data.google_project_service_identity.cloudasset.email}"
}

data "google_project_service_identity" "cloudasset" {
  provider = google
  project  = var.project_id
  service  = "cloudasset.googleapis.com"
}

resource "google_project_service" "cloudasset_googleapis_com" {
  provider = google
  project = var.project_id
  service = "cloudasset.googleapis.com"
  disable_on_destroy = false
}
