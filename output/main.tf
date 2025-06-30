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

resource "google_storage_bucket" "default_bucket_uba" {
  name          = "aviato-game-fight-rvxirf.appspot.com"
  location      = "AUSTRALIA-SOUTHEAST1"
  force_destroy = false
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "bucket_uba" {
  name          = "aviato-game-fight-rvxirf_bucket"
  location      = "US"
  force_destroy = false
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "staging_bucket_uba" {
  name          = "staging.aviato-game-fight-rvxirf.appspot.com"
  location      = "AUSTRALIA-SOUTHEAST1"
  force_destroy = false
  uniform_bucket_level_access = true
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "default-allow-ssh"
  network = "default"
  project = "aviato-game-fight-rvxirf"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["130.211.0.0/22", "35.235.0.0/24"]
}

resource "google_compute_firewall" "allow_rdp" {
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
  delete_default_routes = true
}

resource "google_project_metadata" "enable_oslogin" {
  metadata = {
    enable-oslogin = "TRUE"
  }
  project = "aviato-game-fight-rvxirf"
}

resource "google_compute_subnet" "default_asia_northeast2" {
  name          = "default"
  ip_cidr_range = "10.132.0.0/20"
  network       = "default"
  region        = "asia-northeast2"
  project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_west12" {
  name          = "default"
  ip_cidr_range = "10.164.0.0/20"
  network       = "default"
  region        = "europe-west12"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_asia_south2" {
  name          = "default"
  ip_cidr_range = "10.158.0.0/20"
  network       = "default"
  region        = "asia-south2"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_west4" {
  name          = "default"
  ip_cidr_range = "10.156.0.0/20"
  network       = "default"
  region        = "europe-west4"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_us_south1" {
  name          = "default"
  ip_cidr_range = "10.162.0.0/20"
  network       = "default"
  region        = "us-south1"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_australia_southeast2" {
  name          = "default"
  ip_cidr_range = "10.168.0.0/20"
  network       = "default"
  region        = "australia-southeast2"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_me_central1" {
  name          = "default"
  ip_cidr_range = "10.166.0.0/20"
  network       = "default"
  region        = "me-central1"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_us_east1" {
  name          = "default"
  ip_cidr_range = "10.128.0.0/20"
  network       = "default"
  region        = "us-east1"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_us_west1" {
  name          = "default"
  ip_cidr_range = "10.130.0.0/20"
  network       = "default"
  region        = "us-west1"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_west2" {
  name          = "default"
  ip_cidr_range = "10.138.0.0/20"
  network       = "default"
  region        = "europe-west2"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_us_west4" {
  name          = "default"
  ip_cidr_range = "10.160.0.0/20"
  network       = "default"
  region        = "us-west4"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_west8" {
  name          = "default"
  ip_cidr_range = "10.154.0.0/20"
  network       = "default"
  region        = "europe-west8"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_southamerica_west1" {
  name          = "default"
  ip_cidr_range = "10.152.0.0/20"
  network       = "default"
  region        = "southamerica-west1"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_west9" {
  name          = "default"
  ip_cidr_range = "10.170.0.0/20"
  network       = "default"
  region        = "europe-west9"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_northamerica_northeast1" {
  name          = "default"
  ip_cidr_range = "10.172.0.0/20"
  network       = "default"
  region        = "northamerica-northeast1"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_asia_east1" {
  name          = "default"
  ip_cidr_range = "10.140.0.0/20"
  network       = "default"
  region        = "asia-east1"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_asia_northeast3" {
  name          = "default"
  ip_cidr_range = "10.142.0.0/20"
  network       = "default"
  region        = "asia-northeast3"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_west10" {
  name          = "default"
  ip_cidr_range = "10.150.0.0/20"
  network       = "default"
  region        = "europe-west10"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_north2" {
  name          = "default"
  ip_cidr_range = "10.148.0.0/20"
  network       = "default"
  region        = "europe-north2"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_asia_northeast1" {
  name          = "default"
  ip_cidr_range = "10.134.0.0/20"
  network       = "default"
  region        = "asia-northeast1"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_us_east5" {
  name          = "default"
  ip_cidr_range = "10.136.0.0/20"
  network       = "default"
  region        = "us-east5"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_northamerica_northeast2" {
  name          = "default"
  ip_cidr_range = "10.146.0.0/20"
  network       = "default"
  region        = "northamerica-northeast2"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_asia_southeast2" {
  name          = "default"
  ip_cidr_range = "10.144.0.0/20"
  network       = "default"
  region        = "asia-southeast2"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_asia_east2" {
  name          = "default"
  ip_cidr_range = "10.174.0.0/20"
  network       = "default"
  region        = "asia-east2"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_asia_southeast1" {
  name          = "default"
  ip_cidr_range = "10.132.0.0/20"
  network       = "default"
  region        = "asia-southeast1"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_asia_south1" {
  name          = "default"
  ip_cidr_range = "10.176.0.0/20"
  network       = "default"
  region        = "asia-south1"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_west3" {
  name          = "default"
  ip_cidr_range = "10.144.0.0/20"
  network       = "default"
  region        = "europe-west3"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_australia_southeast1" {
  name          = "default"
  ip_cidr_range = "10.138.0.0/20"
  network       = "default"
  region        = "australia-southeast1"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_us_east4" {
  name          = "default"
  ip_cidr_range = "10.154.0.0/20"
  network       = "default"
  region        = "us-east4"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_north1" {
  name          = "default"
  ip_cidr_range = "10.160.0.0/20"
  network       = "default"
  region        = "europe-north1"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_southwest1" {
  name          = "default"
  ip_cidr_range = "10.156.0.0/20"
  network       = "default"
  region        = "europe-southwest1"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_west1" {
  name          = "default"
  ip_cidr_range = "10.132.0.0/20"
  network       = "default"
  region        = "europe-west1"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_us_west3" {
  name          = "default"
  ip_cidr_range = "10.148.0.0/20"
  network       = "default"
  region        = "us-west3"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_northamerica_south1" {
  name          = "default"
  ip_cidr_range = "10.140.0.0/20"
  network       = "default"
  region        = "northamerica-south1"
  project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_us_central1" {
  name          = "default"
  ip_cidr_range = "10.128.0.0/20"
  network       = "default"
  region        = "us-central1"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_west6" {
  name          = "default"
  ip_cidr_range = "10.146.0.0/20"
  network       = "default"
  region        = "europe-west6"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_me_central2" {
  name          = "default"
  ip_cidr_range = "10.164.0.0/20"
  network       = "default"
  region        = "me-central2"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_me_west1" {
  name          = "default"
  ip_cidr_range = "10.162.0.0/20"
  network       = "default"
  region        = "me-west1"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_europe_central2" {
  name          = "default"
  ip_cidr_range = "10.168.0.0/20"
  network       = "default"
  region        = "europe-central2"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_southamerica_east1" {
  name          = "default"
  ip_cidr_range = "10.158.0.0/20"
  network       = "default"
  region        = "southamerica-east1"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_compute_subnet" "default_africa_south1" {
  name          = "default"
  ip_cidr_range = "10.170.0.0/20"
  network       = "default"
  region        = "africa-south1"
    project     = "aviato-game-fight-rvxirf"
  enable_flow_logs = true
}

resource "google_project_service" "cloudasset" {
  service            = "cloudasset.googleapis.com"
  disable_on_destroy = false
}
resource "google_logging_metric" "audit_config_changes" {
  name        = "audit-configuration-changes"
  project     = "aviato-game-fight-rvxirf"
  description = "Log metric for audit configuration changes"
  filter      = "resource.type=audited_resource AND protoPayload.methodName=SetIamPolicy AND (resource.labels.project_id=\"aviato-game-fight-rvxirf\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "audit_config_changes_alert" {
  display_name = "Alert for audit configuration changes"
  project      = "aviato-game-fight-rvxirf"
  combiner     = "OR"
  conditions {
    display_name = "Audit configuration changes condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/audit-configuration-changes\" resource.labels.project_id=\"aviato-game-fight-rvxirf\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
      trigger {
        count = 1
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "bucket_permission_changes" {
  name        = "bucket-permission-changes"
  project     = "aviato-game-fight-rvxirf"
  description = "Log metric for Cloud Storage IAM Permission Changes"
  filter      = "resource.type=gcs_bucket AND protoPayload.methodName=storage.setIamPermissions AND (resource.labels.project_id=\"aviato-game-fight-rvxirf\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "bucket_permission_changes_alert" {
  display_name = "Alert for Cloud Storage IAM Permission Changes"
  project      = "aviato-game-fight-rvxirf"
  combiner     = "OR"
  conditions {
    display_name = "Bucket Permission Changes condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/bucket-permission-changes\" resource.labels.project_id=\"aviato-game-fight-rvxirf\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
      trigger {
        count = 1
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "custom_role_changes" {
  name        = "custom-role-changes"
  project     = "aviato-game-fight-rvxirf"
  description = "Log metric for Custom Role Changes"
  filter      = "resource.type=iam_role AND (protoPayload.methodName=\"google.iam.admin.v1.CreateRole\" OR protoPayload.methodName=\"google.iam.admin.v1.DeleteRole\" OR protoPayload.methodName=\"google.iam.admin.v1.UpdateRole\") AND (resource.labels.project_id=\"aviato-game-fight-rvxirf\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "custom_role_changes_alert" {
  display_name = "Alert for Custom Role Changes"
  project      = "aviato-game-fight-rvxirf"
  combiner     = "OR"
  conditions {
    display_name = "Custom Role Changes condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/custom-role-changes\" resource.labels.project_id=\"aviato-game-fight-rvxirf\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
      trigger {
        count = 1
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "project_ownership_changes" {
  name        = "project-ownership-changes"
  project     = "aviato-game-fight-rvxirf"
  description = "Log metric for Project Ownership Assignments/Changes"
  filter      = "resource.type=project AND protoPayload.serviceName=\"cloudresourcemanager.googleapis.com\" AND protoPayload.methodName=\"SetIamPolicy\" AND (resource.labels.project_id=\"aviato-game-fight-rvxirf\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "project_ownership_changes_alert" {
  display_name = "Alert for Project Ownership Assignments/Changes"
  project      = "aviato-game-fight-rvxirf"
  combiner     = "OR"
  conditions {
    display_name = "Project Ownership Changes condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/project-ownership-changes\" resource.labels.project_id=\"aviato-game-fight-rvxirf\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
      trigger {
        count = 1
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "sql_instance_configuration_changes" {
  name        = "sql-instance-configuration-changes"
  project     = "aviato-game-fight-rvxirf"
  description = "Log metric for SQL Instance Configuration Changes"
  filter      = "resource.type=cloudsql_instance AND protoPayload.serviceName=\"sqladmin.googleapis.com\" AND (protoPayload.methodName=\"cloudsql.instances.update\" OR protoPayload.methodName=\"cloudsql.instances.patch\") AND (resource.labels.project_id=\"aviato-game-fight-rvxirf\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "sql_instance_configuration_changes_alert" {
  display_name = "Alert for SQL Instance Configuration Changes"
  project      = "aviato-game-fight-rvxirf"
  combiner     = "OR"
  conditions {
    display_name = "SQL Instance Configuration Changes condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/sql-instance-configuration-changes\" resource.labels.project_id=\"aviato-game-fight-rvxirf\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
      trigger {
        count = 1
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "vpc_firewall_rule_changes" {
  name        = "vpc-firewall-rule-changes"
  project     = "aviato-game-fight-rvxirf"
  description = "Log metric for VPC Network Firewall Rule Changes"
  filter      = "resource.type=gce_firewall_rule AND protoPayload.serviceName=\"compute.googleapis.com\" AND (protoPayload.methodName=\"compute.firewalls.insert\" OR protoPayload.methodName=\"compute.firewalls.delete\" OR protoPayload.methodName=\"compute.firewalls.patch\" OR protoPayload.methodName=\"compute.firewalls.update\") AND (resource.labels.project_id=\"aviato-game-fight-rvxirf\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "vpc_firewall_rule_changes_alert" {
  display_name = "Alert for VPC Network Firewall Rule Changes"
  project      = "aviato-game-fight-rvxirf"
  combiner     = "OR"
  conditions {
    display_name = "VPC Network Firewall Rule Changes condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-firewall-rule-changes\" resource.labels.project_id=\"aviato-game-fight-rvxirf\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
      trigger {
        count = 1
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "vpc_network_changes" {
  name        = "vpc-network-changes"
  project     = "aviato-game-fight-rvxirf"
  description = "Log metric for VPC Network Changes"
  filter      = "resource.type=gce_network AND protoPayload.serviceName=\"compute.googleapis.com\" AND (protoPayload.methodName=\"compute.networks.insert\" OR protoPayload.methodName=\"compute.networks.delete\" OR protoPayload.methodName=\"compute.networks.patch\" OR protoPayload.methodName=\"compute.networks.update\") AND (resource.labels.project_id=\"aviato-game-fight-rvxirf\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_changes_alert" {
  display_name = "Alert for VPC Network Changes"
  project      = "aviato-game-fight-rvxirf"
  combiner     = "OR"
  conditions {
    display_name = "VPC Network Changes condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-network-changes\" resource.labels.project_id=\"aviato-game-fight-rvxirf\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
      trigger {
        count = 1
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "vpc_network_route_changes" {
  name        = "vpc-network-route-changes"
  project     = "aviato-game-fight-rvxirf"
  description = "Log metric for VPC Network Route Changes"
  filter      = "resource.type=gce_route AND protoPayload.serviceName=\"compute.googleapis.com\" AND (protoPayload.methodName=\"compute.routes.insert\" OR protoPayload.methodName=\"compute.routes.delete\") AND (resource.labels.project_id=\"aviato-game-fight-rvxirf\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_route_changes_alert" {
  display_name = "Alert for VPC Network Route Changes"
  project      = "aviato-game-fight-rvxirf"
  combiner     = "OR"
  conditions {
    display_name = "VPC Network Route Changes condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-network-route-changes\" resource.labels.project_id=\"aviato-game-fight-rvxirf\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
      trigger {
        count = 1
      }
    }
  }
  notification_channels = []
}

resource "google_logging_project_sink" "all_logs_sink" {
  name        = "all-logs-sink"
  project     = "aviato-game-fight-rvxirf"
  description = "Sink for all logs in the project"
  destination = "storage.googleapis.com/${google_storage_bucket.bucket_uba.name}"
  filter      = "NOT logName:(\"projects/${"project"}/logs/cloudaudit.googleapis.com%2Factivity\")"
}
