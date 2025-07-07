resource "google_logging_project_sink" "all_logs" {
  name        = "all-logs-sink"
  project     = var.project_id
  destination = "bigquery.googleapis.com/projects/${var.project_id}/datasets/logging_dataset"
  filter      = "NOT logName:projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Fdata_access"
}

resource "google_logging_metric" "audit_configuration_changes" {
  name        = "audit-config-changes"
  project     = var.project_id
  description = "Metric for audit configuration changes"
  filter      = "protoPayload.methodName=\"SetIamPolicy\" OR protoPayload.methodName:\"Update.*\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "audit_configuration_changes_alert" {
  display_name = "Audit Configuration Changes Alert"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Audit Configuration Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/audit-config-changes\" AND resource.project_id=\"${var.project_id}\""
      comparison      = "COMPARISON_GT"
      duration        = "60s"
      threshold_value = 0
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "bucket_permission_changes" {
  name        = "bucket-permission-changes"
  project     = var.project_id
  description = "Metric for Cloud Storage IAM permission changes"
  filter      = "resource.type=\"gcs_bucket\" AND protoPayload.methodName=\"storage.setIamPolicy\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "bucket_permission_changes_alert" {
  display_name = "Bucket Permission Changes Alert"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Bucket Permission Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/bucket-permission-changes\" AND resource.project_id=\"${var.project_id}\""
      comparison      = "COMPARISON_GT"
      duration        = "60s"
      threshold_value = 0
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "custom_role_changes" {
  name        = "custom-role-changes"
  project     = var.project_id
  description = "Metric for custom role changes"
  filter      = "protoPayload.methodName=\"google.iam.admin.v1.CreateRole\" OR protoPayload.methodName=\"google.iam.admin.v1.UpdateRole\" OR protoPayload.methodName=\"google.iam.admin.v1.DeleteRole\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "custom_role_changes_alert" {
  display_name = "Custom Role Changes Alert"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Custom Role Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/custom-role-changes\" AND resource.project_id=\"${var.project_id}\""
      comparison      = "COMPARISON_GT"
      duration        = "60s"
      threshold_value = 0
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "project_ownership_changes" {
  name        = "project-ownership-changes"
  project     = var.project_id
  description = "Metric for project ownership assignments/changes"
  filter      = "protoPayload.methodName=\"SetIamPolicy\" AND resource.type=\"project\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "project_ownership_changes_alert" {
  display_name = "Project Ownership Changes Alert"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Project Ownership Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/project-ownership-changes\" AND resource.project_id=\"${var.project_id}\""
      comparison      = "COMPARISON_GT"
      duration        = "60s"
      threshold_value = 0
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "sql_instance_configuration_changes" {
  name        = "sql-instance-config-changes"
  project     = var.project_id
  description = "Metric for SQL instance configuration changes"
  filter      = "resource.type=\"cloudsql_database\" AND protoPayload.methodName:\"cloudsql.instances.update\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "sql_instance_configuration_changes_alert" {
  display_name = "SQL Instance Configuration Changes Alert"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "SQL Instance Configuration Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/sql-instance-config-changes\" AND resource.project_id=\"${var.project_id}\""
      comparison      = "COMPARISON_GT"
      duration        = "60s"
      threshold_value = 0
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "vpc_firewall_rule_changes" {
  name        = "vpc-firewall-rule-changes"
  project     = var.project_id
  description = "Metric for VPC network firewall rule changes"
  filter      = "resource.type=\"gce_firewall_rule\" AND protoPayload.methodName=\"compute.firewalls.insert\" OR protoPayload.methodName=\"compute.firewalls.delete\" OR protoPayload.methodName=\"compute.firewalls.patch\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "vpc_firewall_rule_changes_alert" {
  display_name = "VPC Firewall Rule Changes Alert"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "VPC Firewall Rule Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-firewall-rule-changes\" AND resource.project_id=\"${var.project_id}\""
      comparison      = "COMPARISON_GT"
      duration        = "60s"
      threshold_value = 0
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "vpc_network_changes" {
  name        = "vpc-network-changes"
  project     = var.project_id
  description = "Metric for VPC network changes"
  filter      = "resource.type=\"gce_network\" AND protoPayload.methodName=\"compute.networks.insert\" OR protoPayload.methodName=\"compute.networks.delete\" OR protoPayload.methodName=\"compute.networks.patch\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_changes_alert" {
  display_name = "VPC Network Changes Alert"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "VPC Network Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-network-changes\" AND resource.project_id=\"${var.project_id}\""
      comparison      = "COMPARISON_GT"
      duration        = "60s"
      threshold_value = 0
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "vpc_network_route_changes" {
  name        = "vpc-network-route-changes"
  project     = var.project_id
  description = "Metric for VPC network route changes"
  filter      = "resource.type=\"gce_route\" AND protoPayload.methodName=\"compute.routes.insert\" OR protoPayload.methodName=\"compute.routes.delete\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_route_changes_alert" {
  display_name = "VPC Network Route Changes Alert"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "VPC Network Route Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-network-route-changes\" AND resource.project_id=\"${var.project_id}\""
      comparison      = "COMPARISON_GT"
      duration        = "60s"
      threshold_value = 0
    }
  }
  notification_channels = []
}
