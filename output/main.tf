terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.68.0"
    }
  }
}

provider "google" {
  project = "aviato-game-fight-rvxirf"
  region  = "AUSTRALIA-SOUTHEAST1"
}

resource "google_project_metadata" "project_metadata" {
  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_project_service_identity" "gcr_service_account" {
  provider = google
  project  = "aviato-game-fight-rvxirf"
  service  = "containerregistry.googleapis.com"
}

resource "google_project_service" "container_scanning" {
  disable_on_destroy = false
  project            = "aviato-game-fight-rvxirf"
  service            = "containerscanning.googleapis.com"
}

resource "google_project_service" "cloudasset" {
  disable_on_destroy = false
  project            = "aviato-game-fight-rvxirf"
  service            = "cloudasset.googleapis.com"
}

resource "google_logging_project_sink" "all_logs" {
  name        = "all-logs-sink"
  destination = "storage.googleapis.com/${var.log_bucket_name}"
  filter      = "NOT logName:projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Fdata_access"
}

resource "google_storage_bucket" "log_bucket" {
  name                        = var.log_bucket_name
  location                    = "US"
  uniform_bucket_level_access = true
}

resource "google_compute_network" "default" {
  name                    = "default"
  project                 = "aviato-game-fight-rvxirf"
  delete_default_routes = true
}

resource "google_compute_network" "default_network" {
  name                    = "default"
  project                 = "aviato-game-fight-rvxirf"
  delete_default_routes = true
}

resource "google_compute_firewall" "default_allow_ssh" {
  name    = "default-allow-ssh"
  network = "default"
  project = "aviato-game-fight-rvxirf"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["10.0.0.0/8"]
}

resource "google_compute_firewall" "default_allow_rdp" {
  name    = "default-allow-rdp"
  network = "default"
  project = "aviato-game-fight-rvxirf"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["10.0.0.0/8"]
}

resource "google_cloudfunctions_function" "key_rotation" {
  name    = "rotate-api-key"
  project = "aviato-game-fight-rvxirf"
  runtime = "python39"

  available_memory_mb = 256
  description         = "Rotates API keys every 90 days"
  entry_point         = "main"
  https_trigger_url   = null
  region              = "us-central1"
  source_archive_bucket = "api_key_bucket"
  source_archive_object = "api_key.zip"

  ingress_settings = "ALLOW_ALL"
}

resource "google_storage_bucket" "api_key_bucket" {
  name                        = "api_key_bucket"
  location                    = "US"
  uniform_bucket_level_access = true
}

resource "google_cloudfunctions_function_iam_binding" "invoker" {
  project        = "aviato-game-fight-rvxirf"
  cloud_function = "rotate-api-key"
  region         = "us-central1"
  role           = "roles/cloudfunctions.invoker"
  members = [
    "allUsers",
  ]
}

resource "google_project_iam_member" "service_account_user" {
  project = "aviato-game-fight-rvxirf"
  role    = "roles/iam.serviceAccountUser"
  member  = "allUsers"
}

resource "google_project_iam_member" "service_account_token_creator" {
  project = "aviato-game-fight-rvxirf"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "allUsers"
}

resource "google_storage_bucket" "static_assets" {
  name                        = "static-assets-for-game-fight"
  location                    = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "appspot_bucket" {
  name                        = "aviato-game-fight-rvxirf.appspot.com"
  location                    = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "main_bucket" {
  name                        = "aviato-game-fight-rvxirf_bucket"
  location                    = "US"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "staging_bucket" {
  name                        = "staging.aviato-game-fight-rvxirf.appspot.com"
  location                    = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}

resource "google_project_iam_audit_config" "audit_config" {
  project = "aviato-game-fight-rvxirf"
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

resource "google_logging_metric" "gcs_permission_changes" {
  name        = "gcs-permission-changes"
  project     = "aviato-game-fight-rvxirf"
  description = "Log metric for GCS permission changes"
  filter      = "resource.type=gcs_bucket AND protoPayload.methodName=\"storage.setIamPermissions\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "gcs_permission_changes_alert" {
  display_name = "GCS Permission Changes Alert"
  project      = "aviato-game-fight-rvxirf"
  combiner     = "OR"

  conditions {
    display_name = "GCS Permission Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/gcs-permission-changes\" resource.type=\"gcs_bucket\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
    }
  }

  notification_channels = []
}

resource "google_logging_metric" "custom_role_changes" {
  name        = "custom-role-changes"
  project     = "aviato-game-fight-rvxirf"
  description = "Log metric for custom role changes"
  filter      = "resource.type=iam_role AND protoPayload.methodName=(\"google.iam.admin.v1.CreateRole\" OR \"google.iam.admin.v1.DeleteRole\" OR \"google.iam.admin.v1.UpdateRole\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "custom_role_changes_alert" {
  display_name = "Custom Role Changes Alert"
  project      = "aviato-game-fight-rvxirf"
  combiner     = "OR"

  conditions {
    display_name = "Custom Role Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/custom-role-changes\" resource.type=\"iam_role\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
    }
  }

  notification_channels = []
}

resource "google_logging_metric" "project_ownership_changes" {
  name        = "project-ownership-changes"
  project     = "aviato-game-fight-rvxirf"
  description = "Log metric for project ownership changes"
  filter      = "resource.type=project AND protoPayload.methodName=(\"SetIamPolicy\" OR \"UpdateProject\") AND protoPayload.serviceData.policyDelta.bindingDeltas.member:(\"user:*\" OR \"group:*\" OR \"serviceAccount:*\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "project_ownership_changes_alert" {
  display_name = "Project Ownership Changes Alert"
  project      = "aviato-game-fight-rvxirf"
  combiner     = "OR"

  conditions {
    display_name = "Project Ownership Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/project-ownership-changes\" resource.type=\"project\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
    }
  }

  notification_channels = []
}

resource "google_logging_metric" "sql_instance_configuration_changes" {
  name        = "sql-instance-configuration-changes"
  project     = "aviato-game-fight-rvxirf"
  description = "Log metric for SQL instance configuration changes"
  filter      = "resource.type=cloudsql_instance AND protoPayload.methodName=(\"cloudsql.instances.update\" OR \"cloudsql.instances.patch\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "sql_instance_configuration_changes_alert" {
  display_name = "SQL Instance Configuration Changes Alert"
  project      = "aviato-game-fight-rvxirf"
  combiner     = "OR"

  conditions {
    display_name = "SQL Instance Configuration Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/sql-instance-configuration-changes\" resource.type=\"cloudsql_instance\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
    }
  }

  notification_channels = []
}

resource "google_logging_metric" "vpc_firewall_rule_changes" {
  name        = "vpc-firewall-rule-changes"
  project     = "aviato-game-fight-rvxirf"
  description = "Log metric for VPC firewall rule changes"
  filter      = "resource.type=gce_firewall_rule AND protoPayload.methodName=(\"compute.firewalls.insert\" OR \"compute.firewalls.delete\" OR \"compute.firewalls.patch\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "vpc_firewall_rule_changes_alert" {
  display_name = "VPC Firewall Rule Changes Alert"
  project      = "aviato-game-fight-rvxirf"
  combiner     = "OR"

  conditions {
    display_name = "VPC Firewall Rule Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-firewall-rule-changes\" resource.type=\"gce_firewall_rule\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
    }
  }

  notification_channels = []
}

resource "google_logging_metric" "vpc_network_changes" {
  name        = "vpc-network-changes"
  project     = "aviato-game-fight-rvxirf"
  description = "Log metric for VPC network changes"
  filter      = "resource.type=gce_network AND protoPayload.methodName=(\"compute.networks.insert\" OR \"compute.networks.delete\" OR \"compute.networks.patch\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_changes_alert" {
  display_name = "VPC Network Changes Alert"
  project      = "aviato-game-fight-rvxirf"
  combiner     = "OR"

  conditions {
    display_name = "VPC Network Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-network-changes\" resource.type=\"gce_network\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
    }
  }

  notification_channels = []
}

resource "google_logging_metric" "vpc_network_route_changes" {
  name        = "vpc-network-route-changes"
  project     = "aviato-game-fight-rvxirf"
  description = "Log metric for VPC network route changes"
  filter      = "resource.type=gce_route AND protoPayload.methodName=(\"compute.routes.insert\" OR \"compute.routes.delete\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_route_changes_alert" {
  display_name = "VPC Network Route Changes Alert"
  project      = "aviato-game-fight-rvxirf"
  combiner     = "OR"

  conditions {
    display_name = "VPC Network Route Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-network-route-changes\" resource.type=\"gce_route\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
    }
  }

  notification_channels = []
}
