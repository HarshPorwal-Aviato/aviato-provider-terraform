data "google_project" "project" {
  project_id = "aviato-game-fight-rvxirf"
}

resource "google_project_iam_member" "service_account_twitch_login" {
  project = "aviato-game-fight-rvxirf"
  role    = "roles/viewer"
  member  = "serviceAccount:twitch-login@aviato-game-fight-rvxirf.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "service_account_appspot" {
  project = "aviato-game-fight-rvxirf"
  role    = "roles/viewer"
  member  = "serviceAccount:aviato-game-fight-rvxirf@appspot.gserviceaccount.com"
}

resource "google_project_iam_member" "service_account_compute" {
  project = "aviato-game-fight-rvxirf"
  role    = "roles/viewer"
  member  = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
}

resource "google_project_iam_member" "service_account_firebase" {
  project = "aviato-game-fight-rvxirf"
  role    = "roles/viewer"
  member  = "serviceAccount:firebase-adminsdk-d21rv@aviato-game-fight-rvxirf.iam.gserviceaccount.com"
}

resource "google_iam_service_account_key" "key_twitch_login" {
  service_account_id = "twitch-login@aviato-game-fight-rvxirf.iam.gserviceaccount.com"
  disabled= true
}

resource "google_iam_service_account_key" "key_compute" {
  service_account_id = "${data.google_project.project.number}-compute@developer.gserviceaccount.com"
    disabled= true
}

resource "google_logging_metric" "audit_config_changes" {
  name        = "audit-config-changes"
  project     = "aviato-game-fight-rvxirf"
  description = "Log metric filter for audit configuration changes"
  filter      = "resource.type=audited_resource AND protoPayload.methodName=google.cloud.audit.AuditPolicies.UpdateAuditConfig"

  metric_descriptor {
    launch_stage = "BETA"
    type         = "counter"
    value_type   = "INT64"
  }
}

resource "google_monitoring_alert_policy" "audit_config_changes_alert" {
  display_name = "Audit Configuration Changes Alert"
  project = "aviato-game-fight-rvxirf"
  combiner = "OR"

  conditions {
    display_name = "Audit Configuration Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/audit-config-changes\" AND resource.type=\"global\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
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
    project     = "aviato-game-fight-rvxirf"
  description = "Log metric filter for Cloud Storage bucket IAM permission changes"
  filter      = "resource.type=gcs_bucket AND protoPayload.methodName=storage.setIamPermissions"

  metric_descriptor {
    launch_stage = "BETA"
    type         = "counter"
    value_type   = "INT64"
  }
}

resource "google_monitoring_alert_policy" "bucket_permission_changes_alert" {
  display_name = "Cloud Storage IAM Permission Changes Alert"
  project = "aviato-game-fight-rvxirf"
  combiner = "OR"

  conditions {
    display_name = "Cloud Storage IAM Permission Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/bucket-permission-changes\" AND resource.type=\"gcs_bucket\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
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
  project     = "aviato-game-fight-rvxirf"
  description = "Log metric filter for custom role changes"
  filter      = "resource.type=iam_role AND protoPayload.methodName=(google.iam.admin.v1.CreateRole OR google.iam.admin.v1.DeleteRole OR google.iam.admin.v1.UpdateRole)"

  metric_descriptor {
    launch_stage = "BETA"
    type         = "counter"
    value_type   = "INT64"
  }
}

resource "google_monitoring_alert_policy" "custom_role_changes_alert" {
  display_name = "Custom Role Changes Alert"
  project = "aviato-game-fight-rvxirf"
  combiner = "OR"

  conditions {
    display_name = "Custom Role Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/custom-role-changes\" AND resource.type=\"iam_role\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
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
    project     = "aviato-game-fight-rvxirf"
  description = "Log metric filter for project ownership assignments/changes"
  filter      = "resource.type=project AND protoPayload.methodName=SetIamPolicy"

  metric_descriptor {
    launch_stage = "BETA"
    type         = "counter"
    value_type   = "INT64"
  }
}

resource "google_monitoring_alert_policy" "project_ownership_changes_alert" {
  display_name = "Project Ownership Assignments/Changes Alert"
  project = "aviato-game-fight-rvxirf"
  combiner = "OR"

  conditions {
    display_name = "Project Ownership Assignments/Changes Condition"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/project-ownership-changes\" AND resource.type=\"project\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
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
  project     = "aviato-game-fight-rvxirf"
  description
