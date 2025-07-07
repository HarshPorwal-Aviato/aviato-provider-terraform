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

resource "google_project_service_identity" "gcr_service_account" {
  provider = google
  project  = var.project_id
  service  = "containeranalysis.googleapis.com"
}

resource "google_project_iam_member" "artifact_registry_admin" {
  provider = google
  project = var.project_id
  role    = "roles/artifactregistry.admin"
  member  = "serviceAccount:${google_project_service_identity.gcr_service_account.email}"
}

resource "google_container_registry" "default" {
  provider = google
  project  = var.project_id
  location = "US"
}

resource "google_project_service" "artifactregistry" {
  provider = google
  project            = var.project_id
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudasset" {
  provider = google
  project            = var.project_id
  service            = "cloudasset.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "containeranalysis" {
  provider = google
  project            = var.project_id
  service            = "containeranalysis.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_project_metadata" "oslogin" {
  provider = google
  project  = var.project_id

  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_compute_network" "default" {
  provider = google
  name                    = "default"
  project                 = var.project_id
  delete_default_routes = true

  lifecycle {
    ignore_changes = [
      delete_default_routes
    ]
  }
}

resource "google_logging_project_sink" "default_sink" {
  provider = google
  name        = "all-logs"
  project     = var.project_id
  destination = "bigquery.googleapis.com/projects/${var.project_id}/datasets/logging_dataset"
  filter      = "NOT logName:projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Fdata_access"
}

resource "google_bigquery_dataset" "logging_dataset" {
  provider = google
  dataset_id    = "logging_dataset"
  project       = var.project_id
  location      = "US"
}

resource "google_logging_metric" "audit_configuration_changes" {
  provider = google
  name        = "audit-configuration-changes"
  project     = var.project_id
  description = "Log metric for audit configuration changes"
  filter      = "resource.type=audited_resource AND protoPayload.methodName=google.cloud.audit.AuditLogs.UpdateAuditConfig"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "audit_configuration_changes_alert" {
  provider = google
  display_name = "Alert for Audit Configuration Changes"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Condition for Audit Configuration Changes"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/audit-configuration-changes\" resource.type=\"global\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "bucket_permission_changes" {
  provider = google
  name        = "bucket-permission-changes"
  project     = var.project_id
  description = "Log metric for bucket permission changes"
  filter      = "resource.type=gcs_bucket AND protoPayload.methodName=storage.setIamPermissions"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "bucket_permission_changes_alert" {
  provider = google
  display_name = "Alert for Bucket Permission Changes"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Condition for Bucket Permission Changes"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/bucket-permission-changes\" resource.type=\"global\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "custom_role_changes" {
  provider = google
  name        = "custom-role-changes"
  project     = var.project_id
  description = "Log metric for custom role changes"
  filter      = "resource.type=iam_role AND (protoPayload.methodName=google.iam.admin.v1.CreateRole OR protoPayload.methodName=google.iam.admin.v1.DeleteRole OR protoPayload.methodName=google.iam.admin.v1.UpdateRole)"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "custom_role_changes_alert" {
  provider = google
  display_name = "Alert for Custom Role Changes"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Condition for Custom Role Changes"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/custom-role-changes\" resource.type=\"global\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "project_ownership_changes" {
  provider = google
  name        = "project-ownership-changes"
  project     = var.project_id
  description = "Log metric for project ownership changes"
  filter      = "resource.type=project AND protoPayload.methodName=SetIamPolicy"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "project_ownership_changes_alert" {
  provider = google
  display_name = "Alert for Project Ownership Changes"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Condition for Project Ownership Changes"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/project-ownership-changes\" resource.type=\"global\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "sql_instance_configuration_changes" {
  provider = google
  name        = "sql-instance-configuration-changes"
  project     = var.project_id
  description = "Log metric for SQL instance configuration changes"
  filter      = "resource.type=cloudsql_database AND protoPayload.methodName=cloudsql.instances.update"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "sql_instance_configuration_changes_alert" {
  provider = google
  display_name = "Alert for SQL Instance Configuration Changes"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Condition for SQL Instance Configuration Changes"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/sql-instance-configuration-changes\" resource.type=\"global\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "vpc_firewall_rule_changes" {
  provider = google
  name        = "vpc-firewall-rule-changes"
  project     = var.project_id
  description = "Log metric for VPC firewall rule changes"
  filter      = "resource.type=gce_firewall_rule AND (protoPayload.methodName=compute.firewalls.insert OR protoPayload.methodName=compute.firewalls.delete OR protoPayload.methodName=compute.firewalls.patch)"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "vpc_firewall_rule_changes_alert" {
  provider = google
  display_name = "Alert for VPC Firewall Rule Changes"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Condition for VPC Firewall Rule Changes"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-firewall-rule-changes\" resource.type=\"global\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "vpc_network_changes" {
  provider = google
  name        = "vpc-network-changes"
  project     = var.project_id
  description = "Log metric for VPC network changes"
  filter      = "resource.type=gce_network AND (protoPayload.methodName=compute.networks.insert OR protoPayload.methodName=compute.networks.delete OR protoPayload.methodName=compute.networks.patch)"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_changes_alert" {
  provider = google
  display_name = "Alert for VPC Network Changes"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Condition for VPC Network Changes"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-network-changes\" resource.type=\"global\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "vpc_network_route_changes" {
  provider = google
  name        = "vpc-network-route-changes"
  project     = var.project_id
  description = "Log metric for VPC network route changes"
  filter      = "resource.type=gce_route AND (protoPayload.methodName=compute.routes.insert OR protoPayload.methodName=compute.routes.delete)"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_route_changes_alert" {
  provider = google
  display_name = "Alert for VPC Network Route Changes"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Condition for VPC Network Route Changes"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-network-route-changes\" resource.type=\"global\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }
  notification_channels = []
}

resource "google_compute_subnetwork" "default" {
  provider = google
  for_each = toset(var.regions)
  name                     = "default"
  ip_cidr_range          = "10.10.10.0/24"
  network                  = "default"
  region                   = each.key
  project                  = var.project_id
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_storage_bucket" "default_buckets" {
  provider = google
  for_each = toset(var.bucket_names)
  name          = each.key
  project       = var.project_id
  location      = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
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

  source_ranges = ["10.0.0.0/8"]
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

  source_ranges = ["10.0.0.0/8"]
}
