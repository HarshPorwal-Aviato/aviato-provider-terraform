data "google_project" "project" {
  project_id = "aviato-game-fight-rvxirf"
}

resource "google_project_iam_member" "remove_editor_from_compute_sa" {
  project = data.google_project.project.project_id
  role    = "roles/editor"
  member  = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
}

resource "google_project_iam_member" "remove_editor_from_appspot_sa" {
  project = data.google_project.project.project_id
  role    = "roles/editor"
  member  = "serviceAccount:aviato-game-fight-rvxirf@appspot.gserviceaccount.com"
}

resource "google_project_iam_member" "limited_appspot_sa" {
  project = data.google_project.project.project_id
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:aviato-game-fight-rvxirf@appspot.gserviceaccount.com"
}

resource "google_project_iam_member" "limited_compute_sa" {
  project = data.google_project.project.project_id
  role    = "roles/compute.networkViewer"
  member  = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
}

resource "google_project_iam_member" "remove_sdkadmin_from_twitch_sa" {
  project = data.google_project.project.project_id
  role    = "roles/firebase.sdkAdminServiceAgent"
  member  = "serviceAccount:twitch-login@aviato-game-fight-rvxirf.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "limited_twitch_sa" {
  project = data.google_project.project.project_id
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:twitch-login@aviato-game-fight-rvxirf.iam.gserviceaccount.com"
}
