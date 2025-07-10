resource "google_storage_bucket" "static_assets" {
  name          = "static-assets-for-game-fight"
  project       = var.project_id
  location      = "AUSTRALIA-SOUTHEAST1"
  force_destroy = true
  uniform_bucket_level_access = true
  storage_class = "STANDARD"
}

resource "google_storage_bucket" "appspot_bucket" {
  name          = "aviato-game-fight-rvxirf.appspot.com"
  project       = var.project_id
  location      = "AUSTRALIA-SOUTHEAST1"
  force_destroy = true
  uniform_bucket_level_access = true
  storage_class = "STANDARD"
}

resource "google_storage_bucket" "staging_appspot_bucket" {
  name          = "staging.aviato-game-fight-rvxirf.appspot.com"
  project       = var.project_id
  location      = "AUSTRALIA-SOUTHEAST1"
  force_destroy = true
  uniform_bucket_level_access = true
  storage_class = "STANDARD"
}

resource "google_storage_bucket" "default_bucket" {
  name          = "aviato-game-fight-rvxirf_bucket"
  project       = var.project_id
  location      = "US"
  force_destroy = true
  uniform_bucket_level_access = true
  storage_class = "STANDARD"
}
