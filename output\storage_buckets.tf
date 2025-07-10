resource "google_storage_bucket" "appspot_bucket" {
  name                        = "aviato-game-fight-rvxirf.appspot.com"
  location                    = "AUSTRALIA-SOUTHEAST1"
  project                     = var.project_id
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "staging_bucket" {
  name                        = "staging.aviato-game-fight-rvxirf.appspot.com"
  location                    = "AUSTRALIA-SOUTHEAST1"
  project                     = var.project_id
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "assets_bucket" {
  name     = "static-assets-for-game-fight"
  location = "AUSTRALIA-SOUTHEAST1"
  project  = var.project_id
}

resource "google_storage_bucket" "main_bucket" {
  name                        = "aviato-game-fight-rvxirf_bucket"
  location                    = "US"
  project                     = var.project_id
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_iam_binding" "public_access_iam" {
  bucket = google_storage_bucket.assets_bucket.name
  role   = "roles/storage.objectViewer"
  members = [
    "allUsers",
    "allAuthenticatedUsers",
  ]
}
