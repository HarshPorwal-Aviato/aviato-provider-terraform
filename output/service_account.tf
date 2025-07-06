resource "google_service_account" "unused_accounts" {
  account_id   = "unused-sa"
  display_name = "Unused Service Account"
  project = var.project_id
}
