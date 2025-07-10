resource "google_project_iam_member" "remove_service_account_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "user:manan@aviato.consulting"
}

resource "google_project_iam_member" "remove_service_account_token_creator" {
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "user:manan@aviato.consulting"
}
resource "google_project_iam_binding" "editor_binding_compute" {
  project = var.project_id
  role    = "roles/editor"

  members = [
    "serviceAccount:30647320905-compute@developer.gserviceaccount.com",
  ]
}

resource "google_project_iam_binding" "editor_binding_appspot" {
  project = var.project_id
  role    = "roles/editor"

  members = [
    "serviceAccount:aviato-game-fight-rvxirf@appspot.gserviceaccount.com",
  ]
}

resource "google_project_iam_binding" "firebase_sdk_admin_service_agent_binding" {
  project = var.project_id
  role    = "roles/firebase.sdkAdminServiceAgent"

  members = [
    "serviceAccount:twitch-login@aviato-game-fight-rvxirf.iam.gserviceaccount.com",
  ]
}

resource "google_project_iam_binding" "storage_admin_binding" {
  project = var.project_id
  role    = "roles/storage.admin"

  members = [
    "serviceAccount:firebase-adminsdk-d21rv@aviato-game-fight-rvxirf.iam.gserviceaccount.com",
  ]
}
