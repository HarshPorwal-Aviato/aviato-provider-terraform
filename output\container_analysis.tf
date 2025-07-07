resource "google_container_analysis_occurrence" "artifact_analysis" {
  project = var.project_id
  note_name   = "providers/goog-public-dns/notes/package-vulnerability"
  resource_uri = "https://gcr.io/cloud-marketplace-tools/k8s/etcd:3.0.17"
}
