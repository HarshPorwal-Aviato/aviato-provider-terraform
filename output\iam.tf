resource "google_project_iam_member" "cloud_asset_inventory" {
  provider = google.gcp
  project = var.project_id
  role   = "roles/cloudasset.owner"
  member = "user:admin@example.com"
}

resource "google_project_iam_binding" "no_service_account_user" {
  provider = google.gcp
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"

  members = []
}

resource "google_project_iam_binding" "no_service_account_token_creator" {
  provider = google.gcp
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"

  members = []
}

resource "google_project_iam_binding" "remove_admin_privileges" {
  provider = google.gcp
  for_each = toset(var.service_accounts_to_remove_admin_privileges)
  project = var.project_id
  role = "roles/owner"
  members = [
    "serviceAccount:${each.key}"
  ]

  lifecycle {
    ignore_changes = [
      members,
    ]
  }
}
