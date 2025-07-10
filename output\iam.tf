data "google_project" "project" {
  project_id = var.project_id
}

resource "google_project_iam_binding" "service_account_token_creator" {
  project = data.google_project.project.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  members = []
}

resource "google_project_iam_binding" "service_account_user" {
  project = data.google_project.project.project_id
  role    = "roles/iam.serviceAccountUser"
  members = []
}

resource "google_service_account" "service_accounts" {
 account_id   = "twitch-login"
  display_name = "twitch-login service account"
  project      = var.project_id
}

resource "google_project_iam_member" "compute_admin_binding" {
  project = data.google_project.project.project_id
  role    = "roles/firebase.sdkAdminServiceAgent"
  member  = "serviceAccount:twitch-login@${var.project_id}.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "compute_editor_binding" {
  project = data.google_project.project.project_id
  role    = "roles/editor"
  member  = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
}

resource "google_project_iam_member" "storage_admin_binding" {
  project = data.google_project.project.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:firebase-adminsdk-d21rv@${var.project_id}.iam.gserviceaccount.com"
}
