resource "google_logging_project_sink" "default" {
  name = "all-logs"
  project = var.project_id
  description = "sink for all logs"
  destination = "storage.googleapis.com/${var.project_id}-all-logs"
  filter = "NOT logName:projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Fdata_access"

}

resource "google_project_iam_binding" "logging_writer" {
  project = var.project_id
  role    = "roles/storage.admin"
  members = ["serviceAccount:service-${data.google_project.project.number}@gcp-sa-logging.iam.gserviceaccount.com"]
}

data "google_project" "project" {
  project_id = var.project_id
}

resource "google_logging_metric" "audit_configuration_changes" {
  name   = "audit-configuration-changes"
  project = var.project_id
  description = "Log metric filter for Audit Configuration Changes"
  filter = "protoPayload.methodName=\"SetIamPolicy\" OR protoPayload.methodName=\"google.cloud.audit.AuditPolicy.updatePolicy\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "audit_configuration_changes" {
  display_name = "Alert for Audit Configuration Changes"
  project = var.project_id
  combiner = "OR"
  conditions {
    display_name = "Condition for Audit Configuration Changes"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/audit-configuration-changes\" AND resource.type=\"gcp_project\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "bucket_permission_changes" {
  name   = "bucket-permission-changes"
  project = var.project_id
  description = "Log metric filter for Cloud Storage IAM Permission Changes"
  filter = "resource.type=\"gcs_bucket\" AND protoPayload.methodName=\"storage.setIamPermissions\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "bucket_permission_changes" {
  display_name = "Alert for Cloud Storage IAM Permission Changes"
  project = var.project_id
  combiner = "OR"
  conditions {
    display_name = "Condition for Cloud Storage IAM Permission Changes"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/bucket-permission-changes\" AND resource.type=\"gcp_project\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "custom_role_changes" {
  name   = "custom-role-changes"
  project = var.project_id
  description = "Log metric filter for Custom Role Changes"
  filter = "resource.type=\"iam_role\" AND (protoPayload.methodName=\"google.iam.admin.v1.CreateRole\" OR protoPayload.methodName=\"google.iam.admin.v1.UpdateRole\" OR protoPayload.methodName=\"google.iam.admin.v1.DeleteRole\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "custom_role_changes" {
  display_name = "Alert for Custom Role Changes"
  project = var.project_id
  combiner = "OR"
  conditions {
    display_name = "Condition for Custom Role Changes"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/custom-role-changes\" AND resource.type=\"gcp_project\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "project_ownership_changes" {
  name   = "project-ownership-changes"
  project = var.project_id
  description = "Log metric filter for Project Ownership Assignments/Changes"
  filter = "protoPayload.methodName=\"SetIamPolicy\" AND resource.type=\"project\" AND protoPayload.request.policy.bindings: data.google_project.project.project_id"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "project_ownership_changes" {
  display_name = "Alert for Project Ownership Assignments/Changes"
  project = var.project_id
  combiner = "OR"
  conditions {
    display_name = "Condition for Project Ownership Assignments/Changes"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/project-ownership-changes\" AND resource.type=\"gcp_project\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "sql_instance_configuration_changes" {
  name   = "sql-instance-configuration-changes"
  project = var.project_id
  description = "Log metric filter for SQL Instance Configuration Changes"
  filter = "resource.type=\"cloudsql_database\" AND protoPayload.methodName=\"cloudsql.instances.update\""
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "sql_instance_configuration_changes" {
  display_name = "Alert for SQL Instance Configuration Changes"
  project = var.project_id
  combiner = "OR"
  conditions {
    display_name = "Condition for SQL Instance Configuration Changes"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/sql-instance-configuration-changes\" AND resource.type=\"gcp_project\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "vpc_firewall_rule_changes" {
  name   = "vpc-firewall-rule-changes"
  project = var.project_id
  description = "Log metric filter for VPC Network Firewall Rule Changes"
  filter = "resource.type=\"gce_firewall_rule\" AND (protoPayload.methodName=\"compute.firewalls.insert\" OR protoPayload.methodName=\"compute.firewalls.delete\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "vpc_firewall_rule_changes" {
  display_name = "Alert for VPC Network Firewall Rule Changes"
  project = var.project_id
  combiner = "OR"
  conditions {
    display_name = "Condition for VPC Network Firewall Rule Changes"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/vpc-firewall-rule-changes\" AND resource.type=\"gcp_project\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "vpc_network_changes" {
  name   = "vpc-network-changes"
  project = var.project_id
  description = "Log metric filter for VPC Network Changes"
  filter = "resource.type=\"gce_network\" AND (protoPayload.methodName=\"compute.networks.insert\" OR protoPayload.methodName=\"compute.networks.delete\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_changes" {
  display_name = "Alert for VPC Network Changes"
  project = var.project_id
  combiner = "OR"
  conditions {
    display_name = "Condition for VPC Network Changes"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/vpc-network-changes\" AND resource.type=\"gcp_project\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
    }
  }
  notification_channels = []
}

resource "google_logging_metric" "vpc_network_route_changes" {
  name   = "vpc-network-route-changes"
  project = var.project_id
  description = "Log metric filter for VPC Network Route Changes"
  filter = "resource.type=\"gce_route\" AND (protoPayload.methodName=\"compute.routes.insert\" OR protoPayload.methodName=\"compute.routes.delete\")"
  metric_descriptor {
    metric_kind = "COUNTER"
    value_type = "INT64"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_route_changes" {
  display_name = "Alert for VPC Network Route Changes"
  project = var.project_id
  combiner = "OR"
  conditions {
    display_name = "Condition for VPC Network Route Changes"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/user/vpc-network-route-changes\" AND resource.type=\"gcp_project\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
    }
  }
  notification_channels = []
}
