resource "google_storage_bucket" "default_buckets" {
  for_each = toset([
    "aviato-game-fight-rvxirf.appspot.com",
    "aviato-game-fight-rvxirf_bucket",
    "staging.aviato-game-fight-rvxirf.appspot.com"
  ])
  name          = each.value
  project       = var.project_id
  location      = "US"
  force_destroy = false
  uniform_bucket_level_access = true
}
