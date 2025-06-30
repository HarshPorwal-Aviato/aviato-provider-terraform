resource "google_project_iam_member" "key_admin_binding" {
  project = "aviato-game-fight-rvxirf"
  role    = "roles/apikeys.admin"
  member  = "user:manan@aviato.consulting"
  depends_on = [google_project_service.cloudasset]
}
