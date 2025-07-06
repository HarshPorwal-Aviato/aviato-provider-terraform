resource "google_logging_project_sink" "log_sink" {
  name = "all-logs-to-gcs"
  project = var.project_id
  destination = "storage.googleapis.com/${var.project_id}-logs"
  filter = "NOT logName:projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Fdata_access"
}

resource "google_storage_bucket" "log_bucket" {
  name = "${var.project_id}-logs"
  project = var.project_id
  location = var.region
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_iam_binding" "log_bucket_writer" {
  bucket = google_storage_bucket.log_bucket.name
  role = "roles/storage.objectCreator"
  members = ["serviceAccount:cloud-logs@system.gserviceaccount.com"]
}

resource "google_monitoring_alert_policy" "audit_config_changes" {
  display_name = "Audit Configuration Changes"
  project = var.project_id
  combiner = "OR"
  conditions {
    display_name = "Audit Configuration Changes"
    condition_threshold {
      filter = "resource.type = gcp_project AND log_name = \"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName = (\"SetIamPolicy\" OR \"google.cloud.audit.AuditPolicy.UpdateAuditConfig\")"
      duration = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
      aggregations {
        alignment_period = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }

  notification_channels = []
}

resource "google_monitoring_alert_policy" "bucket_permission_changes" {
  display_name = "Cloud Storage Bucket Permission Changes"
  project = var.project_id
  combiner = "OR"
  conditions {
    display_name = "Cloud Storage Bucket Permission Changes"
    condition_threshold {
      filter = "resource.type = gcs_bucket AND log_name = \"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Fdata_access\" AND protoPayload.methodName = \"storage.setIamPolicy\""
      duration = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
      aggregations {
        alignment_period = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }

  notification_channels = []
}

resource "google_monitoring_alert_policy" "custom_role_changes" {
  display_name = "Custom Role Changes"
  project = var.project_id
  combiner = "OR"
  conditions {
    display_name = "Custom Role Changes"
    condition_threshold {
      filter = "resource.type = gcp_iam_role AND log_name = \"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName = (\"google.iam.admin.v1.CreateRole\" OR \"google.iam.admin.v1.DeleteRole\" OR \"google.iam.admin.v1.UpdateRole\")"
      duration = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
      aggregations {
        alignment_period = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }

  notification_channels = []
}

resource "google_monitoring_alert_policy" "project_ownership_changes" {
  display_name = "Project Ownership Changes"
  project = var.project_id
  combiner = "OR"
  conditions {
    display_name = "Project Ownership Changes"
    condition_threshold {
      filter = "resource.type = gcp_project AND log_name = \"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName = \"SetIamPolicy\" AND protoPayload.request.policy.bindings: \"roles/owner\""
      duration = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
       aggregations {
        alignment_period = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }

  notification_channels = []
}

resource "google_monitoring_alert_policy" "sql_instance_config_changes" {
  display_name = "SQL Instance Configuration Changes"
  project = var.project_id
  combiner = "OR"
  conditions {
    display_name = "SQL Instance Configuration Changes"
    condition_threshold {
      filter = "resource.type = cloudsql_database AND log_name = \"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName = (\"cloudsql.instances.update\" OR \"cloudsql.instances.patch\")"
      duration = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
       aggregations {
        alignment_period = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }

  notification_channels = []
}

resource "google_monitoring_alert_policy" "vpc_firewall_rule_changes" {
  display_name = "VPC Firewall Rule Changes"
  project = var.project_id
  combiner = "OR"
  conditions {
    display_name = "VPC Firewall Rule Changes"
    condition_threshold {
      filter = "resource.type = gcp_firewall_rule AND log_name = \"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName = (\"compute.firewalls.insert\" OR \"compute.firewalls.patch\" OR \"compute.firewalls.delete\")"
      duration = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
       aggregations {
        alignment_period = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }

  notification_channels = []
}

resource "google_monitoring_alert_policy" "vpc_network_changes" {
  display_name = "VPC Network Changes"
  project = var.project_id
  combiner = "OR"
  conditions {
    display_name = "VPC Network Changes"
    condition_threshold {
      filter = "resource.type = gcp_network AND log_name = \"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName = (\"compute.networks.insert\" OR \"compute.networks.patch\" OR \"compute.networks.delete\")"
      duration = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
       aggregations {
        alignment_period = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }

  notification_channels = []
}

resource "google_monitoring_alert_policy" "vpc_network_route_changes" {
  display_name = "VPC Network Route Changes"
  project = var.project_id
  combiner = "OR"
  conditions {
    display_name = "VPC Network Route Changes"
    condition_threshold {
      filter = "resource.type = gcp_route AND log_name = \"projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Factivity\" AND protoPayload.methodName = (\"compute.routes.insert\" OR \"compute.routes.delete\")"
      duration = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0
      aggregations {
        alignment_period = "60s"
        per_series_aligner = "ALIGN_SUM"
      }
    }
  }

  notification_channels = []
}
