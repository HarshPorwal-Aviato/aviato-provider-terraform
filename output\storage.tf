resource "google_storage_bucket" "buckets_uniform_access" {
  for_each = toset(var.uniform_bucket_level_access_buckets)
  name     = each.value
  project  = var.project_id
  location = "US"
  uniform_bucket_level_access = true
}
