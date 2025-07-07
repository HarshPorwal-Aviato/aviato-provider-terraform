resource "google_logging_project_sink" "default" {
  name        = "all-logs"
  project     = var.project_id
  destination = "storage.googleapis.com/${var.project_id}-all-logs"
  filter      = "NOT logName:projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity"
}

resource "google_logging_metric" "audit_configuration_changes" {
  name = "audit-configuration-changes"
  project = var.project_id
  description = "Metric for audit configuration changes"
  filter = "protoPayload.methodName=\"google.iam.admin.v1.CreateServiceAccount\" OR protoPayload.methodName=\"google.iam.admin.v1.PatchServiceAccount\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
    unit = "1"
  }
}

resource "google_monitoring_alert_policy" "audit_configuration_changes_alert" {
  display_name = "Alert for audit configuration changes"
  project = var.project_id
  combiner = "OR"
  conditions {
    display_name = "Condition for audit configuration changes"
    condition_threshold {
      filter = "metric.type=\"logging.googleapis.com/user/audit-configuration-changes\" resource.type=\"gcp_project\""
      duration = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
      aggregations {
        alignment_period = "60s"
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
