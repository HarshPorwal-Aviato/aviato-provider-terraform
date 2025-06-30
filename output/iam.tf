resource "google_project_iam_member" "twitch_login_storage_admin_binding" {
  project = "aviato-game-fight-rvxirf"
  role    = "roles/storage.admin"
  member  = "serviceAccount:twitch-login@aviato-game-fight-rvxirf.iam.gserviceaccount.com"
  depends_on = [google_project_service.cloudasset]
}

resource "google_project_iam_member" "appspot_editor_binding" {
  project = "aviato-game-fight-rvxirf"
  role    = "roles/editor"
  member  = "serviceAccount:aviato-game-fight-rvxirf@appspot.gserviceaccount.com"
  depends_on = [google_project_service.cloudasset]
}

resource "google_project_iam_member" "default_compute_editor_binding" {
  project = "aviato-game-fight-rvxirf"
  role    = "roles/editor"
  member  = "serviceAccount:30647320905-compute@developer.gserviceaccount.com"
    depends_on = [google_project_service.cloudasset]
}
