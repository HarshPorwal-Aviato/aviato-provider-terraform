resource "google_project_iam_member" "cloud_asset" {
  project = var.project_id
  role    = "roles/cloudasset.serviceAgent"
  member  = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-cloudasset.iam.gserviceaccount.com"
}

data "google_project" "project" {
  project_id = var.project_id
}

resource "google_organization_iam_binding" "org_level_binding" {
  org_id = "424242424242"
  role = "roles/viewer"

  members = [
    "user:admin@example.com",
  ]
}
