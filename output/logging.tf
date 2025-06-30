data "google_project" "project" {
  project_id = "aviato-game-fight-rvxirf"
}

locals {
  project_id = data.google_project.project.project_id
}

resource "google_logging_metric" "audit_config_changes" {
  name        = "audit-config-changes"
  project     = local.project_id
  description = "Log metric for audit configuration changes"
  filter      = "resource.type=audited_resource AND protoPayload.methodName:SetIamPolicy OR protoPayload.methodName:UpdateService"

  metric_descriptor {
    launch_stage = "BETA"
    name         = "logging.googleapis.com/metric/audit_config_changes"
    type         = "INT64"
    unit         = "1"
    value_type   = "INT64"
  }
}

resource "google_monitoring_alert_policy" "audit_config_changes_alert" {
  display_name = "Audit Configuration Changes Alert"
  project      = local.project_id
  combiner     = "OR"
  conditions {
    display_name = "Audit Configuration Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/metric/audit_config_changes\" resource.type=audited_resource"
      comparison      = "COMPARISON_GT"
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
  project     = local.project_id
  description = "Log metric for Cloud Storage IAM permission changes"
  filter      = "resource.type=\"gcs_bucket\" AND protoPayload.methodName=(\"storage.setIamPermissions\")"

  metric_descriptor {
    launch_stage = "BETA"
    name         = "logging.googleapis.com/metric/bucket_permission_changes"
    type         = "INT64"
    unit         = "1"
    value_type   = "INT64"
  }
}

resource "google_monitoring_alert_policy" "bucket_permission_changes_alert" {
  display_name = "Cloud Storage IAM Permission Changes Alert"
  project      = local.project_id
  combiner     = "OR"
  conditions {
    display_name = "Cloud Storage IAM Permission Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/metric/bucket_permission_changes\" resource.type=gcs_bucket"
      comparison      = "COMPARISON_GT"
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
  project     = local.project_id
  description = "Log metric for custom role changes"
  filter      = "resource.type=iam_role AND (protoPayload.methodName=\"google.iam.admin.v1.CreateRole\" OR protoPayload.methodName=\"google.iam.admin.v1.DeleteRole\" OR protoPayload.methodName=\"google.iam.admin.v1.UpdateRole\")"

  metric_descriptor {
    launch_stage = "BETA"
    name         = "logging.googleapis.com/metric/custom_role_changes"
    type         = "INT64"
    unit         = "1"
    value_type   = "INT64"
  }
}

resource "google_monitoring_alert_policy" "custom_role_changes_alert" {
  display_name = "Custom Role Changes Alert"
  project      = local.project_id
  combiner     = "OR"
  conditions {
    display_name = "Custom Role Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/metric/custom_role_changes\" resource.type=iam_role"
      comparison      = "COMPARISON_GT"
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
  project     = local.project_id
  description = "Log metric for project ownership assignments/changes"
  filter      = "resource.type=project AND protoPayload.methodName=\"google.cloudresourcemanager.projects.setIamPolicy\" AND jsonPayload.policyDelta.bindingDeltas.member:(\"user:owner@example.com\" OR \"group:owners@example.com\" OR \"serviceAccount:owner@example.com\")"

  metric_descriptor {
    launch_stage = "BETA"
    name         = "logging.googleapis.com/metric/project_ownership_changes"
    type         = "INT64"
    unit         = "1"
    value_type   = "INT64"
  }
}

resource "google_monitoring_alert_policy" "project_ownership_changes_alert" {
  display_name = "Project Ownership Changes Alert"
  project      = local.project_id
  combiner     = "OR"
  conditions {
    display_name = "Project Ownership Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/metric/project_ownership_changes\" resource.type=project"
      comparison      = "COMPARISON_GT"
      duration        = "60s"
      trigger {
        count = 1
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "sql_instance_config_changes" {
  name        = "sql-instance-config-changes"
  project     = local.project_id
  description = "Log metric for SQL instance configuration changes"
  filter      = "resource.type
