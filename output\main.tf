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

resource "google_project_service_identity" "artifactregistry" {
  provider = google
  project  = var.project_id
  service  = "artifactregistry.googleapis.com"
}


resource "google_project_iam_member" "artifactregistry_container_analysis" {
  provider = google
  project  = var.project_id
  role   = "roles/containeranalysis.occurrences.occurrenceservices"
  member = "serviceAccount:${google_project_service_identity.artifactregistry.email}"
}


resource "google_artifact_registry_repository" "default" {
  provider = google
  project  = var.project_id
  location = "us"
  repository_id = "my-repo"
  format = "DOCKER"
}

resource "google_storage_bucket" "default" {
  provider = google
  name          = "${var.project_id}.appspot.com"
  location      = "AUSTRALIA-SOUTHEAST1"
  force_destroy = false
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "default_us" {
  provider = google
  name          = "${var.project_id}_bucket"
  location      = "US"
  force_destroy = false
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "staging" {
  provider = google
  name          = "staging.${var.project_id}.appspot.com"
  location      = "AUSTRALIA-SOUTHEAST1"
  force_destroy = false
   uniform_bucket_level_access = true
}

resource "google_compute_firewall" "rdp" {
  provider = google
  name    = "default-allow-rdp"
  network = "default"
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["10.10.0.0/16"]
}

resource "google_compute_firewall" "ssh" {
  provider = google
  name    = "default-allow-ssh"
  network = "default"
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["10.10.0.0/16"]
}

resource "google_compute_network" "default" {
  provider = google
  name                    = "default"
  project                 = var.project_id
  auto_create_subnetworks = "false"
  delete_default_routes = true
}

resource "google_compute_network" "custom_network" {
  provider = google
  name                    = "vpc-network"
  project                 = var.project_id
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet_example" {
  provider = google
  name          = "subnet-example"
  ip_cidr_range = "10.10.0.0/16"
  network       = google_compute_network.custom_network.id
  region        = "us-central1"
  project     = var.project_id
}

resource "google_compute_network_dns_logging_policy" "default" {
  provider = google
  network = "default"
  logging_config {
    enable_logging = true
  }
  project = var.project_id
}

resource "google_compute_project_metadata" "default" {
  provider = google
  project = var.project_id
  metadata = {
    enable-oslogin = "true"
  }
}

resource "google_container_registry" "default" {
  provider = google
  project = var.project_id
  location = "US"
}

resource "google_project_service" "container_analysis" {
  provider = google
  project = var.project_id
  service            = "containeranalysis.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudasset" {
  provider = google
  project = var.project_id
  service            = "cloudasset.googleapis.com"
  disable_on_destroy = false
}

resource "google_logging_project_sink" "default" {
  provider = google
  name        = "all-logs"
  project     = var.project_id
  description = "Copies of all log entries."
  destination = "storage.googleapis.com/${var.project_id}-all-logs"

  filter = "NOT logName:projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity"

  unique_writer_identity = true
}


resource "google_storage_bucket" "logging_bucket" {
  provider = google
  name          = "${var.project_id}-all-logs"
  location      = "US"
  force_destroy = true
  uniform_bucket_level_access = true
}

resource "google_project_iam_binding" "logging_writer" {
  provider = google
  project = var.project_id
  role = "roles/storage.objectCreator"
  members = ["serviceAccount:${google_logging_project_sink.default.writer_identity}"]
}

resource "google_logging_metric" "audit_configuration_changes" {
  provider = google
  name   = "audit-configuration-changes"
  project = var.project_id
  description = "Alert on Audit Configuration Changes"
  filter = "logName:cloudaudit.googleapis.com%2Factivity AND protoPayload.methodName:SetIamPolicy OR protoPayload.methodName:InsertRole OR protoPayload.methodName:UpdateRole OR protoPayload.methodName:DeleteRole"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
    unit = "1"
  }
}

resource "google_monitoring_alert_policy" "audit_configuration_changes" {
  provider = google
  display_name = "Audit Configuration Changes Alert"
  project = var.project_id
  combiner = "OR"
  conditions {
    display_name = "Metric Threshold"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/user/audit-configuration-changes\" resource.type=\"gcp_project\""
      comparison = "COMPARISON_GT"
      threshold_value = 0
      duration = "60s"
      trigger {
        count = 1
      }
    }
  }
  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }
}

resource "google_logging_metric" "bucket_permission_changes" {
  provider = google
  name   = "bucket-permission-changes"
  project = var.project_id
  description = "Alert on Cloud Storage IAM Permission Changes"
  filter = "resource.type=gcs_bucket AND logName:cloudaudit.googleapis.com%2Factivity AND protoPayload.methodName=storage.setIamPermissions"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
    unit = "1"
  }
}

resource "google_monitoring_alert_policy" "bucket_permission_changes" {
  provider = google
  display_name = "Cloud Storage IAM Permission Changes Alert"
  project = var.project_id
  combiner = "OR"
  conditions {
    display_name = "Metric Threshold"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/user/bucket-permission-changes\" resource.type=\"gcp_project\""
      comparison = "COMPARISON_GT"
      threshold_value = 0
      duration = "60s"
      trigger {
        count = 1
      }
    }
  }
  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }
}

resource "google_logging_metric" "custom_role_changes" {
  provider = google
  name   = "custom-role-changes"
  project = var.project_id
  description = "Alert on Custom Role Changes"
  filter = "logName:cloudaudit.googleapis.com%2Factivity AND protoPayload.methodName:CreateRole OR protoPayload.methodName:DeleteRole OR protoPayload.methodName:UpdateRole"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
    unit = "1"
  }
}

resource "google_monitoring_alert_policy" "custom_role_changes" {
  provider = google
  display_name = "Custom Role Changes Alert"
  project = var.project_id
  combiner = "OR"
  conditions {
    display_name = "Metric Threshold"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/user/custom-role-changes\" resource.type=\"gcp_project\""
      comparison = "COMPARISON_GT"
      threshold_value = 0
      duration = "60s"
      trigger {
        count = 1
      }
    }
  }
  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }
}

resource "google_logging_metric" "project_ownership_changes" {
  provider = google
  name   = "project-ownership-changes"
  project = var.project_id
  description = "Alert on Project Ownership Assignments/Changes"
  filter = "logName:cloudaudit.googleapis.com%2Factivity AND protoPayload.methodName:SetIamPolicy AND resource.type:project"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
    unit = "1"
  }
}

resource "google_monitoring_alert_policy" "project_ownership_changes" {
  provider = google
  display_name = "Project Ownership Changes Alert"
  project = var.project_id
  combiner = "OR"
  conditions {
    display_name = "Metric Threshold"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/user/project-ownership-changes\" resource.type=\"gcp_project\""
      comparison = "COMPARISON_GT"
      threshold_value = 0
      duration = "60s"
      trigger {
        count = 1
      }
    }
  }
  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }
}

resource "google_logging_metric" "sql_instance_configuration_changes" {
  provider = google
  name   = "sql-instance-configuration-changes"
  project = var.project_id
  description = "Alert on SQL Instance Configuration Changes"
  filter = "resource.type=cloudsql_database AND logName:cloudaudit.googleapis.com%2Factivity AND protoPayload.methodName:cloudsql.instances.update"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
    unit = "1"
  }
}

resource "google_monitoring_alert_policy" "sql_instance_configuration_changes" {
  provider = google
  display_name = "SQL Instance Configuration Changes Alert"
  project = var.project_id
  combiner = "OR"
  conditions {
    display_name = "Metric Threshold"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/user/sql-instance-configuration-changes\" resource.type=\"gcp_project\""
      comparison = "COMPARISON_GT"
      threshold_value = 0
      duration = "60s"
      trigger {
        count = 1
      }
    }
  }
  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }
}

resource "google_logging_metric" "vpc_firewall_rule_changes" {
  provider = google
  name   = "vpc-firewall-rule-changes"
  project = var.project_id
  description = "Alert on VPC Network Firewall Rule Changes"
  filter = "resource.type=gcp_firewall_rule AND logName:cloudaudit.googleapis.com%2Factivity AND protoPayload.methodName:compute.firewalls.insert"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
    unit = "1"
  }
}

resource "google_monitoring_alert_policy" "vpc_firewall_rule_changes" {
  provider = google
  display_name = "VPC Network Firewall Rule Changes Alert"
  project = var.project_id
  combiner = "OR"
  conditions {
    display_name = "Metric Threshold"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/user/vpc-firewall-rule-changes\" resource.type=\"gcp_project\""
      comparison = "COMPARISON_GT"
      threshold_value = 0
      duration = "60s"
      trigger {
        count = 1
      }
    }
  }
  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }
}

resource "google_logging_metric" "vpc_network_changes" {
  provider = google
  name   = "vpc-network-changes"
  project = var.project_id
  description = "Alert on VPC Network Changes"
  filter = "resource.type=gcp_network AND logName:cloudaudit.googleapis.com%2Factivity AND protoPayload.methodName:compute.networks.insert"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
    unit = "1"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_changes" {
  provider = google
  display_name = "VPC Network Changes Alert"
  project = var.project_id
  combiner = "OR"
  conditions {
    display_name = "Metric Threshold"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/user/vpc-network-changes\" resource.type=\"gcp_project\""
      comparison = "COMPARISON_GT"
      threshold_value = 0
      duration = "60s"
      trigger {
        count = 1
      }
    }
  }
  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }
}

resource "google_logging_metric" "vpc_network_route_changes" {
  provider = google
  name   = "vpc-network-route-changes"
  project = var.project_id
  description = "Alert on VPC Network Route Changes"
  filter = "resource.type=gcp_route AND logName:cloudaudit.googleapis.com%2Factivity AND protoPayload.methodName:compute.routes.insert"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
    unit = "1"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_route_changes" {
  provider = google
  display_name = "VPC Network Route Changes Alert"
  project = var.project_id
  combiner = "OR"
  conditions {
    display_name = "Metric Threshold"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/user/vpc-network-route-changes\" resource.type=\"gcp_project\""
      comparison = "COMPARISON_GT"
      threshold_value = 0
      duration = "60s"
      trigger {
        count = 1
      }
    }
  }
  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }
}

resource "google_project_iam_binding" "no_service_account_user_project_level" {
  provider = google
  project = var.project_id
  role = "roles/iam.serviceAccountUser"
  members = []
}

resource "google_project_iam_binding" "no_service_account_token_creator_project_level" {
  provider = google
  project = var.project_id
  role = "roles/iam.serviceAccountTokenCreator"
  members = []
}

resource "google_project_iam_custom_role" "separation_of_duties" {
  provider = google
  project = var.project_id
  role_id = "customServiceAccountRole"
  title = "Custom Service Account Role"
  description = "Custom role to enforce separation of duties"
  permissions = [
    "iam.serviceAccounts.actAs",
    "iam.serviceAccounts.get",
    "iam.serviceAccounts.list",
  ]
}

resource "google_compute_subnetwork" "default_subnetworks" {
  provider = google
  for_each = toset(var.regions)
  name                     = "default"
  ip_cidr_range            = "10.128.0.0/20"
  network                  = "default"
  region                   = each.value
  private_ip_google_access = true
  flow_logs                = true
  project = var.project_id
}
