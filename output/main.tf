terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.63.0"
    }
  }
}

provider "google" {
  project = "aviato-game-fight-rvxirf"
}

resource "google_project_metadata" "oslogin" {
  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_compute_network" "default" {
  name                    = "default"
  delete_default_routes = true
}

resource "google_compute_subnetwork" "default_asia_east2" {
  name          = "default"
  ip_cidr_range = "10.132.0.0/20"
  network       = "default"
  region        = "asia-east2"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_southeast2" {
  name          = "default"
  ip_cidr_range = "10.134.0.0/20"
  network       = "default"
  region        = "asia-southeast2"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_east5" {
  name          = "default"
  ip_cidr_range = "10.158.0.0/20"
  network       = "default"
  region        = "us-east5"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west8" {
  name          = "default"
  ip_cidr_range = "10.164.0.0/20"
  network       = "default"
  region        = "europe-west8"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west3" {
  name          = "default"
  ip_cidr_range = "10.130.0.0/20"
  network       = "default"
  region        = "europe-west3"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west9" {
  name          = "default"
  ip_cidr_range = "10.166.0.0/20"
  network       = "default"
  region        = "europe-west9"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_me_central1" {
  name          = "default"
  ip_cidr_range = "10.170.0.0/20"
  network       = "default"
  region        = "me-central1"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_south2" {
  name          = "default"
  ip_cidr_range = "10.172.0.0/20"
  network       = "default"
  region        = "asia-south2"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_northeast3" {
  name          = "default"
  ip_cidr_range = "10.174.0.0/20"
  network       = "default"
  region        = "asia-northeast3"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_australia_southeast1" {
  name          = "default"
  ip_cidr_range = "10.128.0.0/20"
  network       = "default"
  region        = "australia-southeast1"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_south1" {
  name          = "default"
  ip_cidr_range = "10.168.0.0/20"
  network       = "default"
  region        = "asia-south1"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_northamerica_south1" {
  name          = "default"
  ip_cidr_range = "10.160.0.0/20"
  network       = "default"
  region        = "northamerica-south1"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_me_west1" {
  name          = "default"
  ip_cidr_range = "10.176.0.0/20"
  network       = "default"
  region        = "me-west1"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_northeast2" {
  name          = "default"
  ip_cidr_range = "10.140.0.0/20"
  network       = "default"
  region        = "asia-northeast2"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west2" {
  name          = "default"
  ip_cidr_range = "10.138.0.0/20"
  network       = "default"
  region        = "europe-west2"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_northeast1" {
  name          = "default"
  ip_cidr_range = "10.136.0.0/20"
  network       = "default"
  region        = "asia-northeast1"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_me_central2" {
  name          = "default"
  ip_cidr_range = "10.178.0.0/20"
  network       = "default"
  region        = "me-central2"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_northamerica_northeast2" {
  name          = "default"
  ip_cidr_range = "10.162.0.0/20"
  network       = "default"
  region        = "northamerica-northeast2"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_southamerica_west1" {
  name          = "default"
  ip_cidr_range = "10.146.0.0/20"
  network       = "default"
  region        = "southamerica-west1"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west6" {
  name          = "default"
  ip_cidr_range = "10.142.0.0/20"
  network       = "default"
  region        = "europe-west6"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_australia_southeast2" {
  name          = "default"
  ip_cidr_range = "10.174.0.0/20"
  network       = "default"
  region        = "australia-southeast2"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west12" {
  name          = "default"
  ip_cidr_range = "10.152.0.0/20"
  network       = "default"
  region        = "europe-west12"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_south1" {
  name          = "default"
  ip_cidr_range = "10.144.0.0/20"
  network       = "default"
  region        = "us-south1"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_central2" {
  name          = "default"
  ip_cidr_range = "10.150.0.0/20"
  network       = "default"
  region        = "europe-central2"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west4" {
  name          = "default"
  ip_cidr_range = "10.156.0.0/20"
  network       = "default"
  region        = "europe-west4"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west10" {
  name          = "default"
  ip_cidr_range = "10.164.0.0/20"
  network       = "default"
  region        = "europe-west10"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_southeast1" {
  name          = "default"
  ip_cidr_range = "10.148.0.0/20"
  network       = "default"
  region        = "asia-southeast1"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_asia_east1" {
  name          = "default"
  ip_cidr_range = "10.130.0.0/20"
  network       = "default"
  region        = "asia-east1"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_west1" {
  name          = "default"
  ip_cidr_range = "10.150.0.0/20"
  network       = "default"
  region        = "us-west1"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_west1" {
  name          = "default"
  ip_cidr_range = "10.130.0.0/20"
  network       = "default"
  region        = "europe-west1"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_northamerica_northeast1" {
  name          = "default"
  ip_cidr_range = "10.152.0.0/20"
  network       = "default"
  region        = "northamerica-northeast1"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_north1" {
  name          = "default"
  ip_cidr_range = "10.148.0.0/20"
  network       = "default"
  region        = "europe-north1"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_southamerica_east1" {
  name          = "default"
  ip_cidr_range = "10.140.0.0/20"
  network       = "default"
  region        = "southamerica-east1"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_west4" {
  name          = "default"
  ip_cidr_range = "10.156.0.0/20"
  network       = "default"
  region        = "us-west4"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_west3" {
  name          = "default"
  ip_cidr_range = "10.154.0.0/20"
  network       = "default"
  region        = "us-west3"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_east4" {
  name          = "default"
  ip_cidr_range = "10.142.0.0/20"
  network       = "default"
  region        = "us-east4"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_central1" {
  name          = "default"
  ip_cidr_range = "10.128.0.0/20"
  network       = "default"
  region        = "us-central1"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_west2" {
  name          = "default"
  ip_cidr_range = "10.152.0.0/20"
  network       = "default"
  region        = "us-west2"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_europe_southwest1" {
  name          = "default"
  ip_cidr_range = "10.174.0.0/20"
  network       = "default"
  region        = "europe-southwest1"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "default_us_east1" {
  name          = "default"
  ip_cidr_range = "10.140.0.0/20"
  network       = "default"
  region        = "us-east1"
    private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_project_service" "containeranalysis" {
  service            = "containeranalysis.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudasset" {
  service            = "cloudasset.googleapis.com"
  disable_on_destroy = false
}

resource "google_storage_bucket" "default_bucket_aviato_game_fight_rvxirf_appspot_com" {
  name                        = "aviato-game-fight-rvxirf.appspot.com"
  location                    = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "default_bucket_aviato_game_fight_rvxirf_bucket" {
  name                        = "aviato-game-fight-rvxirf_bucket"
  location                    = "US"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "default_bucket_staging_aviato_game_fight_rvxirf_appspot_com" {
  name                        = "staging.aviato-game-fight-rvxirf.appspot.com"
  location                    = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}

resource "google_compute_firewall" "default_allow_ssh" {
  name    = "default-allow-ssh"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
 source_ranges = ["130.211.0.0/22", "35.235.0.0/24"]
}

resource "google_compute_firewall" "default_allow_rdp" {
  name    = "default-allow-rdp"
  network = "default"
 allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
 source_ranges = ["130.211.0.0/22", "35.235.0.0/24"]
}

resource "google_logging_project_sink" "default_sink" {
  name = "all-logs-sink"
  destination = "storage.googleapis.com/${google_storage_bucket.default_bucket_aviato_game_fight_rvxirf_appspot_com.name}"
  filter = ""
}

resource "google_logging_metric" "audit_configuration_changes" {
  name = "audit-configuration-changes"
  description = "Metric for tracking audit configuration changes."
  filter = "protoPayload.methodName=\"SetIamPolicy\" OR protoPayload.methodName=\"google.cloud.audit.AuditPolicies.UpdateAuditConfig\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "audit_configuration_changes_alert" {
  display_name = "Audit Configuration Changes Alert"
  combiner = "OR"
 conditions {
    display_name = "Audit Configuration Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/audit-configuration-changes\" resource.type=\"gcp_project\""
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
  name = "bucket-permission-changes"
  description = "Metric for tracking Cloud Storage bucket permission changes."
  filter = "resource.type=\"gcs_bucket\" AND protoPayload.methodName=\"storage.setIamPermissions\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "bucket_permission_changes_alert" {
  display_name = "Cloud Storage Bucket Permission Changes Alert"
  combiner = "OR"
 conditions {
    display_name = "Bucket Permission Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/bucket-permission-changes\" resource.type=\"gcp_project\""
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
  name = "custom-role-changes"
  description = "Metric for tracking custom role changes."
  filter = "resource.type=\"iam_role\" AND (protoPayload.methodName=\"google.iam.admin.v1.CreateRole\" OR protoPayload.methodName=\"google.iam.admin.v1.DeleteRole\" OR protoPayload.methodName=\"google.iam.admin.v1.UpdateRole\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "custom_role_changes_alert" {
  display_name = "Custom Role Changes Alert"
  combiner = "OR"
 conditions {
    display_name = "Custom Role Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/custom-role-changes\" resource.type=\"gcp_project\""
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
  name = "project-ownership-changes"
  description = "Metric for tracking project ownership changes."
  filter = "protoPayload.serviceName=\"cloudresourcemanager.googleapis.com\" AND protoPayload.methodName=\"SetIamPolicy\" AND resource.type=\"project\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "project_ownership_changes_alert" {
  display_name = "Project Ownership Changes Alert"
  combiner = "OR"
 conditions {
    display_name = "Project Ownership Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/project-ownership-changes\" resource.type=\"gcp_project\""
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
  name = "sql-instance-configuration-changes"
  description = "Metric for tracking SQL instance configuration changes."
  filter = "resource.type=\"cloudsql_database_instance\" AND protoPayload.methodName=\"cloudsql.instances.update\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "sql_instance_configuration_changes_alert" {
  display_name = "SQL Instance Configuration Changes Alert"
  combiner = "OR"
 conditions {
    display_name = "SQL Instance Configuration Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/sql-instance-configuration-changes\" resource.type=\"gcp_project\""
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
  name = "vpc-firewall-rule-changes"
  description = "Metric for tracking VPC network firewall rule changes."
  filter = "resource.type=\"gcp_firewall_rule\" AND (protoPayload.methodName=\"compute.firewalls.insert\" OR protoPayload.methodName=\"compute.firewalls.patch\" OR protoPayload.methodName=\"compute.firewalls.update\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "vpc_firewall_rule_changes_alert" {
  display_name = "VPC Network Firewall Rule Changes Alert"
  combiner = "OR"
 conditions {
    display_name = "VPC Firewall Rule Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-firewall-rule-changes\" resource.type=\"gcp_project\""
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
  name = "vpc-network-changes"
  description = "Metric for tracking VPC network changes."
  filter = "resource.type=\"gcp_vpc_network\" AND (protoPayload.methodName=\"compute.networks.insert\" OR protoPayload.methodName=\"compute.networks.patch\" OR protoPayload.methodName=\"compute.networks.update\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_changes_alert" {
  display_name = "VPC Network Changes Alert"
  combiner = "OR"
 conditions {
    display_name = "VPC Network Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-network-changes\" resource.type=\"gcp_project\""
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
  name = "vpc-network-route-changes"
  description = "Metric for tracking VPC network route changes."
  filter = "resource.type=\"gcp_route\" AND (protoPayload.methodName=\"compute.routes.insert\" OR protoPayload.methodName=\"compute.routes.delete\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_route_changes_alert" {
  display_name = "VPC Network Route Changes Alert"
  combiner = "OR"
 conditions {
    display_name = "VPC Network Route Changes Condition"
    condition_threshold {
      filter          =
