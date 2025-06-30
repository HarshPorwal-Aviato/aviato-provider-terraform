resource "google_logging_metric" "audit_config_changes" {
  name        = "audit-config-changes"
  project     = var.project_id
  description = "Metric for audit configuration changes"
  filter      = "protoPayload.methodName=\"SetIamPolicy\" AND resource.type=\"gcp.googleapis.com/Project\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "audit_config_changes" {
  display_name = "Alert for audit configuration changes"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Condition for audit configuration changes"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/audit-config-changes\" resource.type = \"gcp_project\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
      trigger {
        count = 1
      }
    }
  }
}

resource "google_logging_metric" "bucket_permission_changes" {
  name        = "bucket-permission-changes"
  project     = var.project_id
  description = "Metric for Cloud Storage IAM permission changes"
  filter      = "resource.type=\"gcs_bucket\" AND protoPayload.methodName=\"storage.setIamPermissions\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "bucket_permission_changes" {
  display_name = "Alert for Cloud Storage IAM permission changes"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Condition for Cloud Storage IAM permission changes"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/bucket-permission-changes\" resource.type = \"gcs_bucket\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
      trigger {
        count = 1
      }
    }
  }
}

resource "google_logging_metric" "custom_role_changes" {
  name        = "custom-role-changes"
  project     = var.project_id
  description = "Metric for custom role changes"
  filter      = "resource.type = \"iam.googleapis.com/Role\" AND (protoPayload.methodName = \"google.iam.admin.v1.CreateRole\" OR protoPayload.methodName = \"google.iam.admin.v1.DeleteRole\" OR protoPayload.methodName = \"google.iam.admin.v1.UpdateRole\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "custom_role_changes" {
  display_name = "Alert for custom role changes"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Condition for custom role changes"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/custom-role-changes\" resource.type = \"iam.googleapis.com/Role\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
      trigger {
        count = 1
      }
    }
  }
}

resource "google_logging_metric" "project_ownership_changes" {
  name        = "project-ownership-changes"
  project     = var.project_id
  description = "Metric for project ownership changes"
  filter      = "resource.type = \"project\" AND protoPayload.methodName = \"SetIamPolicy\" AND protoPayload.serviceData.policyDelta.bindingDeltas.action = \"ADD\" AND protoPayload.serviceData.policyDelta.bindingDeltas.role = \"roles/owner\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "project_ownership_changes" {
  display_name = "Alert for project ownership changes"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Condition for project ownership changes"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/project-ownership-changes\" resource.type = \"project\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
      trigger {
        count = 1
      }
    }
  }
}

resource "google_logging_metric" "sql_instance_configuration_changes" {
  name        = "sql-instance-configuration-changes"
  project     = var.project_id
  description = "Metric for SQL instance configuration changes"
  filter      = "resource.type = \"cloudsql_database\" AND protoPayload.methodName = \"cloudsql.instances.update\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "sql_instance_configuration_changes" {
  display_name = "Alert for SQL instance configuration changes"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Condition for SQL instance configuration changes"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/sql-instance-configuration-changes\" resource.type = \"cloudsql_database\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
      trigger {
        count = 1
      }
    }
  }
}

resource "google_logging_metric" "vpc_firewall_rule_changes" {
  name        = "vpc-firewall-rule-changes"
  project     = var.project_id
  description = "Metric for VPC Network Firewall rule changes"
  filter      = "resource.type = \"gcp_firewall_rule\" AND (protoPayload.methodName = \"compute.firewalls.insert\" OR protoPayload.methodName = \"compute.firewalls.patch\" OR protoPayload.methodName = \"compute.firewalls.delete\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "vpc_firewall_rule_changes" {
  display_name = "Alert for VPC Network Firewall rule changes"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Condition for VPC Network Firewall rule changes"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/vpc-firewall-rule-changes\" resource.type = \"gcp_firewall_rule\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
      trigger {
        count = 1
      }
    }
  }
}

resource "google_logging_metric" "vpc_network_changes" {
  name        = "vpc-network-changes"
  project     = var.project_id
  description = "Metric for VPC Network changes"
  filter      = "resource.type = \"gcp_network\" AND (protoPayload.methodName = \"beta.compute.networks.insert\" OR protoPayload.methodName = \"compute.networks.patch\" OR protoPayload.methodName = \"compute.networks.delete\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_changes" {
  display_name = "Alert for VPC Network changes"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Condition for VPC Network changes"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/vpc-network-changes\" resource.type = \"gcp_network\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
      trigger {
        count = 1
      }
    }
  }
}

resource "google_logging_metric" "vpc_network_route_changes" {
  name        = "vpc-network-route-changes"
  project     = var.project_id
  description = "Metric for VPC Network route changes"
  filter      = "resource.type = \"gcp_route\" AND (protoPayload.methodName = \"compute.routes.insert\" OR protoPayload.methodName = \"compute.routes.delete\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_route_changes" {
  display_name = "Alert for VPC Network route changes"
  project      = var.project_id
  combiner     = "OR"
  conditions {
    display_name = "Condition for VPC Network route changes"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/vpc-network-route-changes\" resource.type = \"gcp_route\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
      trigger {
        count = 1
      }
    }
  }
}

resource "google_logging_project_sink" "all_logs" {
  name        = "all-logs-sink"
  project     = var.project_id
  description = "Sink to export all log entries"
  destination = "storage.googleapis.com/${var.project_id}-logs"
  filter      = "NOT logName:\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Fdata_access\""
}
