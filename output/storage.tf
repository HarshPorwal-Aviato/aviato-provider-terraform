resource "google_storage_bucket" "public_bucket" {
  provider = google
  name                        = "static-assets-for-game-fight"
  project                     = var.project_id
  location                    = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "uniform_bucket_aviato" {
  provider = google
  name                        = "aviato-game-fight-rvxirf.appspot.com"
  project                     = var.project_id
  location                    = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "uniform_bucket_game" {
  provider = google
  name                        = "aviato-game-fight-rvxirf_bucket"
  project                     = var.project_id
  location                    = "US"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "uniform_bucket_staging" {
  provider = google
  name                        = "staging.aviato-game-fight-rvxirf.appspot.com"
  project                     = var.project_id
  location                    = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}
