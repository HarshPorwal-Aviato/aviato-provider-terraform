resource "google_project_iam_member" "api_keys_admin" {
  project = var.project_id
  role    = "roles/apikeys.admin"
  member  = "user:test@example.com"
}

resource "google_apikeys_key" "api_key" {
  name       = "api-key"
  project = var.project_id

  restrictions {
    api_targets {
      service = "translate.googleapis.com"
      methods = ["translate"]
    }
  }
}
