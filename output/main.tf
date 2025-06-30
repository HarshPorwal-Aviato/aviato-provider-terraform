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

resource "google_project_metadata" "project_metadata" {
  project = var.project_id

  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_project_service" "artifact_analysis" {
  project            = var.project_id
  service            = "containeranalysis.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudasset" {
  project            = var.project_id
  service            = "cloudasset.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_firewall" "default_allow_ssh" {
  name    = "default-allow-ssh"
  project = var.project_id
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.default_ssh_source_ranges
}

resource "google_compute_firewall" "default_allow_rdp" {
  name    = "default-allow-rdp"
  project = var.project_id
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = var.default_rdp_source_ranges
}

resource "google_storage_bucket" "default" {
  for_each = toset(var.gcs_buckets_uniform_access)

  name          = each.value
  project       = var.project_id
  location      = "US"
  force_destroy = false

  uniform_bucket_level_access = true
}

resource "google_compute_subnet" "default" {
  for_each = toset(var.all_regions)

  name                     = "default"
  project                  = var.project_id
  region                   = each.value
  network                  = "default"
  ip_cidr_range            = "10.128.0.0/20" #Default value, change as necessary
  private_ip_google_access = true
  enable_flow_logs         = true
}

resource "google_logging_metric" "audit_configuration_changes" {
  name        = "audit-configuration-changes"
  project     = var.project_id
  description = "This metric counts the number of audit configuration changes."
  filter      = "resource.type=audited_resource AND severity>=ERROR AND (protoPayload.methodName:SetIamPolicy OR protoPayload.methodName:InsertRole OR protoPayload.methodName:DeleteRole)"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_logging_metric" "bucket_permission_changes" {
  name        = "bucket-permission-changes"
  project     = var.project_id
  description = "This metric counts the number of bucket permission changes."
  filter      = "resource.type=gcs_bucket AND severity>=ERROR AND protoPayload.methodName:storage.setIamPermissions"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_logging_metric" "custom_role_changes" {
  name        = "custom-role-changes"
  project     = var.project_id
  description = "This metric counts the number of custom role changes."
  filter      = "resource.type=iam_role AND severity>=ERROR AND (protoPayload.methodName:CreateRole OR protoPayload.methodName:DeleteRole OR protoPayload.methodName:UpdateRole)"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_logging_metric" "project_ownership_changes" {
  name        = "project-ownership-changes"
  project     = var.project_id
  description = "This metric counts the number of project ownership changes."
  filter      = "resource.type=project AND severity>=ERROR AND protoPayload.methodName:SetIamPolicy AND protoPayload.request.policy.bindings.role:roles/owner"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_logging_metric" "sql_instance_configuration_changes" {
  name        = "sql-instance-configuration-changes"
  project     = var.project_id
  description = "This metric counts the number of SQL instance configuration changes."
  filter      = "resource.type=cloudsql_instance AND severity>=ERROR AND protoPayload.methodName:cloudsql.instances.update"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_logging_metric" "vpc_firewall_rule_changes" {
  name        = "vpc-firewall-rule-changes"
  project     = var.project_id
  description = "This metric counts the number of VPC firewall rule changes."
  filter      = "resource.type=gce_firewall_rule AND severity>=ERROR AND (protoPayload.methodName:compute.firewalls.insert OR protoPayload.methodName:compute.firewalls.patch)"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_logging_metric" "vpc_network_changes" {
  name        = "vpc-network-changes"
  project     = var.project_id
  description = "This metric counts the number of VPC network changes."
  filter      = "resource.type=gce_network AND severity>=ERROR AND (protoPayload.methodName:compute.networks.insert OR protoPayload.methodName:compute.networks.patch)"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_logging_metric" "vpc_network_route_changes" {
  name        = "vpc-network-route-changes"
  project     = var.project_id
  description = "This metric counts the number of VPC network route changes."
  filter      = "resource.type=gce_route AND severity>=ERROR AND (protoPayload.methodName:compute.routes.insert OR protoPayload.methodName:compute.routes.delete)"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_logging_project_sink" "default_sink" {
  name   = "default-sink"
  project = var.project_id
  description = "Sink to export all logs to a GCS bucket"
  destination = "storage.googleapis.com/${var.project_id}-logs" 
  filter = "NOT logName:projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity" # Exclude audit logs to avoid double billing

  unique_writer_identity = true
}
