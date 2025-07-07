terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.15.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_project_service_identity" "gcr_sa" {
  provider = google
  project = var.project_id
  service = "containerregistry.googleapis.com"
}

resource "google_project_iam_member" "container_analysis" {
  project = var.project_id
  role    = "roles/containeranalysis.notes.occurrences.viewer"
  member  = "serviceAccount:${google_project_service_identity.gcr_sa.email}"
}

resource "google_container_analysis_occurrence" "container_analysis" {
  provider = google
  project               = var.project_id
  note_name             = "providers/goog-terraform-test/notes/vuln123"
  resource_uri        = "goog-terraform-test/image@sha256:3ca05e39b18f8605ae0f92695e831a5d9e6859b07c5041df5482a967292c8316"
  short_description   = "blah"
  long_description    = "foo"

  vulnerability {
    severity = "HIGH"

    details {
      effective_severity = "HIGH"
      type               = "blah"
    }
  }
}

resource "google_project_service" "artifactregistry" {
  provider = google
  project = var.project_id
  service = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_artifact_registry_repository" "my_repo" {
  provider = google
  project  = var.project_id
  location = var.region
  repository_id = "my-repo"
  format      = "DOCKER"
}

resource "google_project_service" "containeranalysis" {
  provider = google
  project = var.project_id
  service = "containeranalysis.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudasset" {
  provider = google
  project = var.project_id
  service = "cloudasset.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "dns" {
  provider = google
  project = var.project_id
  service = "dns.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_network" "default" {
  provider = google
  name                    = "default"
  project                 = var.project_id
  delete_default_routes = true

  lifecycle {
    ignore_changes = [
      delete_default_routes,
    ]
  }
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
  source_ranges = ["0.0.0.0/0"]

  lifecycle {
    ignore_changes = [
      source_ranges,
    ]
  }
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
    source_ranges = ["0.0.0.0/0"]

  lifecycle {
    ignore_changes = [
      source_ranges,
    ]
  }
}

resource "google_compute_network" "custom_network" {
  provider = google
  name                    = "vpc-network"
  project                 = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "default_subnet_flow_logs" {
  for_each = toset(var.default_subnets)
  provider = google
  name                     = each.key
  ip_cidr_range          = "10.10.10.0/24"
  network                  = google_compute_network.custom_network.id
  region                   = each.key
  project                  = var.project_id
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_project_metadata" "oslogin" {
  provider = google
  project = var.project_id
  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_dns_managed_zone" "private_zone" {
  provider = google
  project = var.project_id
  name             = "private-zone"
  dns_name         = "example.com."
  description      = "Private DNS zone for VPC network"
  visibility       = "private"

  private_visibility_config {
    networks {
        network_url = google_compute_network.custom_network.id
    }
  }
}

resource "google_logging_project_sink" "default" {
  provider = google
  name   = "all-logs"
  project = var.project_id
  description = "Copies of all log entries."
  destination = "bigquery.googleapis.com/projects/${var.project_id}/datasets/logging_dataset"
  filter = "NOT logName:\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND NOT logName:\"projects/${var.project_id}/logs/system.gce_shielded_vm.googleapis.com%2Fstdout\""
  unique_writer_identity = true
}

resource "google_logging_metric" "audit_configuration_changes" {
  provider = google
  name        = "audit-configuration-changes"
  project = var.project_id
  description = "Metric for audit configuration changes"
  filter      = "resource.type=audited_resource AND protoPayload.methodName:SetIamPolicy"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
    unit = "1"
  }
}

resource "google_monitoring_alert_policy" "audit_configuration_changes" {
  provider = google
  project = var.project_id
  display_name = "Alert for audit configuration changes"
  combiner     = "OR"
  conditions {
    display_name = "Condition for audit configuration changes"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/audit-configuration-changes\" AND resource.type=\"gcp_project\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
    }
  }
}

resource "google_logging_metric" "bucket_permission_changes" {
  provider = google
  name        = "bucket-permission-changes"
  project = var.project_id
  description = "Metric for Cloud Storage IAM permission changes"
  filter      = "resource.type=gcs_bucket AND protoPayload.methodName:storage.setIamPermissions"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
    unit = "1"
  }
}

resource "google_monitoring_alert_policy" "bucket_permission_changes" {
  provider = google
  project = var.project_id
  display_name = "Alert for Cloud Storage IAM permission changes"
  combiner     = "OR"
  conditions {
    display_name = "Condition for Cloud Storage IAM permission changes"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/bucket-permission-changes\" AND resource.type=\"gcp_project\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
    }
  }
}

resource "google_logging_metric" "custom_role_changes" {
  provider = google
  name        = "custom-role-changes"
  project = var.project_id
  description = "Metric for Custom Role changes"
  filter      = "resource.type=iam_role AND protoPayload.methodName:UpdateRole"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
    unit = "1"
  }
}

resource "google_monitoring_alert_policy" "custom_role_changes" {
  provider = google
  project = var.project_id
  display_name = "Alert for Custom Role changes"
  combiner     = "OR"
  conditions {
    display_name = "Condition for Custom Role changes"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/custom-role-changes\" AND resource.type=\"gcp_project\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
    }
  }
}

resource "google_logging_metric" "project_ownership_changes" {
  provider = google
  name        = "project-ownership-changes"
  project = var.project_id
  description = "Metric for Project Ownership Assignments/Changes"
  filter      = "resource.type=gcp_project AND protoPayload.methodName:SetIamPolicy AND protoPayload.request.policy.bindings.role:roles/owner"
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
  combiner     = "OR"
  conditions {
    display_name = "Condition for Project Ownership Assignments/Changes"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/project-ownership-changes\" AND resource.type=\"gcp_project\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
    }
  }
}

resource "google_logging_metric" "sql_instance_configuration_changes" {
  provider = google
  name        = "sql-instance-configuration-changes"
  project = var.project_id
  description = "Metric for SQL Instance Configuration Changes"
  filter      = "resource.type=cloudsql_database AND protoPayload.methodName:cloudsql.instances.update"
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
  combiner     = "OR"
  conditions {
    display_name = "Condition for SQL Instance Configuration Changes"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/sql-instance-configuration-changes\" AND resource.type=\"gcp_project\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
    }
  }
}

resource "google_logging_metric" "vpc_firewall_rule_changes" {
  provider = google
  name        = "vpc-firewall-rule-changes"
  project = var.project_id
  description = "Metric for VPC Network Firewall Rule Changes"
  filter      = "resource.type=gce_firewall_rule AND protoPayload.methodName:compute.firewalls.insert"
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
  combiner     = "OR"
  conditions {
    display_name = "Condition for VPC Network Firewall Rule Changes"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-firewall-rule-changes\" AND resource.type=\"gcp_project\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
    }
  }
}

resource "google_logging_metric" "vpc_network_changes" {
  provider = google
  name        = "vpc-network-changes"
  project = var.project_id
  description = "Metric for VPC Network Changes"
  filter      = "resource.type=gce_network AND protoPayload.methodName:compute.networks.insert"
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
  combiner     = "OR"
  conditions {
    display_name = "Condition for VPC Network Changes"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-network-changes\" AND resource.type=\"gcp_project\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
    }
  }
}

resource "google_logging_metric" "vpc_network_route_changes" {
  provider = google
  name        = "vpc-network-route-changes"
  project = var.project_id
  description = "Metric for VPC Network Route Changes"
  filter      = "resource.type=gce_route AND protoPayload.methodName:compute.routes.insert"
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
  combiner     = "OR"
  conditions {
    display_name = "Condition for VPC Network Route Changes"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-network-route-changes\" AND resource.type=\"gcp_project\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
    }
  }
}

resource "google_storage_bucket" "default_buckets" {
  for_each = toset(var.bucket_names)
  provider = google
  name          = each.key
  project       = var.project_id
  location      = "AUSTRALIA-SOUTHEAST1"
  force_destroy = true
  uniform_bucket_level_access = true
}
