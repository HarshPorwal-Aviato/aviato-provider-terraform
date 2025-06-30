resource "google_storage_bucket" "default" {
  name                        = "aviato-game-fight-rvxirf.appspot.com"
  project                     = var.project_id
  location                    = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "default_1" {
  name                        = "aviato-game-fight-rvxirf_bucket"
  project                     = var.project_id
  location                    = "US"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "default_2" {
  name                        = "staging.aviato-game-fight-rvxirf.appspot.com"
  project                     = var.project_id
  location                    = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}
