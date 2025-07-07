resource "google_project_iam_member" "api_keys_disable" {
  project = var.project_id
  role    = "roles/apikeys.admin"
  member  = "allUsers"
}
