resource "google_logging_project_sink" "default" {
  provider = google.gcp
  name        = "all-logs"
  project     = var.project_id
  destination = "storage.googleapis.com/${var.project_id}-logs"
  filter      = "NOT logName:projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity"
}

resource "google_logging_metric" "audit_config_changes" {
  provider = google.gcp
  name        = "audit-config-changes"
  project     = var.project_id
  description = "Log metric for audit configuration changes"
  filter      = "resource.type=audited_resource AND protoPayload.methodName=SetIamPolicy"

  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_monitoring_alert_policy" "audit_config_changes" {
  provider = google.gcp
  display_name = "Audit Configuration Changes Alert"
  project     = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Audit Configuration Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/audit-config-changes\" AND resource.type=\"gcp_project\""
      comparison      = "COMPARISON_GT"
      duration        = "60s"
      trigger {
        count   = 1
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "bucket_permission_changes" {
  provider = google.gcp
  name        = "bucket-permission-changes"
  project     = var.project_id
  description = "Log metric for Cloud Storage IAM Permission Changes"
  filter      = "resource.type=gcs_bucket AND protoPayload.methodName=storage.setIamPermissions"

  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_monitoring_alert_policy" "bucket_permission_changes" {
  provider = google.gcp
  display_name = "Cloud Storage IAM Permission Changes Alert"
  project     = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Cloud Storage IAM Permission Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/bucket-permission-changes\" AND resource.type=\"gcp_project\""
      comparison      = "COMPARISON_GT"
      duration        = "60s"
      trigger {
        count   = 1
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "custom_role_changes" {
  provider = google.gcp
  name        = "custom-role-changes"
  project     = var.project_id
  description = "Log metric for Custom Role Changes"
  filter      = "resource.type=iam_role AND protoPayload.methodName=google.iam.admin.v1.CreateRole"

  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_monitoring_alert_policy" "custom_role_changes" {
  provider = google.gcp
  display_name = "Custom Role Changes Alert"
  project     = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Custom Role Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/custom-role-changes\" AND resource.type=\"gcp_project\""
      comparison      = "COMPARISON_GT"
      duration        = "60s"
      trigger {
        count   = 1
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "project_ownership_changes" {
  provider = google.gcp
  name        = "project-ownership-changes"
  project     = var.project_id
  description = "Log metric for Project Ownership Assignments/Changes"
  filter      = "resource.type=gcp_project AND protoPayload.methodName=SetIamPolicy"

  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_monitoring_alert_policy" "project_ownership_changes" {
  provider = google.gcp
  display_name = "Project Ownership Changes Alert"
  project     = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Project Ownership Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/project-ownership-changes\" AND resource.type=\"gcp_project\""
      comparison      = "COMPARISON_GT"
      duration        = "60s"
      trigger {
        count   = 1
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "sql_instance_config_changes" {
  provider = google.gcp
  name        = "sql-instance-config-changes"
  project     = var.project_id
  description = "Log metric for SQL Instance Configuration Changes"
  filter      = "resource.type=cloudsql_database AND protoPayload.methodName=cloudsql.instances.update"

  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_monitoring_alert_policy" "sql_instance_config_changes" {
  provider = google.gcp
  display_name = "SQL Instance Configuration Changes Alert"
  project     = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "SQL Instance Configuration Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/sql-instance-config-changes\" AND resource.type=\"gcp_project\""
      comparison      = "COMPARISON_GT"
      duration        = "60s"
      trigger {
        count   = 1
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "vpc_firewall_rule_changes" {
  provider = google.gcp
  name        = "vpc-firewall-rule-changes"
  project     = var.project_id
  description = "Log metric for VPC Network Firewall Rule Changes"
  filter      = "resource.type=gcp_firewall_rule AND protoPayload.methodName=compute.firewalls.insert"

  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_monitoring_alert_policy" "vpc_firewall_rule_changes" {
  provider = google.gcp
  display_name = "VPC Network Firewall Rule Changes Alert"
  project     = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "VPC Network Firewall Rule Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-firewall-rule-changes\" AND resource.type=\"gcp_project\""
      comparison      = "COMPARISON_GT"
      duration        = "60s"
      trigger {
        count   = 1
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "vpc_network_changes" {
  provider = google.gcp
  name        = "vpc-network-changes"
  project     = var.project_id
  description = "Log metric for VPC Network Changes"
  filter      = "resource.type=gcp_network AND protoPayload.methodName=compute.networks.insert"

  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_changes" {
  provider = google.gcp
  display_name = "VPC Network Changes Alert"
  project     = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "VPC Network Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-network-changes\" AND resource.type=\"gcp_project\""
      comparison      = "COMPARISON_GT"
      duration        = "60s"
      trigger {
        count   = 1
      }
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "vpc_network_route_changes" {
  provider = google.gcp
  name        = "vpc-network-route-changes"
  project     = var.project_id
  description = "Log metric for VPC Network Route Changes"
  filter      = "resource.type=gcp_route AND protoPayload.methodName=compute.routes.insert"

  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_route_changes" {
  provider = google.gcp
  display_name = "VPC Network Route Changes Alert"
  project     = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "VPC Network Route Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-network-route-changes\" AND resource.type=\"gcp_project\""
      comparison      = "COMPARISON_GT"
      duration        = "60s"
      trigger {
        count   = 1
      }
    }
  }
  notification_channels = []
}
