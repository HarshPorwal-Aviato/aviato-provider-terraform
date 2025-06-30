data "google_project" "project" {
  project_id = var.project_id
}

resource "google_project_iam_binding" "compute_service_account" {
  project = var.project_id
  role    = "roles/compute.instanceAdmin.v1"
  members = [
    "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com",
  ]
}

resource "google_project_iam_binding" "remove_firebase_admin_sdk_role" {
  project = var.project_id
  role    = "roles/storage.admin"
  members = [
    "serviceAccount:firebase-adminsdk-d21rv@${var.project_id}.iam.gserviceaccount.com",
  ]
}

resource "google_project_iam_binding" "remove_appspot_default_editor_role" {
  project = var.project_id
  role    = "roles/editor"
  members = [
    "serviceAccount:${var.project_id}@appspot.gserviceaccount.com",
    "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com",
  ]
}

resource "google_project_iam_member" "remove_service_account_admin_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountAdmin"
  member  = "user:manan@aviato.consulting"
}

resource "google_project_iam_member" "remove_service_account_user_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "user:manan@aviato.consulting"
}

resource "google_service_account_key" "delete_twitch_login_key" {
  service_account_id = "twitch-login@${var.project_id}.iam.gserviceaccount.com"
  lifecycle {
    prevent_destroy = false
  }
}

resource "google_service_account_key" "delete_compute_service_account_key" {
  service_account_id = "${data.google_project.project.number}-compute@developer.gserviceaccount.com"
  lifecycle {
    prevent_destroy = false
  }
}

resource "google_service_account" "delete_unused_service_account_1" {
  account_id   = "${var.project_id}@appspot.gserviceaccount.com"
  project = var.project_id
  disabled     = true
}

resource "google_service_account" "delete_unused_service_account_2" {
  account_id   = "firebase-adminsdk-d21rv@${var.project_id}.iam.gserviceaccount.com"
  project = var.project_id
  disabled     = true
}
