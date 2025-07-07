resource "google_project_iam_member" "api_keys_admin" {
  provider = google.gcp
  project = var.project_id
  role   = "roles/apikeys.admin"
  member = "user:admin@example.com"
}
