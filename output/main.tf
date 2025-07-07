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
  region  = var.region
}

resource "google_project_service_identity" "gcr_sa" {
  provider = google
  project  = var.project_id
  service  = "containeranalysis.googleapis.com"
}

resource "google_project_iam_member" "artifact_registry" {
  project = var.project_id
  role    = "roles/containeranalysis.notes.attacher"
  member  = "serviceAccount:${google_project_service_identity.gcr_sa.email}"
}

resource "google_project_service" "artifactregistry" {
  provider = google
  project                    = var.project_id
  service                    = "artifactregistry.googleapis.com"
  disable_dependent_services = false
}

resource "google_artifact_registry_repository" "default" {
  provider = google
  project      = var.project_id
  location     = var.region
  repository_id = "default"
  format        = "DOCKER"
}

resource "google_container_analysis_occurrence" "default" {
  provider = google
  project  = var.project_id
  note_name = "projects/${var.project_id}/notes/vulnerability-scanning"
  resource_uri = "${google_artifact_registry_repository.default.id}"
}

resource "google_container_analysis_note" "default" {
  provider = google
  project  = var.project_id
  name      = "vulnerability-scanning"
  attestation_authority {
    hint {
      human_readable_name = "Example Attestation Authority"
    }
  }
}

resource "google_project_service" "container_analysis" {
  provider = google
  project                    = var.project_id
  service                    = "containeranalysis.googleapis.com"
  disable_dependent_services = false
}

resource "google_project_service" "cloudasset" {
  provider = google
  project                    = var.project_id
  service                    = "cloudasset.googleapis.com"
  disable_dependent_services = false
}

resource "google_project_service" "oslogin" {
  provider = google
  project                    = var.project_id
  service                    = "oslogin.googleapis.com"
  disable_dependent_services = false
}

resource "google_compute_project_metadata" "default" {
  provider = google
  project = var.project_id

  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_project_service" "cloudresourcemanager" {
  provider = google
  project                    = var.project_id
  service                    = "cloudresourcemanager.googleapis.com"
  disable_dependent_services = false
}

resource "google_project_iam_member" "cloud_asset_inventory" {
  project = var.project_id
  role    = "roles/cloudasset.viewer"
  member  = "serviceAccount:cloudasset.googleapis.com@gcp-sa-cloudasset.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "logging_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:cloudasset.googleapis.com@gcp-sa-cloudasset.iam.gserviceaccount.com"

  depends_on = [
    google_project_iam_member.cloud_asset_inventory
  ]
}

resource "google_compute_firewall" "rdp" {
  provider = google
  name    = "default-allow-rdp"
  project = var.project_id
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}

resource "google_compute_firewall" "ssh" {
  provider = google
  name    = "default-allow-ssh"
  project = var.project_id
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}

resource "google_compute_network" "default" {
  provider = google
  name                    = "default"
  project                 = var.project_id
  auto_create_subnetworks = false

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_compute_network_dns_logging_policy" "default" {
  provider = google
  project  = var.project_id
  network  = "default"
  logging_config {
    enable = true
  }
}

resource "google_logging_project_sink" "default_sink" {
  provider = google
  name        = "default-sink"
  project     = var.project_id
  destination = "storage.googleapis.com/${var.project_id}-logs"
  filter      = "LOG_ID(\"compute.googleapis.com/vpc_flow_logs\")"
}

resource "google_storage_bucket" "log_bucket" {
  provider = google
  name          = "${var.project_id}-logs"
  project     = var.project_id
  location      = "US"
  force_destroy = true
}

resource "google_storage_bucket_iam_binding" "logging_bucket_writer" {
  bucket = google_storage_bucket.log_bucket.name
  role   = "roles/storage.objectCreator"
  members = [
    "serviceAccount:gcp-sa-logging@${var.project_id}.iam.gserviceaccount.com",
  ]
}

resource "google_storage_bucket_iam_binding" "logging_bucket_viewer" {
  bucket = google_storage_bucket.log_bucket.name
  role   = "roles/storage.objectViewer"
  members = [
    "serviceAccount:gcp-sa-logging@${var.project_id}.iam.gserviceaccount.com",
  ]
}

resource "google_project_iam_binding" "service_account_user" {
  project = var.project_id
  role = "roles/iam.serviceAccountUser"
  members = []
}

resource "google_project_iam_binding" "service_account_token_creator" {
  project = var.project_id
  role = "roles/iam.serviceAccountTokenCreator"
  members = []
}

resource "google_project_iam_member" "no_admin_privileges_1" {
  project = var.project_id
  role    = "roles/viewer"
  member  = "serviceAccount:twitch-login@${var.project_id}.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "no_admin_privileges_2" {
  project = var.project_id
  role    = "roles/viewer"
  member  = "serviceAccount:aviato-game-fight-rvxirf@appspot.gserviceaccount.com"
}

resource "google_project_iam_member" "no_admin_privileges_3" {
  project = var.project_id
  role    = "roles/viewer"
  member  = "serviceAccount:30647320905-compute@developer.gserviceaccount.com"
}

resource "google_project_iam_member" "no_admin_privileges_4" {
  project = var.project_id
  role    = "roles/viewer"
  member  = "serviceAccount:firebase-adminsdk-d21rv@${var.project_id}.iam.gserviceaccount.com"
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

resource "google_monitoring_alert_policy" "audit_configuration_changes_alert" {
  project = var.project_id
  display_name = "Audit Configuration Changes Alert"
  combiner = "OR"
  conditions {
    display_name = "Audit Configuration Changes Condition"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/log_entry_count\" AND metric.labels.log=\"cloudaudit.googleapis.com%2Factivity\" AND resource.type=\"gcp_project\""
      duration = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
    }
  }
  notification_channels = []
}

resource "google_monitoring_alert_policy" "bucket_permission_changes_alert" {
  project = var.project_id
  display_name = "Cloud Storage IAM Permission Changes Alert"
  combiner = "OR"
  conditions {
    display_name = "Cloud Storage IAM Permission Changes Condition"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/log_entry_count\" AND metric.labels.log=\"cloudaudit.googleapis.com%2Factivity\" AND resource.type=\"gcs_bucket\""
      duration = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
    }
  }
  notification_channels = []
}

resource "google_monitoring_alert_policy" "custom_role_changes_alert" {
  project = var.project_id
  display_name = "Custom Role Changes Alert"
  combiner = "OR"
  conditions {
    display_name = "Custom Role Changes Condition"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/log_entry_count\" AND metric.labels.log=\"cloudaudit.googleapis.com%2Factivity\" AND resource.type=\"iam_role\""
      duration = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
    }
  }
  notification_channels = []
}

resource "google_monitoring_alert_policy" "project_ownership_changes_alert" {
  project = var.project_id
  display_name = "Project Ownership Assignments/Changes Alert"
  combiner = "OR"
  conditions {
    display_name = "Project Ownership Assignments/Changes Condition"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/log_entry_count\" AND metric.labels.log=\"cloudaudit.googleapis.com%2Factivity\" AND resource.type=\"gcp_project\""
      duration = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
    }
  }
  notification_channels = []
}

resource "google_monitoring_alert_policy" "sql_instance_configuration_changes_alert" {
  project = var.project_id
  display_name = "SQL Instance Configuration Changes Alert"
  combiner = "OR"
  conditions {
    display_name = "SQL Instance Configuration Changes Condition"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/log_entry_count\" AND metric.labels.log=\"cloudaudit.googleapis.com%2Factivity\" AND resource.type=\"cloudsql_instance\""
      duration = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
    }
  }
  notification_channels = []
}

resource "google_monitoring_alert_policy" "vpc_firewall_rule_changes_alert" {
  project = var.project_id
  display_name = "VPC Network Firewall Rule Changes Alert"
  combiner = "OR"
  conditions {
    display_name = "VPC Network Firewall Rule Changes Condition"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/log_entry_count\" AND metric.labels.log=\"cloudaudit.googleapis.com%2Factivity\" AND resource.type=\"gcp_firewall_rule\""
      duration = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
    }
  }
  notification_channels = []
}

resource "google_monitoring_alert_policy" "vpc_network_changes_alert" {
  project = var.project_id
  display_name = "VPC Network Changes Alert"
  combiner = "OR"
  conditions {
    display_name = "VPC Network Changes Condition"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/log_entry_count\" AND metric.labels.log=\"cloudaudit.googleapis.com%2Factivity\" AND resource.type=\"gcp_network\""
      duration = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
    }
  }
  notification_channels = []
}

resource "google_monitoring_alert_policy" "vpc_network_route_changes_alert" {
  project = var.project_id
  display_name = "VPC Network Route Changes Alert"
  combiner = "OR"
  conditions {
    display_name = "VPC Network Route Changes Condition"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/log_entry_count\" AND metric.labels.log=\"cloudaudit.googleapis.com%2Factivity\" AND resource.type=\"gcp_route\""
      duration = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "audit_configuration_changes_metric" {
  provider = google
  name = "audit-configuration-changes-metric"
  project = var.project_id
  description = "Counts the number of audit configuration changes"
  filter = "logName:cloudaudit.googleapis.com%2Factivity AND protoPayload.methodName:SetIamPolicy"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_logging_metric" "bucket_permission_changes_metric" {
  provider = google
  name = "bucket-permission-changes-metric"
  project = var.project_id
  description = "Counts the number of Cloud Storage IAM Permission Changes"
  filter = "logName:cloudaudit.googleapis.com%2Factivity AND protoPayload.methodName:storage.setIamPermissions"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_logging_metric" "custom_role_changes_metric" {
  provider = google
  name = "custom-role-changes-metric"
  project = var.project_id
  description = "Counts the number of custom role changes"
  filter = "logName:cloudaudit.googleapis.com%2Factivity AND protoPayload.methodName:iam.roles.patch"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_logging_metric" "project_ownership_changes_metric" {
  provider = google
  name = "project-ownership-changes-metric"
  project = var.project_id
  description = "Counts the number of project ownership assignments/changes"
  filter = "logName:cloudaudit.googleapis.com%2Factivity AND protoPayload.methodName:SetIamPolicy"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_logging_metric" "sql_instance_configuration_changes_metric" {
  provider = google
  name = "sql-instance-configuration-changes-metric"
  project = var.project_id
  description = "Counts the number of SQL instance configuration changes"
  filter = "logName:cloudaudit.googleapis.com%2Factivity AND protoPayload.methodName:cloudsql.instances.patch"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_logging_metric" "vpc_firewall_rule_changes_metric" {
  provider = google
  name = "vpc-firewall-rule-changes-metric"
  project = var.project_id
  description = "Counts the number of VPC Network Firewall Rule Changes"
  filter = "logName:cloudaudit.googleapis.com%2Factivity AND protoPayload.methodName:compute.firewalls.insert"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_logging_metric" "vpc_network_changes_metric" {
  provider = google
  name = "vpc-network-changes-metric"
  project = var.project_id
  description = "Counts the number of VPC Network Changes"
  filter = "logName:cloudaudit.googleapis.com%2Factivity AND protoPayload.methodName:compute.networks.insert"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_logging_metric" "vpc_network_route_changes_metric" {
  provider = google
  name = "vpc-network-route-changes-metric"
  project = var.project_id
  description = "Counts the number of VPC Network Route Changes"
  filter = "logName:cloudaudit.googleapis.com%2Factivity AND protoPayload.methodName:compute.routes.insert"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_compute_subnetwork" "default_subnetworks" {
  for_each = toset(var.default_subnets)
  name                     = "default"
  ip_cidr_range            = "10.0.0.0/20"
  network                  = "default"
  project                  = var.project_id
  region                   = each.value
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_storage_bucket" "buckets" {
  for_each = toset(var.bucket_names)
  name          = each.value
  project       = var.project_id
  location      = "US"
  uniform_bucket_level_access = true
}
