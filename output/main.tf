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
}

resource "google_project_service" "containeranalysis" {
  service            = "containeranalysis.googleapis.com"
  disable_on_destroy = false
}

resource "google_storage_bucket" "default_bucket_uniform_access_aviato" {
  name                        = "aviato-game-fight-rvxirf.appspot.com"
  location                    = "AUSTRALIA-SOUTHEAST1"
  force_destroy               = true
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "default_bucket_uniform_access_staging" {
  name                        = "staging.aviato-game-fight-rvxirf.appspot.com"
  location                    = "AUSTRALIA-SOUTHEAST1"
  force_destroy               = true
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "default_bucket_uniform_access" {
  name                        = "aviato-game-fight-rvxirf_bucket"
  location                    = "US"
  force_destroy               = true
  uniform_bucket_level_access = true
}

resource "google_compute_firewall" "ssh" {
  name    = "default-allow-ssh"
  network = "default"
  project = "aviato-game-fight-rvxirf"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["130.211.0.0/22", "35.235.0.0/24"]
}

resource "google_compute_firewall" "rdp" {
  name    = "default-allow-rdp"
  network = "default"
  project = "aviato-game-fight-rvxirf"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["130.211.0.0/22", "35.235.0.0/24"]
}

resource "google_compute_network" "default" {
  name                    = "default"
  project                 = "aviato-game-fight-rvxirf"
  delete_default_routes   = true
  auto_create_subnetworks = false
}

resource "google_compute_network_dns_policy" "default" {
  network = "default"
  project = "aviato-game-fight-rvxirf"

  enable_logging = true
}

resource "google_project_metadata" "project" {
  project = "aviato-game-fight-rvxirf"

  metadata = {
    enable-oslogin = "TRUE"
  }
}

locals {
  regions = [
    "asia-northeast2",
    "europe-west12",
    "asia-south2",
    "europe-west4",
    "us-south1",
    "australia-southeast2",
    "me-central1",
    "us-east1",
    "us-west1",
    "europe-west2",
    "us-west4",
    "us-west2",
    "europe-west8",
    "southamerica-west1",
    "europe-west9",
    "northamerica-northeast1",
    "asia-east1",
    "asia-northeast3",
    "europe-west10",
    "europe-north2",
    "asia-northeast1",
    "us-east5",
    "northamerica-northeast2",
    "asia-southeast2",
    "asia-east2",
    "asia-southeast1",
    "asia-south1",
    "europe-west3",
    "australia-southeast1",
    "us-east4",
    "europe-north1",
    "europe-southwest1",
    "europe-west1",
    "us-west3",
    "northamerica-south1",
    "us-central1",
    "europe-west6",
    "me-central2",
    "me-west1",
    "europe-central2",
    "southamerica-east1",
    "africa-south1",
  ]
}

resource "google_compute_subnetwork" "default" {
  for_each = toset(local.regions)

  name          = "default"
  ip_cidr_range = "10.10.10.0/24"
  network       = "default"
  region        = each.key
  project     = "aviato-game-fight-rvxirf"

  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_project_service" "asset" {
  service            = "cloudasset.googleapis.com"
  disable_on_destroy = false
}

resource "google_logging_metric" "audit_configuration_changes" {
  name        = "audit-configuration-changes"
  project     = "aviato-game-fight-rvxirf"
  description = "Records changes to audit configurations"
  filter      = "resource.type=audited_resource AND protoPayload.methodName=\"SetIamPolicy\""

  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_monitoring_alert_policy" "audit_configuration_changes" {
  display_name = "Audit Configuration Changes Alert"
  project      = "aviato-game-fight-rvxirf"
  combiner     = "OR"

  conditions {
    display_name = "Log Metric Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/audit-configuration-changes\" AND resource.type = \"gcp_project\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
    }
  }

  notification_channels = []
}

resource "google_logging_metric" "bucket_permission_changes" {
  name        = "bucket-permission-changes"
  project     = "aviato-game-fight-rvxirf"
  description = "Tracks IAM permission changes on Cloud Storage buckets"
  filter      = "resource.type=gcs_bucket AND protoPayload.methodName=\"storage.setIamPermissions\""

  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_monitoring_alert_policy" "bucket_permission_changes" {
  display_name = "Bucket Permission Changes Alert"
  project      = "aviato-game-fight-rvxirf"
  combiner     = "OR"

  conditions {
    display_name = "Log Metric Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/bucket-permission-changes\" AND resource.type = \"gcp_project\""
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
  description = "Records creation, deletion, or updates to custom roles"
  filter      = "resource.type=iam_role AND (protoPayload.methodName=\"google.iam.admin.v1.CreateRole\" OR protoPayload.methodName=\"google.iam.admin.v1.DeleteRole\" OR protoPayload.methodName=\"google.iam.admin.v1.UpdateRole\")"

  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_monitoring_alert_policy" "custom_role_changes" {
  display_name = "Custom Role Changes Alert"
  project      = "aviato-game-fight-rvxirf"
  combiner     = "OR"

  conditions {
    display_name = "Log Metric Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/custom-role-changes\" AND resource.type = \"gcp_project\""
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
  description = "Tracks changes to project ownership"
  filter      = "resource.type=project AND protoPayload.serviceData.policyDelta.bindingDeltas.action=\"REMOVE\" AND protoPayload.serviceData.policyDelta.bindingDeltas.role=\"roles/owner\""

  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_monitoring_alert_policy" "project_ownership_changes" {
  display_name = "Project Ownership Changes Alert"
  project      = "aviato-game-fight-rvxirf"
  combiner     = "OR"

  conditions {
    display_name = "Log Metric Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/project-ownership-changes\" AND resource.type = \"gcp_project\""
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
  description = "Records configuration changes to SQL instances"
  filter      = "resource.type=cloudsql_instance AND protoPayload.methodName = \"cloudsql.instances.update\""

  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_monitoring_alert_policy" "sql_instance_configuration_changes" {
  display_name = "SQL Instance Configuration Changes Alert"
  project      = "aviato-game-fight-rvxirf"
  combiner     = "OR"

  conditions {
    display_name = "Log Metric Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/sql-instance-configuration-changes\" AND resource.type = \"gcp_project\""
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
  description = "Tracks creation or update of firewall rules"
  filter      = "resource.type=gce_firewall_rule AND (protoPayload.methodName = \"compute.firewalls.insert\" OR protoPayload.methodName = \"compute.firewalls.patch\")"

  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_monitoring_alert_policy" "vpc_firewall_rule_changes" {
  display_name = "VPC Firewall Rule Changes Alert"
  project      = "aviato-game-fight-rvxirf"
  combiner     = "OR"

  conditions {
    display_name = "Log Metric Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-firewall-rule-changes\" AND resource.type = \"gcp_project\""
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
  description = "Records modifications to VPC networks"
  filter      = "resource.type=gce_network AND (protoPayload.methodName = \"compute.networks.insert\" OR protoPayload.methodName = \"compute.networks.patch\")"

  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_changes" {
  display_name = "VPC Network Changes Alert"
  project      = "aviato-game-fight-rvxirf"
  combiner     = "OR"

  conditions {
    display_name = "Log Metric Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-network-changes\" AND resource.type = \"gcp_project\""
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
  description = "Tracks changes to VPC network routes"
  filter      = "resource.type=gce_route AND (protoPayload.methodName = \"compute.routes.insert\" OR protoPayload.methodName = \"compute.routes.delete\")"

  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_route_changes" {
  display_name = "VPC Network Route Changes Alert"
  project      = "aviato-game-fight-rvxirf"
  combiner     = "OR"

  conditions {
    display_name = "Log Metric Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-network-route-changes\" AND resource.type = \"gcp_project\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
    }
  }

  notification_channels = []
}

resource "google_logging_project_sink" "default_sink" {
  name        = "all-logs-sink"
  project     = "aviato-game-fight-rvxirf"
  description = "Sink for exporting all logs"
  destination = "storage.googleapis.com/${google_storage_bucket.default_bucket_uniform_access.name}"
  filter      = ""
}
