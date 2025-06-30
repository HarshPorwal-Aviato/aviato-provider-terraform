resource "google_logging_metric" "audit_configuration_changes" {
  name        = "audit-configuration-changes"
  project     = "aviato-game-fight-rvxirf"
  description = "The metric counts the number of audit configuration changes in GCP project."
  filter      = "resource.type=audited_resource AND protoPayload.methodName=\"SetIamPolicy\""
  metric_descriptor {
    launch_stage = "BETA"
    type         = "INT64"
    unit         = "1"
    display_name = "Audit Configuration Changes"
  }
}

resource "google_logging_metric" "bucket_permission_changes" {
  name        = "bucket-permission-changes"
  project     = "aviato-game-fight-rvxirf"
  description = "The metric counts the number of cloud storage bucket permission changes in GCP project."
  filter      = "resource.type=gcs_bucket AND protoPayload.methodName=\"storage.setIamPermissions\""
  metric_descriptor {
    launch_stage = "BETA"
    type         = "INT64"
    unit         = "1"
    display_name = "Cloud Storage Bucket Permission Changes"
  }
}

resource "google_logging_metric" "custom_role_changes" {
  name        = "custom-role-changes"
  project     = "aviato-game-fight-rvxirf"
  description = "The metric counts the number of custom role changes in GCP project."
  filter      = "resource.type=iam_role AND protoPayload.methodName=\"google.iam.admin.v1.CreateRole\""
  metric_descriptor {
    launch_stage = "BETA"
    type         = "INT64"
    unit         = "1"
    display_name = "Custom Role Changes"
  }
}

resource "google_logging_metric" "project_ownership_changes" {
  name        = "project-ownership-changes"
  project     = "aviato-game-fight-rvxirf"
  description = "The metric counts the number of project ownership changes in GCP project."
  filter      = "resource.type=project AND protoPayload.methodName=\"SetIamPolicy\""
  metric_descriptor {
    launch_stage = "BETA"
    type         = "INT64"
    unit         = "1"
    display_name = "Project Ownership Assignments Changes"
  }
}

resource "google_logging_metric" "sql_instance_configuration_changes" {
  name        = "sql-instance-configuration-changes"
  project     = "aviato-game-fight-rvxirf"
  description = "The metric counts the number of SQL instance configuration changes in GCP project."
  filter      = "resource.type=cloudsql_instance AND protoPayload.methodName=\"cloudsql.instances.update\""
  metric_descriptor {
    launch_stage = "BETA"
    type         = "INT64"
    unit         = "1"
    display_name = "SQL Instance Configuration Changes"
  }
}

resource "google_logging_metric" "vpc_firewall_rule_changes" {
  name        = "vpc-firewall-rule-changes"
  project     = "aviato-game-fight-rvxirf"
  description = "The metric counts the number of VPC network firewall rule changes in GCP project."
