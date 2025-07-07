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

resource "google_project_service_identity" "gcr_sa" {
  provider = google
  project  = var.project_id
  service  = "containerregistry.googleapis.com"
}


resource "google_project_iam_binding" "gcr_artifact_registry" {
  provider = google
  project = var.project_id
  role = "roles/artifactregistry.reader"
  members = [
    "serviceAccount:${google_project_service_identity.gcr_sa.email}"
  ]
}

resource "google_container_analysis_occurrence" "default" {
  project               = var.project_id
  note_name = "providers/goog/notes/vulnerability"
  resource_uri          = "https://gcr.io/${var.project_id}/test-image"

  vulnerability {
    severity = "HIGH"
    details {
      effective_severity = "HIGH"
    }
  }
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

resource "google_project_service" "artifactregistry" {
  provider = google
  project = var.project_id
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_iam_member" "project" {
  project = var.project_id
  role    = "roles/owner"
  member  = "user:example@example.com"
}


resource "google_storage_bucket" "default_buckets" {
  provider = google
  project  = var.project_id
  name          = "${var.project_id}.appspot.com"
  location      = "AUSTRALIA-SOUTHEAST1"
  force_destroy = true
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "default_buckets_us" {
  provider = google
  project  = var.project_id
  name          = "${var.project_id}_bucket"
  location      = "US"
  force_destroy = true
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "staging_buckets" {
  provider = google
  project  = var.project_id
  name          = "staging.${var.project_id}.appspot.com"
  location      = "AUSTRALIA-SOUTHEAST1"
  force_destroy = true
  uniform_bucket_level_access = true
}

resource "google_compute_firewall" "rdp" {
  provider = google
  project = var.project_id
  name    = "default-allow-rdp"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["10.0.0.0/8"]
}

resource "google_compute_firewall" "ssh" {
  provider = google
  project = var.project_id
  name    = "default-allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

   source_ranges = ["10.0.0.0/8"]
}

resource "google_compute_network" "default_network" {
  provider = google
  project = var.project_id
  name                    = "default"
  auto_create_subnetworks = false
  delete_default_routes = true
  routing_mode = "GLOBAL"

  lifecycle {
    ignore_changes = [
      delete_default_routes
    ]
  }
  depends_on = [google_compute_firewall.ssh,google_compute_firewall.rdp]
}

resource "google_compute_network" "default" {
  provider = google
  project = var.project_id
  name                    = "default"
  delete_default_routes = true

  lifecycle {
    ignore_changes = [
      delete_default_routes
    ]
  }
  depends_on = [google_compute_firewall.ssh,google_compute_firewall.rdp]
  count = var.default_network_deletion ? 1 : 0
}


resource "google_compute_network" "default_dns_logging" {
  provider = google
  project = var.project_id
  name                    = "default"
  enable_dns_logging = true
}

resource "google_compute_project_metadata" "oslogin" {
  provider = google
  project = var.project_id
  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_compute_subnetwork" "default_subnetworks" {
  provider = google
  for_each = toset(var.regions)
  name                     = "default"
  ip_cidr_range          = "10.0.0.0/20"
  network                  = "default"
  region                   = each.key
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_logging_project_sink" "default" {
  provider = google
  name        = "aviato-game-fight-rvxirf-sink"
  project = var.project_id
  destination = "storage.googleapis.com/${var.project_id}-log-bucket"
  filter      = "resource.type=gcs_bucket OR resource.type=gce_instance"
}

resource "google_storage_bucket" "log_bucket" {
  provider = google
  name                        = "${var.project_id}-log-bucket"
  project                     = var.project_id
  location                    = "US"
  uniform_bucket_level_access = true
}

resource "google_logging_metric" "audit_configuration_changes" {
  provider = google
  name   = "audit-configuration-changes"
  project = var.project_id
  description = "Log metric for audit configuration changes"
  filter = "protoPayload.methodName=\"SetIamPolicy\" OR protoPayload.methodName:\"Insert\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
    unit = "1"
  }
}

resource "google_monitoring_alert_policy" "audit_configuration_changes" {
  provider = google
  project = var.project_id
  display_name = "Alert for Audit Configuration Changes"
  combiner = "OR"
  conditions {
    display_name = "Metric Threshold"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/user/audit-configuration-changes\" AND resource.type=\"gcp_project\""
      comparison = "COMPARISON_GT"
      threshold_value = 0
      duration = "60s"
      trigger {
        count = 1
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "bucket_permission_changes" {
  provider = google
  name   = "bucket-permission-changes"
  project = var.project_id
  description = "Log metric for Cloud Storage IAM permission changes"
  filter = "resource.type=gcs_bucket AND protoPayload.methodName=\"storage.setIamPolicy\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
    unit = "1"
  }
}

resource "google_monitoring_alert_policy" "bucket_permission_changes" {
  provider = google
  project = var.project_id
  display_name = "Alert for Cloud Storage IAM Permission Changes"
  combiner = "OR"
  conditions {
    display_name = "Metric Threshold"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/user/bucket-permission-changes\" AND resource.type=\"gcp_project\""
      comparison = "COMPARISON_GT"
      threshold_value = 0
      duration = "60s"
      trigger {
        count = 1
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "custom_role_changes" {
  provider = google
  name   = "custom-role-changes"
  project = var.project_id
  description = "Log metric for custom role changes"
  filter = "resource.type=iam_role AND protoPayload.methodName=\"google.iam.admin.v1.CreateRole\" OR protoPayload.methodName=\"google.iam.admin.v1.DeleteRole\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
    unit = "1"
  }
}

resource "google_monitoring_alert_policy" "custom_role_changes" {
  provider = google
  project = var.project_id
  display_name = "Alert for Custom Role Changes"
  combiner = "OR"
  conditions {
    display_name = "Metric Threshold"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/user/custom-role-changes\" AND resource.type=\"gcp_project\""
      comparison = "COMPARISON_GT"
      threshold_value = 0
      duration = "60s"
      trigger {
        count = 1
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "project_ownership_changes" {
  provider = google
  name   = "project-ownership-changes"
  project = var.project_id
  description = "Log metric for project ownership assignments/changes"
  filter = "resource.type=project AND protoPayload.methodName=\"SetIamPolicy\" AND protoPayload.request.policy.bindings:\"roles/owner\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
    unit = "1"
  }
}

resource "google_monitoring_alert_policy" "project_ownership_changes" {
  provider = google
  project = var.project_id
  display_name = "Alert for Project Ownership Assignments/Changes"
  combiner = "OR"
  conditions {
    display_name = "Metric Threshold"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/user/project-ownership-changes\" AND resource.type=\"gcp_project\""
      comparison = "COMPARISON_GT"
      threshold_value = 0
      duration = "60s"
      trigger {
        count = 1
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "sql_instance_configuration_changes" {
  provider = google
  name   = "sql-instance-configuration-changes"
  project = var.project_id
  description = "Log metric for SQL instance configuration changes"
  filter = "resource.type=cloudsql_instance AND protoPayload.methodName:(\"cloudsql.instances.update\" OR \"cloudsql.instances.patch\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
    unit = "1"
  }
}

resource "google_monitoring_alert_policy" "sql_instance_configuration_changes" {
  provider = google
  project = var.project_id
  display_name = "Alert for SQL Instance Configuration Changes"
  combiner = "OR"
  conditions {
    display_name = "Metric Threshold"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/user/sql-instance-configuration-changes\" AND resource.type=\"gcp_project\""
      comparison = "COMPARISON_GT"
      threshold_value = 0
      duration = "60s"
      trigger {
        count = 1
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "vpc_firewall_rule_changes" {
  provider = google
  name   = "vpc-firewall-rule-changes"
  project = var.project_id
  description = "Log metric for VPC network firewall rule changes"
  filter = "resource.type=gce_firewall_rule AND protoPayload.methodName=\"compute.firewalls.insert\" OR protoPayload.methodName=\"compute.firewalls.delete\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
    unit = "1"
  }
}

resource "google_monitoring_alert_policy" "vpc_firewall_rule_changes" {
  provider = google
  project = var.project_id
  display_name = "Alert for VPC Network Firewall Rule Changes"
  combiner = "OR"
  conditions {
    display_name = "Metric Threshold"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/user/vpc-firewall-rule-changes\" AND resource.type=\"gcp_project\""
      comparison = "COMPARISON_GT"
      threshold_value = 0
      duration = "60s"
      trigger {
        count = 1
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "vpc_network_changes" {
  provider = google
  name   = "vpc-network-changes"
  project = var.project_id
  description = "Log metric for VPC network changes"
  filter = "resource.type=gce_network AND protoPayload.methodName=\"compute.networks.insert\" OR protoPayload.methodName=\"compute.networks.delete\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
    unit = "1"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_changes" {
  provider = google
  project = var.project_id
  display_name = "Alert for VPC Network Changes"
  combiner = "OR"
  conditions {
    display_name = "Metric Threshold"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/user/vpc-network-changes\" AND resource.type=\"gcp_project\""
      comparison = "COMPARISON_GT"
      threshold_value = 0
      duration = "60s"
      trigger {
        count = 1
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "vpc_network_route_changes" {
  provider = google
  name   = "vpc-network-route-changes"
  project = var.project_id
  description = "Log metric for VPC network route changes"
  filter = "resource.type=gce_route AND protoPayload.methodName=\"compute.routes.insert\" OR protoPayload.methodName=\"compute.routes.delete\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
    unit = "1"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_route_changes" {
  provider = google
  project = var.project_id
  display_name = "Alert for VPC Network Route Changes"
  combiner = "OR"
  conditions {
    display_name = "Metric Threshold"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/user/vpc-network-route-changes\" AND resource.type=\"gcp_project\""
      comparison = "COMPARISON_GT"
      threshold_value = 0
      duration = "60s"
      trigger {
        count = 1
      }
    }
  }
  notification_channels = []
}
