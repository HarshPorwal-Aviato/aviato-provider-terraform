resource "google_project_service_identity" "cloudasset" {
  project = var.project_id
  service = "cloudasset.googleapis.com"
}

resource "google_project_iam_binding" "no_service_account_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  members = []
}

resource "google_project_iam_binding" "no_service_account_token_creator" {
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  members = []
}

resource "google_project_iam_binding" "enforce_separation_of_duties" {
  project = var.project_id
  role    = "roles/editor"
  members = []
}

resource "google_project_iam_binding" "service_account_no_admin" {
  for_each = toset(var.service_accounts_no_admin)
  project = var.project_id
  role    = "roles/viewer"
  members = ["serviceAccount:${each.value}"]
}

