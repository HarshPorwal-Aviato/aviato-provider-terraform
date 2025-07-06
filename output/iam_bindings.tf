data "google_iam_policy" "custom_role_policy" {
  binding {
    role = "roles/viewer"
    members = [
      "user:manan@aviato.consulting",
    ]
  }
}

resource "google_project_iam_policy" "project" {
  project = var.project_id
  policy_data = data.google_iam_policy.custom_role_policy.policy_data
}
