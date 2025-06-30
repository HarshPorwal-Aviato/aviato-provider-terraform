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

resource "google_project_service" "artifactanalysis" {
  service            = "containeranalysis.googleapis.com"
  disable_on_destroy = false
}

resource "google_storage_bucket" "default_bucket_level_access_aviato_game_fight_rvxirf" {
  name                        = "aviato-game-fight-rvxirf.appspot.com"
  location                    = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "default_bucket_level_access_aviato_game_fight_rvxirf_bucket" {
  name                        = "aviato-game-fight-rvxirf_bucket"
  location                    = "US"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "default_bucket_level_access_staging_aviato_game_fight_rvxirf" {
  name                        = "staging.aviato-game-fight-rvxirf.appspot.com"
  location                    = "AUSTRALIA-SOUTHEAST1"
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


  source_ranges = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}

resource "google_compute_firewall" "rdp" {
  name    = "default-allow-rdp"
  network = "default"
  project = "aviato-game-fight-rvxirf"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}

resource "google_compute_network" "default" {
  name                    = "default"
  auto_create_subnetworks = "false"
  delete_default_routes   = true
}

resource "google_compute_network" "default_dns_logging" {
  name                    = "default"
  project                 = "aviato-game-fight-rvxirf"
  delete_default_routes   = false
  auto_create_subnetworks = true
  enable_logging          = true
}

resource "google_project_metadata" "project" {
  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_compute_subnet" "default_asia_northeast2" {
  name          = "default"
  ip_cidr_range = "10.146.0.0/20"
  network       = "default"
  region        = "asia-northeast2"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_west12" {
  name          = "default"
  ip_cidr_range = "10.156.0.0/20"
  network       = "default"
  region        = "europe-west12"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_asia_south2" {
  name          = "default"
  ip_cidr_range = "10.154.0.0/20"
  network       = "default"
  region        = "asia-south2"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_west4" {
  name          = "default"
  ip_cidr_range = "10.132.0.0/20"
  network       = "default"
  region        = "europe-west4"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_us_south1" {
  name          = "default"
  ip_cidr_range = "10.158.0.0/20"
  network       = "default"
  region        = "us-south1"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_australia_southeast2" {
  name          = "default"
  ip_cidr_range = "10.160.0.0/20"
  network       = "default"
  region        = "australia-southeast2"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_me_central1" {
  name          = "default"
  ip_cidr_range = "10.162.0.0/20"
  network       = "default"
  region        = "me-central1"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_us_east1" {
  name          = "default"
  ip_cidr_range = "10.128.0.0/20"
  network       = "default"
  region        = "us-east1"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_us_west1" {
  name          = "default"
  ip_cidr_range = "10.138.0.0/20"
  network       = "default"
  region        = "us-west1"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_west2" {
  name          = "default"
  ip_cidr_range = "10.130.0.0/20"
  network       = "default"
  region        = "europe-west2"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_us_west4" {
  name          = "default"
  ip_cidr_range = "10.140.0.0/20"
  network       = "default"
  region        = "us-west4"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_us_west2" {
  name          = "default"
  ip_cidr_range = "10.142.0.0/20"
  network       = "default"
  region        = "us-west2"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_west8" {
  name          = "default"
  ip_cidr_range = "10.164.0.0/20"
  network       = "default"
  region        = "europe-west8"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_southamerica_west1" {
  name          = "default"
  ip_cidr_range = "10.166.0.0/20"
  network       = "default"
  region        = "southamerica-west1"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_west9" {
  name          = "default"
  ip_cidr_range = "10.168.0.0/20"
  network       = "default"
  region        = "europe-west9"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_northamerica_northeast1" {
  name          = "default"
  ip_cidr_range = "10.150.0.0/20"
  network       = "default"
  region        = "northamerica-northeast1"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_asia_east1" {
  name          = "default"
  ip_cidr_range = "10.140.0.0/20"
  network       = "default"
  region        = "asia-east1"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_asia_northeast3" {
  name          = "default"
  ip_cidr_range = "10.170.0.0/20"
  network       = "default"
  region        = "asia-northeast3"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_west10" {
  name          = "default"
  ip_cidr_range = "10.172.0.0/20"
  network       = "default"
  region        = "europe-west10"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_north2" {
  name          = "default"
  ip_cidr_range = "10.174.0.0/20"
  network       = "default"
  region        = "europe-north2"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_asia_northeast1" {
  name          = "default"
  ip_cidr_range = "10.130.0.0/20"
  network       = "default"
  region        = "asia-northeast1"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_us_east5" {
  name          = "default"
  ip_cidr_range = "10.176.0.0/20"
  network       = "default"
  region        = "us-east5"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_northamerica_northeast2" {
  name          = "default"
  ip_cidr_range = "10.178.0.0/20"
  network       = "default"
  region        = "northamerica-northeast2"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_asia_southeast2" {
  name          = "default"
  ip_cidr_range = "10.180.0.0/20"
  network       = "default"
  region        = "asia-southeast2"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_asia_east2" {
  name          = "default"
  ip_cidr_range = "10.182.0.0/20"
  network       = "default"
  region        = "asia-east2"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_asia_southeast1" {
  name          = "default"
  ip_cidr_range = "10.128.0.0/20"
  network       = "default"
  region        = "asia-southeast1"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_asia_south1" {
  name          = "default"
  ip_cidr_range = "10.152.0.0/20"
  network       = "default"
  region        = "asia-south1"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_west3" {
  name          = "default"
  ip_cidr_range = "10.152.0.0/20"
  network       = "default"
  region        = "europe-west3"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_australia_southeast1" {
  name          = "default"
  ip_cidr_range = "10.132.0.0/20"
  network       = "default"
  region        = "australia-southeast1"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_us_east4" {
  name          = "default"
  ip_cidr_range = "10.156.0.0/20"
  network       = "default"
  region        = "us-east4"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_north1" {
  name          = "default"
  ip_cidr_range = "10.152.0.0/20"
  network       = "default"
  region        = "europe-north1"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_southwest1" {
  name          = "default"
  ip_cidr_range = "10.144.0.0/20"
  network       = "default"
  region        = "europe-southwest1"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_west1" {
  name          = "default"
  ip_cidr_range = "10.132.0.0/20"
  network       = "default"
  region        = "europe-west1"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_us_central1" {
  name          = "default"
  ip_cidr_range = "10.128.0.0/20"
  network       = "default"
  region        = "us-central1"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_west6" {
  name          = "default"
  ip_cidr_range = "10.136.0.0/20"
  network       = "default"
  region        = "europe-west6"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_me_central2" {
  name          = "default"
  ip_cidr_range = "10.184.0.0/20"
  network       = "default"
  region        = "me-central2"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_me_west1" {
  name          = "default"
  ip_cidr_range = "10.186.0.0/20"
  network       = "default"
  region        = "me-west1"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_central2" {
  name          = "default"
  ip_cidr_range = "10.188.0.0/20"
  network       = "default"
  region        = "europe-central2"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_southamerica_east1" {
  name          = "default"
  ip_cidr_range = "10.152.0.0/20"
  network       = "default"
  region        = "southamerica-east1"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_africa_south1" {
  name          = "default"
  ip_cidr_range = "10.156.0.0/20"
  network       = "default"
  region        = "africa-south1"
  project       = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_project_service" "cloudasset" {
  service            = "cloudasset.googleapis.com"
  disable_on_destroy = false
}

resource "google_logging_project_sink" "default" {
  name           = "all-logs"
  destination    = "bigquery.googleapis.com/projects/${var.project_id}/datasets/${var.dataset_id}"
  filter         = "NOT logName:projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Fdata_access"
  project        = var.project_id

  bigquery_options {
    use_partitioned_tables = true
  }
}

resource "google_monitoring_alert_policy" "audit_config_changes" {
  display_name = "Audit Configuration Changes"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Log Metric Filter - Audit Configuration Changes"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/audit_config_changes\" AND resource.type=\"gcp_project\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
    }
  }
  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }
  notification_channels = [var.notification_channel_id]
}

resource "google_logging_metric" "audit_config_changes" {
  name        = "audit_config_changes"
  project     = var.project_id
  description = "This metric counts the number of Audit Configuration changes"
  filter      = "resource.type=gcp_project AND protoPayload.methodName=\"SetIamPolicy\" AND protoPayload.serviceName=\"cloudresourcemanager.googleapis.com\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_monitoring_alert_policy" "bucket_permission_changes" {
  display_name = "Cloud Storage Bucket IAM Permission Changes"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Log Metric Filter - Cloud Storage Bucket IAM Permission Changes"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/bucket_permission_changes\" AND resource.type=\"gcs_bucket\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
    }
  }
  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }
  notification_channels = [var.notification_channel_id]
}

resource "google_logging_metric" "bucket_permission_changes" {
  name        = "bucket_permission_changes"
  project     = var.project_id
  description = "This metric counts the number of Cloud Storage Bucket IAM permission changes"
  filter      = "resource.type=gcs_bucket AND protoPayload.methodName=\"storage.setIamPolicy\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_monitoring_alert_policy" "custom_role_changes" {
  display_name = "Custom Role Changes"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Log Metric Filter - Custom Role Changes"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/custom_role_changes\" AND resource.type=\"gcp_project\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
    }
  }
  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }
  notification_channels = [var.notification_channel_id]
}

resource "google_logging_metric" "custom_role_changes" {
  name        = "custom_role_changes"
  project     = var.project_id
  description = "This metric counts the number of Custom Role changes"
  filter      = "resource.type=gcp_project AND protoPayload.methodName=[\"google.iam.admin.v1.CreateRole\",\"google.iam.admin.v1.DeleteRole\",\"google.iam.admin.v1.UpdateRole\"] AND protoPayload.serviceName=\"iam.googleapis.com\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_monitoring_alert_policy" "project_ownership_changes" {
  display_name = "Project Ownership Changes"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Log Metric Filter - Project Ownership Changes"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/project_ownership_changes\" AND resource.type=\"gcp_project\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
    }
  }
  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }
  notification_channels = [var.notification_channel_id]
}

resource "google_logging_metric" "project_ownership_changes" {
  name        = "project_ownership_changes"
  project     = var.project_id
  description = "This metric counts the number of Project Ownership changes"
  filter      = "resource.type=gcp_project AND protoPayload.methodName=\"SetIamPolicy\" AND protoPayload.authenticationInfo.principalEmail:\"accounts.google.com\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_monitoring_alert_policy" "sql_instance_config_changes" {
  display_name = "SQL Instance Configuration Changes"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Log Metric Filter - SQL Instance Configuration Changes"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/sql_instance_config_changes\" AND resource.type=\"cloudsql_database\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
    }
  }
  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }
  notification_channels = [var.notification_channel_id]
}

resource "google_logging_metric" "sql_instance_config_changes" {
  name        = "sql_instance_config_changes"
  project     = var.project_id
  description = "This metric counts the number of SQL Instance Configuration changes"
  filter      = "resource.type=cloudsql_database AND protoPayload.methodName=[\"cloudsql.instances.update\",\"cloudsql.instances.patch\"]"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_monitoring_alert_policy" "vpc_firewall_rule_changes" {
  display_name = "VPC Network Firewall Rule Changes"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Log Metric Filter - VPC Network Firewall Rule Changes"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc_firewall_rule_changes\" AND resource.type=\"gcp_project\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
    }
  }
  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }
  notification_channels = [var.notification_channel_id]
}

resource "google_logging_metric" "vpc_firewall_rule_changes" {
  name        = "vpc_firewall_rule_changes"
  project     = var.project_id
  description = "This metric counts the number of VPC Network Firewall rule changes"
  filter      = "resource.type=gcp_project AND protoPayload.methodName=[\"compute.firewalls.insert\",\"compute.firewalls.patch\",\"compute.firewalls.delete\"] AND protoPayload.serviceName=\"compute.googleapis.com\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_changes" {
  display_name = "VPC Network Changes"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Log Metric Filter - VPC Network Changes"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc_network_changes\" AND resource.type=\"gcp_project\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
    }
  }
  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }
  notification_channels = [var.notification_channel_id]
}

resource "google_logging_metric" "vpc_network_changes" {
  name        = "vpc_network_changes"
  project     = var.project_id
  description = "This metric counts the number of VPC Network changes"
  filter      = "resource.type=gcp_project AND protoPayload.methodName=[\"compute.networks.insert\",\"compute.networks.patch\",\"compute.networks.delete\"] AND protoPayload.serviceName=\"compute.googleapis.com\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_route_changes" {
  display_name = "VPC Network Route Changes"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Log Metric Filter - VPC Network Route Changes"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc_network_route_changes\" AND resource.type=\"gcp_project\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
    }
  }
  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }
  notification_channels = [var.notification_channel_id]
}

resource "google_logging_metric" "vpc_network_route_changes" {
  name        = "vpc_network_route_changes"
  project     = var.project_id
  description = "This metric counts the number of VPC Network route changes"
  filter      = "resource.type=gcp_project AND protoPayload.methodName=[\"compute.routes.insert\",\"compute.routes.patch\",\"compute.routes.delete\"] AND protoPayload.serviceName=\"compute.googleapis.com\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

variable "project_id" {
  type = string
  default = "aviato-game-fight-rvxirf"
}

variable "dataset_id" {
  type = string
  default = "logging_dataset"
}

variable "notification_channel_id" {
  type = string
  default = ""
}

