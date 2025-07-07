terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.68.0"
    }
  }
}

provider "google" {
  project = var.project_id
}


resource "google_compute_subnetwork" "default_subnet_flow_logs" {
  for_each = toset(var.regions)

  name                     = "default"
  ip_cidr_range            = "10.128.0.0/20"
  network                  = "default"
  region                   = each.value
  private_ip_google_access = true
  project                  = var.project_id

  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_network" "default" {
  name                    = var.default_network_name
  project                 = var.project_id
  auto_create_subnetworks = false
  delete_default_routes   = true
}

resource "google_compute_firewall" "default_allow_ssh" {
  name    = var.default_allow_ssh_firewall_name
  project = var.project_id
  network = var.default_network_name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}

resource "google_compute_firewall" "default_allow_rdp" {
  name    = var.default_allow_rdp_firewall_name
  project = var.project_id
  network = var.default_network_name

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["rdp"]
}

resource "google_storage_bucket" "buckets" {
  for_each = toset(var.bucket_names)

  name                        = each.value
  project                     = var.project_id
  location                    = "AUSTRALIA-SOUTHEAST1"
  uniform_bucket_level_access = true
}

resource "google_project_service_identity" "gcr_sa" {
  provider = google
  project  = var.project_id
  service  = "containerregistry.googleapis.com"
}


resource "google_project_iam_member" "artifactregistry_googleapis_com_artifactregistry_reader" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_project_service_identity.gcr_sa.email}"
}

resource "google_artifact_registry_repository" "default" {
  provider = google
  project  = var.project_id
  location = "us-central1"
  repository_id = "my-repo"
  format = "DOCKER"
}


resource "google_container_analysis_occurrence" "note_iam_binding" {
  provider = google
  project               = var.project_id
  note                  = "providers/goog-public-notes/notes/PACKAGE_VULNERABILITY"
  resource_uri          = "https://gcr.io/${var.project_id}/nginx"


  package_issue {
    affected_cpe_uri   = "cpe:/o:debian:debian_linux:8"
    affected_package   = "nginx"
    affected_version {
      epoch = "1"
      name  = "1.6.2"
      revision = "2"
    }
    fixed_cpe_uri      = "cpe:/o:debian:debian_linux:8"
    fixed_package      = "nginx"
    fixed_version {
      epoch = "1"
      name  = "1.6.2"
      revision = "2"
    }
    type               = "VULNERABILITY"

    vulnerability_details {
      cvss_v3 {
        attack_complexity = "ATTACK_COMPLEXITY_LOW"
        attack_vector     = "ATTACK_VECTOR_NETWORK"
        availability_impact = "IMPACT_HIGH"
        base_score          = 9.8
        confidentiality_impact = "IMPACT_HIGH"
        integrity_impact = "IMPACT_HIGH"
        privileges_required = "PRIVILEGES_REQUIRED_NONE"
        scope = "SCOPE_UNCHANGED"
        user_interaction = "USER_INTERACTION_NONE"
      }
      severity          = "HIGH"
    }
  }
}

resource "google_project_service" "container_analysis" {
  provider = google
  project                    = var.project_id
  service                    = "containeranalysis.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudasset" {
  provider = google
  project                    = var.project_id
  service                    = "cloudasset.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_organization_policy" "oslogin" {
  constraint = "compute.requireOsLogin"
  project    = var.project_id

  policy_type = "BOOLEAN"
  boolean_policy {
    enforced = true
  }
}

resource "google_logging_project_sink" "default_sink" {
  name                    = "all-logs-to-bucket"
  project                 = var.project_id
  description             = "Copies all logs to a GCS bucket."
  destination             = "storage.googleapis.com/${google_storage_bucket.buckets["aviato-game-fight-rvxirf.appspot.com"].name}"
  filter                  = "NOT logName:projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity"
  unique_writer_identity  = true
}

resource "google_monitoring_alert_policy" "audit_config_changes_alert" {
  display_name = "Audit Configuration Changes Alert"
  project      = var.project_id
  combiner     = "OR"

  conditions {
    display_name = "Audit Configuration Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/log_entry_count\" AND resource.type=\"global\" AND log_name=\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName:(\"google.cloud.audit.AuditLogs.Update\")"
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }

  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }

  notification_channels = []
}

resource "google_logging_metric" "audit_config_changes_metric" {
  name   = "audit-config-changes"
  project = var.project_id
  description = "Counts the number of audit configuration changes."
  filter = "resource.type=global AND logName=\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName:(\"google.cloud.audit.AuditLogs.Update\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "bucket_permission_changes_alert" {
  display_name = "Cloud Storage IAM Permission Changes Alert"
  project      = var.project_id
  combiner     = "OR"

  conditions {
    display_name = "Cloud Storage IAM Permission Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/log_entry_count\" AND resource.type=\"gcs_bucket\" AND log_name=\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Fdata_access\" AND protoPayload.methodName:(\"storage.setIamPolicy\")"
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }

  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }

  notification_channels = []
}

resource "google_logging_metric" "bucket_permission_changes_metric" {
  name   = "bucket-permission-changes"
  project = var.project_id
  description = "Counts the number of Cloud Storage IAM permission changes."
  filter = "resource.type=gcs_bucket AND logName=\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Fdata_access\" AND protoPayload.methodName:(\"storage.setIamPolicy\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "custom_role_changes_alert" {
  display_name = "Custom Role Changes Alert"
  project      = var.project_id
  combiner     = "OR"

  conditions {
    display_name = "Custom Role Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/log_entry_count\" AND resource.type=\"global\" AND log_name=\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName:(\"google.iam.admin.v1.CreateRole\", \"google.iam.admin.v1.UpdateRole\", \"google.iam.admin.v1.DeleteRole\")"
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }

  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }

  notification_channels = []
}

resource "google_logging_metric" "custom_role_changes_metric" {
  name   = "custom-role-changes"
  project = var.project_id
  description = "Counts the number of custom role changes."
  filter = "resource.type=global AND logName=\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName:(\"google.iam.admin.v1.CreateRole\", \"google.iam.admin.v1.UpdateRole\", \"google.iam.admin.v1.DeleteRole\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "project_ownership_changes_alert" {
  display_name = "Project Ownership Changes Alert"
  project      = var.project_id
  combiner     = "OR"

  conditions {
    display_name = "Project Ownership Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/log_entry_count\" AND resource.type=\"project\" AND log_name=\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName:(\"SetIamPolicy\")"
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }

  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }

  notification_channels = []
}

resource "google_logging_metric" "project_ownership_changes_metric" {
  name   = "project-ownership-changes"
  project = var.project_id
  description = "Counts the number of project ownership changes."
  filter = "resource.type=project AND logName=\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName:(\"SetIamPolicy\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "sql_instance_configuration_changes_alert" {
  display_name = "SQL Instance Configuration Changes Alert"
  project      = var.project_id
  combiner     = "OR"

  conditions {
    display_name = "SQL Instance Configuration Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/log_entry_count\" AND resource.type=\"cloudsql_instance\" AND log_name=\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName:(\"cloudsql.instances.update\")"
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }

  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }

  notification_channels = []
}

resource "google_logging_metric" "sql_instance_configuration_changes_metric" {
  name   = "sql-instance-configuration-changes"
  project = var.project_id
  description = "Counts the number of SQL instance configuration changes."
  filter = "resource.type=cloudsql_instance AND logName=\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName:(\"cloudsql.instances.update\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "vpc_firewall_rule_changes_alert" {
  display_name = "VPC Network Firewall Rule Changes Alert"
  project      = var.project_id
  combiner     = "OR"

  conditions {
    display_name = "VPC Network Firewall Rule Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/log_entry_count\" AND resource.type=\"gce_firewall_rule\" AND log_name=\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName:(\"compute.firewalls.insert\", \"compute.firewalls.patch\", \"compute.firewalls.delete\")"
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }

  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }

  notification_channels = []
}

resource "google_logging_metric" "vpc_firewall_rule_changes_metric" {
  name   = "vpc-firewall-rule-changes"
  project = var.project_id
  description = "Counts the number of VPC network firewall rule changes."
  filter = "resource.type=gce_firewall_rule AND logName=\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName:(\"compute.firewalls.insert\", \"compute.firewalls.patch\", \"compute.firewalls.delete\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_changes_alert" {
  display_name = "VPC Network Changes Alert"
  project      = var.project_id
  combiner     = "OR"

  conditions {
    display_name = "VPC Network Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/log_entry_count\" AND resource.type=\"gce_network\" AND log_name=\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName:(\"compute.networks.insert\", \"compute.networks.patch\", \"compute.networks.delete\")"
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }

  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }

  notification_channels = []
}

resource "google_logging_metric" "vpc_network_changes_metric" {
  name   = "vpc-network-changes"
  project = var.project_id
  description = "Counts the number of VPC network changes."
  filter = "resource.type=gce_network AND logName=\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName:(\"compute.networks.insert\", \"compute.networks.patch\", \"compute.networks.delete\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_route_changes_alert" {
  display_name = "VPC Network Route Changes Alert"
  project      = var.project_id
  combiner     = "OR"

  conditions {
    display_name = "VPC Network Route Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/log_entry_count\" AND resource.type=\"gce_route\" AND log_name=\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName:(\"compute.routes.insert\", \"compute.routes.patch\", \"compute.routes.delete\")"
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }

  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }

  notification_channels = []
}

resource "google_logging_metric" "vpc_network_route_changes_metric" {
  name   = "vpc-network-route-changes"
  project = var.project_id
  description = "Counts the number of VPC network route changes."
  filter = "resource.type=gce_route AND logName=\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName:(\"compute.routes.insert\", \"compute.routes.patch\", \"compute.routes.delete\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}
