resource "google_project_iam_member" "service_account_token_creator" {
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "group:admins@example.com"
}

resource "google_project_iam_member" "service_account_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "group:admins@example.com"
}

resource "google_project_iam_binding" "no_admin_privileges" {
  project = var.project_id
  role    = "roles/viewer"
  members = [
    "serviceAccount:twitch-login@aviato-game-fight-rvxirf.iam.gserviceaccount.com",
    "serviceAccount:aviato-game-fight-rvxirf@appspot.gserviceaccount.com",
    "serviceAccount:30647320905-compute@developer.gserviceaccount.com",
    "serviceAccount:firebase-adminsdk-d21rv@aviato-game-fight-rvxirf.iam.gserviceaccount.com",
  ]
}
