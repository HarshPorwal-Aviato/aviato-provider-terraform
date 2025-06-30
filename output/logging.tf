resource "google_logging_metric" "audit_configuration_changes" {
  name        = "audit-configuration-changes"
  project     = var.project_id
  description = "Metric for audit configuration changes"
  filter      = "protoPayload.methodName=\"SetIamPolicy\" OR protoPayload.methodName=\"google.cloud.audit.AuditPolicies.UpdateAuditConfig\""
  metric_descriptor {
    launch_stage = "BETA"
    name         = "logging.googleapis.com/user/audit_configuration_changes"
    type         = "GAUGE"
    unit         = "1"
    description  = "Number of audit configuration changes"
    display_name = "Audit Configuration Changes"
  }
}

resource "google_monitoring_alert_policy" "audit_configuration_changes" {
  display_name = "Audit Configuration Changes Alert"
  project      = var.project_id
  combiner     = "OR"

  conditions {
    display_name = "Audit Configuration Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/audit_configuration_changes\" resource.type=\"gcp_project\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
      trigger {
        count = 1
      }
    }
  }

  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }
}

resource "google_logging_metric" "bucket_permission_changes" {
  name        = "bucket-permission-changes"
  project     = var.project_id
  description = "Metric for Cloud Storage IAM permission changes"
  filter      = "resource.type=\"gcs_bucket\" AND protoPayload.methodName=\"storage.setIamPermissions\""
  metric_descriptor {
    launch_stage = "BETA"
    name         = "logging.googleapis.com/user/bucket_permission_changes"
    type         = "GAUGE"
    unit         = "1"
    description  = "Number of Cloud Storage IAM permission changes"
    display_name = "Bucket Permission Changes"
  }
}

resource "google_monitoring_alert_policy" "bucket_permission_changes" {
  display_name = "Cloud Storage IAM Permission Changes Alert"
  project      = var.project_id
  combiner     = "OR"

  conditions {
    display_name = "Bucket Permission Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/bucket_permission_changes\" resource.type=\"gcs_bucket\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
      trigger {
        count = 1
      }
    }
  }

  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }
}

resource "google_logging_metric" "custom_role_changes" {
  name        = "custom-role-changes"
  project     = var.project_id
  description = "Metric for custom role changes"
  filter      = "resource.type=iam_role AND (protoPayload.methodName=\"google.iam.admin.v1.CreateRole\" OR protoPayload.methodName=\"google.iam.admin.v1.DeleteRole\" OR protoPayload.methodName=\"google.iam.admin.v1.UpdateRole\")"
  metric_descriptor {
    launch_stage = "BETA"
    name         = "logging.googleapis.com/user/custom_role_changes"
    type         = "GAUGE"
    unit         = "1"
    description  = "Number of custom role changes"
    display_name = "Custom Role Changes"
  }
}

resource "google_monitoring_alert_policy" "custom_role_changes" {
  display_name = "Custom Role Changes Alert"
  project      = var.project_id
  combiner     = "OR"

  conditions {
    display_name = "Custom Role Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/custom_role_changes\" resource.type=\"iam_role\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
      trigger {
        count = 1
      }
    }
  }

  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }
}

resource "google_logging_metric" "project_ownership_changes" {
  name        = "project-ownership-changes"
  project     = var.project_id
  description = "Metric for project ownership changes"
  filter      = "protoPayload.methodName=\"SetIamPolicy\" AND resource.type=\"project\" AND protoPayload.request.policy.bindings:\"roles/owner\""
  metric_descriptor {
    launch_stage = "BETA"
    name         = "logging.googleapis.com/user/project_ownership_changes"
    type         = "GAUGE"
    unit         = "1"
    description  = "Number of project ownership changes"
    display_name = "Project Ownership Changes"
  }
}

resource "google_monitoring_alert_policy" "project_ownership_changes" {
  display_name = "Project Ownership Changes Alert"
  project      = var.project_id
  combiner     = "OR"

  conditions {
    display_name = "Project Ownership Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/project_ownership_changes\" resource.type=\"gcp_project\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
      trigger {
        count = 1
      }
    }
  }

  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }
}

resource "google_logging_metric" "sql_instance_configuration_changes" {
  name        = "sql-instance-configuration-changes"
  project     = var.project_id
  description = "Metric for SQL Instance configuration changes"
  filter      = "resource.type=\"cloudsql_instance\" AND protoPayload.methodName:(\"cloudsql.instances.update\" OR \"cloudsql.instances.patch\")"
  metric_descriptor {
    launch_stage = "BETA"
    name         = "logging.googleapis.com/user/sql_instance_configuration_changes"
    type         = "GAUGE"
    unit         = "1"
    description  = "Number of SQL instance configuration changes"
    display_name = "SQL Instance Configuration Changes"
  }
}

resource "google_monitoring_alert_policy" "sql_instance_configuration_changes" {
  display_name = "SQL Instance Configuration Changes Alert"
  project      = var.project_id
  combiner     = "OR"

  conditions {
    display_name = "SQL Instance Configuration Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/sql_instance_configuration_changes\" resource.type=\"cloudsql_instance\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
      trigger {
        count = 1
      }
    }
  }

  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }
}

resource "google_logging_metric" "vpc_firewall_rule_changes" {
  name        = "vpc-firewall-rule-changes"
  project     = var.project_id
  description = "Metric for VPC firewall rule changes"
  filter      = "resource.type=\"gce_firewall_rule\" AND (protoPayload.methodName=\"compute.firewalls.insert\" OR protoPayload.methodName=\"compute.firewalls.delete\")"
  metric_descriptor {
    launch_stage = "BETA"
    name         = "logging.googleapis.com/user/vpc_firewall_rule_changes"
    type         = "GAUGE"
    unit         = "1"
    description  = "Number of VPC firewall rule changes"
    display_name = "VPC Firewall Rule Changes"
  }
}

resource "google_monitoring_alert_policy" "vpc_firewall_rule_changes" {
  display_name = "VPC Firewall Rule Changes Alert"
  project      = var.project_id
  combiner     = "OR"

  conditions {
    display_name = "VPC Firewall Rule Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc_firewall_rule_changes\" resource.type=\"gce_firewall_rule\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
      trigger {
        count = 1
      }
    }
  }

  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }
}

resource "google_logging_metric" "vpc_network_changes" {
  name        = "vpc-network-changes"
  project     = var.project_id
  description = "Metric for VPC network changes"
  filter      = "resource.type=\"gce_network\" AND (protoPayload.methodName=\"compute.networks.insert\" OR protoPayload.methodName=\"compute.networks.patch\")"
  metric_descriptor {
    launch_stage = "BETA"
    name         = "logging.googleapis.com/user/vpc_network_changes"
    type         = "GAUGE"
    unit         = "1"
    description  = "Number of VPC network changes"
    display_name = "VPC Network Changes"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_changes" {
  display_name = "VPC Network Changes Alert"
  project      = var.project_id
  combiner     = "OR"

  conditions {
    display_name = "VPC Network Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc_network_changes\" resource.type=\"gce_network\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
      trigger {
        count = 1
      }
    }
  }

  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }
}

resource "google_logging_metric" "vpc_network_route_changes" {
  name        = "vpc-network-route-changes"
  project     = var.project_id
  description = "Metric for VPC network route changes"
  filter      = "resource.type=\"gce_route\" AND (protoPayload.methodName=\"compute.routes.insert\" OR protoPayload.methodName=\"compute.routes.delete\")"
  metric_descriptor {
    launch_stage = "BETA"
    name         = "logging.googleapis.com/user/vpc_network_route_changes"
    type         = "GAUGE"
    unit         = "1"
    description  = "Number of VPC network route changes"
    display_name = "VPC Network Route Changes"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_route_changes" {
  display_name = "VPC Network Route Changes Alert"
  project      = var.project_id
  combiner     = "OR"

  conditions {
    display_name = "VPC Network Route Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc_network_route_changes\" resource.type=\"gce_route\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
      trigger {
        count = 1
      }
    }
  }

  alert_strategy {
    notification_rate_limit {
      period = "300s"
    }
  }
}

resource "google_logging_project_sink" "project_sink" {
  name        = "all-logs-sink"
  project     = var.project_id
  description = "Sink to export all logs to a Cloud Storage bucket"
  destination = "storage.googleapis.com/${var.project_id}-logs"
  filter      = "NOT logName:\"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Fdata_access\""

  unique_writer_identity = true
}

resource "google_storage
