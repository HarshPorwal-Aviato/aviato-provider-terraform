resource "google_storage_bucket" "buckets" {
  provider = google.gcp
  for_each = toset(var.uniform_bucket_level_access_buckets)
  name                        = each.key
  project                     = var.project_id
  location                    = "US"
  uniform_bucket_level_access = true
}
