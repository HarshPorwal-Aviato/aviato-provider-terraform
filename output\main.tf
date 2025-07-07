terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.24.0"
    }
  }
}

provider "google" {
  project = var.project_id
}

resource "google_project_service_identity" "gcs_service_account" {
  provider = google
  project  = var.project_id
  service  = "storage.googleapis.com"
}

resource "google_project_service" "artifactregistry" {
  provider = google
  project  = var.project_id
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_artifact_registry_repository" "default" {
  provider = google
  project      = var.project_id
  location     = "us-central1"
  repository_id = "container-analysis-metadata"
  format       = "DOCKER"
}

resource "google_project_service" "containeranalysis" {
  provider = google
  project  = var.project_id
  service            = "containeranalysis.googleapis.com"
  disable_on_destroy = false
  depends_on = [google_project_service.artifactregistry]
}


resource "google_container_analysis_occurrence" "note_occurrence" {
  provider = google
  project  = var.project_id
  note_name   = "projects/${var.project_id}/notes/container-analysis-metadata"
  resource_uri = "https://gcr.io/google-containers/pause:3.9"

  attestation {
    generic_signed_attestation {
      content = "MEUCIQC4hR3DyNrnX9Ea9jAFZc/yLqBTtqg+47yU/QdEkxK6QQIgdtX9mYy0j0+mF7iXm9j/J1ntLHO4Qv0WkY0tcZ5210="
      signature_id {
        key_id = "foo"
      }
    }
  }
}

resource "google_container_analysis_note" "note" {
  provider = google
  project  = var.project_id
  name      = "container-analysis-metadata"

  attestation_authority {
    hint {
      human_readable_name = "Example attestation authority"
    }
  }
}


resource "google_project_iam_member" "container_analysis_account" {
  project = var.project_id
  role    = "roles/containeranalysis.notes.attacher"
  member  = "serviceAccount:${google_project_service_identity.gcs_service_account.email}"
}

resource "google_project_service" "cloudasset" {
  provider = google
  project  = var.project_id
  service            = "cloudasset.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_default_network" "default_network" {
  project = var.project_id

  action = "delete"
}

resource "google_project_service" "dns" {
  provider = google
  project  = var.project_id
  service            = "dns.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "oslogin" {
  provider = google
  project  = var.project_id
  service            = "oslogin.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_project_metadata" "oslogin_enabled" {
  project = var.project_id
  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_logging_project_sink" "default" {
  provider = google
  name   = "all-logs"
  project = var.project_id
  destination = "storage.googleapis.com/${var.project_id}-all-logs"
  filter = "NOT logName:\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Fdata_access\""
}

resource "google_storage_bucket" "logging_bucket" {
  name          = "${var.project_id}-all-logs"
  project       = var.project_id
  location      = "US"
  force_destroy = true
  uniform_bucket_level_access = true
}

resource "google_project_iam_binding" "logging_bucket_writer" {
  project = var.project_id
  role = "roles/storage.objectCreator"
  members = [
    "serviceAccount:cloud-logs@system.gserviceaccount.com",
    "serviceAccount:gcp-sa-logging@gcp-sa-logging.iam.gserviceaccount.com",
  ]
}

resource "google_cloudbuildv2_connection" "primary" {
  name     = "github-connection"
  location = "us-central1"
  project  = var.project_id

  github {
    app_installation_id = "348986256"
    authorizer_credential {
      oauth_token_secret_version = "1"
    }
  }
}

resource "google_cloudbuildv2_repository" "primary" {
  connection = google_cloudbuildv2_connection.primary.name
  name       = "github.com/GoogleCloudPlatform/cloud-builders"
  project    = var.project_id
  location   = "us-central1"
}

resource "google_gke_hub_feature" "policycontroller" {
  name     = "policycontroller"
  project  = var.project_id
  location = "global"
}

resource "google_compute_firewall" "rdp" {
  name    = "deny-rdp-ingress"
  project = var.project_id
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  direction     = "INGRESS"
}

resource "google_compute_firewall" "ssh" {
  name    = "deny-ssh-ingress"
  project = var.project_id
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  direction     = "INGRESS"
}


resource "google_project_iam_audit_config" "audit_config" {
  provider = google
  project = var.project_id
  service = "allServices"

  audit_log_config {
    log_type = "ADMIN_READ"
  }

  audit_log_config {
    log_type = "DATA_READ"
  }

  audit_log_config {
    log_type = "DATA_WRITE"
  }
}

resource "google_project_service" "compute" {
  provider = google
  project  = var.project_id
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_subnetwork" "default" {
  provider = google
  for_each = toset(var.regions)
  name                     = "default"
  ip_cidr_range            = "10.128.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = each.key
  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_storage_bucket" "buckets" {
  provider = google
  for_each = toset(var.bucket_names)
  name                        = each.key
  project                     = var.project_id
  location                    = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}

resource "google_project_iam_member" "no_service_account_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "user:test@example.com"
}

resource "google_project_iam_member" "no_service_account_token_creator" {
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "user:test@example.com"
}

resource "google_project_service" "apikeys" {
  provider = google
  project  = var.project_id
  service            = "apikeys.googleapis.com"
  disable_on_destroy = false
}

resource "google_api_gateway_api_config" "api_config" {
  provider = google
  api          = "test-api"
  project = var.project_id
  gateway_service_account = "test@example.com"
}

resource "google_service_account_iam_binding" "service_account_iam_binding" {
  service_account_id = "test-service-account"
  project = var.project_id
  role               = "roles/viewer"
  members = [
    "user:test@example.com",
  ]
}

resource "google_service_account" "service_account" {
  provider = google
  account_id   = "test-service-account"
  project = var.project_id
  disabled     = true
}

resource "google_service_account_key" "service_account_key" {
  provider = google
  service_account_id = "test-service-account"
  project = var.project_id
  key_algorithm      = "KEY_ALG_RSA_2048"
  public_key_type    = "TYPE_X509_PEM_FILE"
}
