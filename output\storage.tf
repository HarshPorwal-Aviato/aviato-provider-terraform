resource "google_storage_bucket" "buckets" {
  for_each = toset(var.bucket_names)
  name          = each.key
  project       = var.project_id
  location      = "AUSTRALIA-SOUTHEAST1"
  force_destroy = false
  uniform_bucket_level_access = true
}
