terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.24.0"
    }
  }
}

provider "google" {
  project = var.project_id
}

resource "google_project_service_identity" "artifactregistry" {
  provider = google
  project  = var.project_id
  service  = "artifactregistry.googleapis.com"
}

resource "google_artifact_registry_repository" "default" {
  provider = google
  project  = var.project_id
  location = "us-central1"
  repository_id = "default-repository"
  format = "DOCKER"
}

resource "google_project_service" "artifactregistry" {
  provider = google
  project            = var.project_id
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false
  depends_on = [google_project_service_identity.artifactregistry]
}

resource "google_container_analysis_occurrence" "note_occurrence" {
  provider = google
  project  = var.project_id
  note = google_container_analysis_note.note.name
  resource_uri = "https://gcr.io/cloud-marketplace/node:latest"
  effective_severity = "HIGH"
}

resource "google_container_analysis_note" "note" {
  provider = google
  project = var.project_id
  name = "container-analysis-note"
  attestation_authority {
    hint {
      human_readable_name = "Example Container Analysis Note"
    }
  }
}

resource "google_project_service" "containeranalysis" {
  provider = google
  project            = var.project_id
  service            = "containeranalysis.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudasset" {
  provider = google
  project            = var.project_id
  service            = "cloudasset.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "dns" {
  provider = google
  project            = var.project_id
  service            = "dns.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_default_network" "default" {
  provider = google
  project = var.project_id
  action  = "DELETE"
}

resource "google_compute_firewall" "rdp" {
  provider = google
  project = var.project_id
  name    = "default-allow-rdp"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "ssh" {
  provider = google
  project = var.project_id
  name    = "default-allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_project_metadata" "default" {
  provider = google
  project = var.project_id

  metadata = {
    enable-oslogin = "true"
  }
}

resource "google_logging_project_sink" "default_sink" {
  provider = google
  name        = "all-logs"
  project = var.project_id
  destination = "storage.googleapis.com/${var.project_id}-logs-bucket"
  filter      = "resource.type = gce_instance OR resource.type = gae_app OR resource.type = aws_ec2_instance"
}

resource "google_storage_bucket" "default_logs_bucket" {
  provider = google
  name          = "${var.project_id}-logs-bucket"
  project = var.project_id
  location      = "US"
  force_destroy = true
}

resource "google_cloudfunctions_function" "audit_config_changes" {
  provider = google
  available_memory    = 256
  description         = "Alert on Audit Configuration Changes"
  entry_point         = "hello_http"
  ingress_settings    = "ALLOW_ALL"
  name                = "audit-config-changes"
  project = var.project_id
  region              = "us-central1"
  runtime             = "python39"
  source_archive_bucket = google_storage_bucket.audit_functions.name
  source_archive_object = google_storage_bucket_object.audit_config_changes.name
  trigger_http        = true
}

resource "google_cloudfunctions_function" "bucket_permission_changes" {
  provider = google
  available_memory    = 256
  description         = "Alert on Cloud Storage IAM Permission Changes"
  entry_point         = "hello_http"
  ingress_settings    = "ALLOW_ALL"
  name                = "bucket-permission-changes"
  project = var.project_id
  region              = "us-central1"
  runtime             = "python39"
  source_archive_bucket = google_storage_bucket.audit_functions.name
  source_archive_object = google_storage_bucket_object.bucket_permission_changes.name
  trigger_http        = true
}

resource "google_cloudfunctions_function" "custom_role_changes" {
  provider = google
  available_memory    = 256
  description         = "Alert on Custom Role Changes"
  entry_point         = "hello_http"
  ingress_settings    = "ALLOW_ALL"
  name                = "custom-role-changes"
  project = var.project_id
  region              = "us-central1"
  runtime             = "python39"
  source_archive_bucket = google_storage_bucket.audit_functions.name
  source_archive_object = google_storage_bucket_object.custom_role_changes.name
  trigger_http        = true
}

resource "google_cloudfunctions_function" "project_ownership_changes" {
  provider = google
  available_memory    = 256
  description         = "Alert on Project Ownership Assignments/Changes"
  entry_point         = "hello_http"
  ingress_settings    = "ALLOW_ALL"
  name                = "project-ownership-changes"
  project = var.project_id
  region              = "us-central1"
  runtime             = "python39"
  source_archive_bucket = google_storage_bucket.audit_functions.name
  source_archive_object = google_storage_bucket_object.project_ownership_changes.name
  trigger_http        = true
}

resource "google_cloudfunctions_function" "sql_instance_config_changes" {
  provider = google
  available_memory    = 256
  description         = "Alert on SQL Instance Configuration Changes"
  entry_point         = "hello_http"
  ingress_settings    = "ALLOW_ALL"
  name                = "sql-instance-config-changes"
  project = var.project_id
  region              = "us-central1"
  runtime             = "python39"
  source_archive_bucket = google_storage_bucket.audit_functions.name
  source_archive_object = google_storage_bucket_object.sql_instance_config_changes.name
  trigger_http        = true
}

resource "google_cloudfunctions_function" "vpc_firewall_rule_changes" {
  provider = google
  available_memory    = 256
  description         = "Alert on VPC Network Firewall Rule Changes"
  entry_point         = "hello_http"
  ingress_settings    = "ALLOW_ALL"
  name                = "vpc-firewall-rule-changes"
  project = var.project_id
  region              = "us-central1"
  runtime             = "python39"
  source_archive_bucket = google_storage_bucket.audit_functions.name
  source_archive_object = google_storage_bucket_object.vpc_firewall_rule_changes.name
  trigger_http        = true
}

resource "google_cloudfunctions_function" "vpc_network_changes" {
  provider = google
  available_memory    = 256
  description         = "Alert on VPC Network Changes"
  entry_point         = "hello_http"
  ingress_settings    = "ALLOW_ALL"
  name                = "vpc-network-changes"
  project = var.project_id
  region              = "us-central1"
  runtime             = "python39"
  source_archive_bucket = google_storage_bucket.audit_functions.name
  source_archive_object = google_storage_bucket_object.vpc_network_changes.name
  trigger_http        = true
}

resource "google_cloudfunctions_function" "vpc_network_route_changes" {
  provider = google
  available_memory    = 256
  description         = "Alert on VPC Network Route Changes"
  entry_point         = "hello_http"
  ingress_settings    = "ALLOW_ALL"
  name                = "vpc-network-route-changes"
  project = var.project_id
  region              = "us-central1"
  runtime             = "python39"
  source_archive_bucket = google_storage_bucket.audit_functions.name
  source_archive_object = google_storage_bucket_object.vpc_network_route_changes.name
  trigger_http        = true
}

resource "google_storage_bucket" "audit_functions" {
  provider = google
  force_destroy               = true
  location                    = "US"
  name                        = "${var.project_id}-audit-functions"
  project = var.project_id
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "audit_config_changes" {
  provider = google
  bucket               = google_storage_bucket.audit_functions.name
  detect_md5hash       = "j9iPwu8y58BbsLq9XG8X2g=="
  name                 = "audit_config_changes.zip"
  source               = "src/audit_config_changes.zip"
}

resource "google_storage_bucket_object" "bucket_permission_changes" {
  provider = google
  bucket               = google_storage_bucket.audit_functions.name
  detect_md5hash       = "j9iPwu8y58BbsLq9XG8X2g=="
  name                 = "bucket_permission_changes.zip"
  source               = "src/bucket_permission_changes.zip"
}

resource "google_storage_bucket_object" "custom_role_changes" {
  provider = google
  bucket               = google_storage_bucket.audit_functions.name
  detect_md5hash       = "j9iPwu8y58BbsLq9XG8X2g=="
  name                 = "custom_role_changes.zip"
  source               = "src/custom_role_changes.zip"
}

resource "google_storage_bucket_object" "project_ownership_changes" {
  provider = google
  bucket               = google_storage_bucket.audit_functions.name
  detect_md5hash       = "j9iPwu8y58BbsLq9XG8X2g=="
  name                 = "project_ownership_changes.zip"
  source               = "src/project_ownership_changes.zip"
}

resource "google_storage_bucket_object" "sql_instance_config_changes" {
  provider = google
  bucket               = google_storage_bucket.audit_functions.name
  detect_md5hash       = "j9iPwu8y58BbsLq9XG8X2g=="
  name                 = "sql_instance_config_changes.zip"
  source               = "src/sql_instance_config_changes.zip"
}

resource "google_storage_bucket_object" "vpc_firewall_rule_changes" {
  provider = google
  bucket               = google_storage_bucket.audit_functions.name
  detect_md5hash       = "j9iPwu8y58BbsLq9XG8X2g=="
  name                 = "vpc_firewall_rule_changes.zip"
  source               = "src/vpc_firewall_rule_changes.zip"
}

resource "google_storage_bucket_object" "vpc_network_changes" {
  provider = google
  bucket               = google_storage_bucket.audit_functions.name
  detect_md5hash       = "j9iPwu8y58BbsLq9XG8X2g=="
  name                 = "vpc_network_changes.zip"
  source               = "src/vpc_network_changes.zip"
}

resource "google_storage_bucket_object" "vpc_network_route_changes" {
  provider = google
  bucket               = google_storage_bucket.audit_functions.name
  detect_md5hash       = "j9iPwu8y58BbsLq9XG8X2g=="
  name                 = "vpc_network_route_changes.zip"
  source               = "src/vpc_network_route_changes.zip"
}

resource "google_project_iam_member" "cloud_functions_invoker" {
  provider = google
  project = var.project_id
  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
  depends_on = [
    google_cloudfunctions_function.audit_config_changes,
    google_cloudfunctions_function.bucket_permission_changes,
    google_cloudfunctions_function.custom_role_changes,
    google_cloudfunctions_function.project_ownership_changes,
    google_cloudfunctions_function.sql_instance_config_changes,
    google_cloudfunctions_function.vpc_firewall_rule_changes,
    google_cloudfunctions_function.vpc_network_changes,
    google_cloudfunctions_function.vpc_network_route_changes
  ]
}

resource "google_logging_metric" "audit_config_changes" {
  provider = google
  name   = "audit-config-changes"
  project = var.project_id
  filter = "resource.type=audited_resource AND protoPayload.methodName=\"google.cloud.audit.AuditPolicies.SetIamPolicy\""

  metric_descriptor {
    launch_stage = "BETA"
    metric_kind  = "COUNTER"
    value_type   = "INT64"
  }
}

resource "google_logging_metric" "bucket_permission_changes" {
  provider = google
  name   = "bucket-permission-changes"
  project = var.project_id
  filter = "resource.type=gcs_bucket AND protoPayload.methodName=\"storage.setIamPermissions\""

  metric_descriptor {
    launch_stage = "BETA"
    metric_kind  = "COUNTER"
    value_type   = "INT64"
  }
}

resource "google_logging_metric" "custom_role_changes" {
  provider = google
  name   = "custom-role-changes"
  project = var.project_id
  filter = "resource.type=iam_role AND (protoPayload.methodName=\"google.iam.admin.v1.CreateRole\" OR protoPayload.methodName=\"google.iam.admin.v1.DeleteRole\")"

  metric_descriptor {
    launch_stage = "BETA"
    metric_kind  = "COUNTER"
    value_type   = "INT64"
  }
}

resource "google_logging_metric" "project_ownership_changes" {
  provider = google
  name   = "project-ownership-changes"
  project = var.project_id
  filter = "resource.type=project AND protoPayload.methodName=\"SetIamPolicy\" AND protoPayload.request.policy.bindings:NOT(data:\'\')"

  metric_descriptor {
    launch_stage = "BETA"
    metric_kind  = "COUNTER"
    value_type   = "INT64"
  }
}

resource "google_logging_metric" "sql_instance_config_changes" {
  provider = google
  name   = "sql-instance-config-changes"
  project = var.project_id
  filter = "resource.type=cloudsql_instance AND protoPayload.methodName=\"cloudsql.instances.update\""

  metric_descriptor {
    launch_stage = "BETA"
    metric_kind  = "COUNTER"
    value_type   = "INT64"
  }
}

resource "google_logging_metric" "vpc_firewall_rule_changes" {
  provider = google
  name   = "vpc-firewall-rule-changes"
  project = var.project_id
  filter = "resource.type=gce_firewall AND (protoPayload.methodName=\"compute.firewalls.insert\" OR protoPayload.methodName=\"compute.firewalls.delete\")"

  metric_descriptor {
    launch_stage = "BETA"
    metric_kind  = "COUNTER"
    value_type   = "INT64"
  }
}

resource "google_logging_metric" "vpc_network_changes" {
  provider = google
  name   = "vpc-network-changes"
  project = var.project_id
  filter = "resource.type=gce_network AND (protoPayload.methodName=\"compute.networks.insert\" OR protoPayload.methodName=\"compute.networks.delete\")"

  metric_descriptor {
    launch_stage = "BETA"
    metric_kind  = "COUNTER"
    value_type   = "INT64"
  }
}

resource "google_logging_metric" "vpc_network_route_changes" {
  provider = google
  name   = "vpc-network-route-changes"
  project = var.project_id
  filter = "resource.type=gce_route AND (protoPayload.methodName=\"compute.routes.insert\" OR protoPayload.methodName=\"compute.routes.delete\")"

  metric_descriptor {
    launch_stage = "BETA"
    metric_kind  = "COUNTER"
    value_type   = "INT64"
  }
}

resource "google_monitoring_alert_policy" "audit_config_changes" {
  provider = google
  display_name = "Audit Configuration Changes Alert"
  project = var.project_id

  conditions {
    display_name = "Metric Threshold"

    condition_threshold {
      comparison         = "COMPARISON_GT"
      duration           = "60s"
      filter           = "metric.type=\"logging.googleapis.com/user/audit-config-changes\" AND resource.type=\"project\""
      threshold_value    = 0
      trigger {
        count = 1
      }
    }
  }

  alert_strategy {
    auto_close = "604800s"
  }

  notification_channels = []
}

resource "google_monitoring_alert_policy" "bucket_permission_changes" {
  provider = google
  display_name = "Bucket Permission Changes Alert"
  project = var.project_id

  conditions {
    display_name = "Metric Threshold"

    condition_threshold {
      comparison         = "COMPARISON_GT"
      duration           = "60s"
      filter           = "metric.type=\"logging.googleapis.com/user/bucket-permission-changes\" AND resource.type=\"project\""
      threshold_value    = 0
      trigger {
        count = 1
      }
    }
  }

  alert_strategy {
    auto_close = "604800s"
  }

  notification_channels = []
}

resource "google_monitoring_alert_policy" "custom_role_changes" {
  provider = google
  display_name = "Custom Role Changes Alert"
  project = var.project_id

  conditions {
    display_name = "Metric Threshold"

    condition_threshold {
      comparison         = "COMPARISON_GT"
      duration           = "60s"
      filter           = "metric.type=\"logging.googleapis.com/user/custom-role-changes\" AND resource.type=\"project\""
      threshold_value    = 0
      trigger {
        count = 1
      }
    }
  }

  alert_strategy {
    auto_close = "604800s"
  }

  notification_channels = []
}

resource "google_monitoring_alert_policy" "project_ownership_changes" {
  provider = google
  display_name = "Project Ownership Changes Alert"
  project = var.project_id

  conditions {
    display_name = "Metric Threshold"

    condition_threshold {
      comparison         = "COMPARISON_GT"
      duration           = "60s"
      filter           = "metric.type=\"logging.googleapis.com/user/project-ownership-changes\" AND resource.type=\"project\""
      threshold_value    = 0
      trigger {
        count = 1
      }
    }
  }

  alert_strategy {
    auto_close = "604800s"
  }

  notification_channels = []
}

resource "google_monitoring_alert_policy" "sql_instance_config_changes" {
  provider = google
  display_name = "SQL Instance Configuration Changes Alert"
  project = var.project_id

  conditions {
    display_name = "Metric Threshold"

    condition_threshold {
      comparison         = "COMPARISON_GT"
      duration           = "60s"
      filter           = "metric.type=\"logging.googleapis.com/user/sql-instance-config-changes\" AND resource.type=\"project\""
      threshold_value    = 0
      trigger {
        count = 1
      }
    }
  }

  alert_strategy {
    auto_close = "604800s"
  }

  notification_channels = []
}

resource "google_monitoring_alert_policy" "vpc_firewall_rule_changes" {
  provider = google
  display_name = "VPC Firewall Rule Changes Alert"
  project = var.project_id

  conditions {
    display_name = "Metric Threshold"

    condition_threshold {
      comparison         = "COMPARISON_GT"
      duration           = "60s"
      filter           = "metric.type=\"logging.googleapis.com/user/vpc-firewall-rule-changes\" AND resource.type=\"project\""
      threshold_value    = 0
      trigger {
        count = 1
      }
    }
  }

  alert_strategy {
    auto_close = "604800s"
  }

  notification_channels = []
}

resource "google_monitoring_alert_policy" "vpc_network_changes" {
  provider = google
  display_name = "VPC Network Changes Alert"
  project = var.project_id

  conditions {
    display_name = "Metric Threshold"

    condition_threshold {
      comparison         = "COMPARISON_GT"
      duration           = "60s"
      filter           = "metric.type=\"logging.googleapis.com/user/vpc-network-changes\" AND resource.type=\"project\""
      threshold_value    = 0
      trigger {
        count = 1
      }
    }
  }

  alert_strategy {
    auto_close = "604800s"
  }

  notification_channels = []
}

resource "google_monitoring_alert_policy" "vpc_network_route_changes" {
  provider = google
  display_name = "VPC Network Route Changes Alert"
  project = var.project_id

  conditions {
    display_name = "Metric Threshold"

    condition_threshold {
      comparison         = "COMPARISON_GT"
      duration           = "60s"
      filter           = "metric.type=\"logging.googleapis.com/user/vpc-network-route-changes\" AND resource.type=\"project\""
      threshold_value    = 0
      trigger {
        count = 1
      }
    }
  }

  alert_strategy {
    auto_close = "604800s"
  }

  notification_channels = []
}

resource "google_project_iam_binding" "no_service_account_user" {
  provider = google
  project = var.project_id
  role = "roles/iam.serviceAccountUser"
  members = []
}

resource "google_project_iam_binding" "no_service_account_token_creator" {
  provider = google
  project = var.project_id
  role = "roles/iam.serviceAccountTokenCreator"
  members = []
}

resource "google_project_iam_custom_role" "sa_separation_of_duties" {
  provider = google
  project = var.project_id
  role_id = "serviceAccountSeparationOfDuties"
  title = "Service Account Separation of Duties"
  description = "Enforce Separation of Duties for Service-Account Related Roles"

  permissions = [
    "iam.serviceAccounts.actAs",
    "iam.serviceAccounts.getAccessToken",
    "iam.serviceAccounts.getOpenIdToken",
    "iam.serviceAccounts.implicitDelegation",
    "iam.serviceAccounts.list",
    "iam.serviceAccounts.signBlob",
    "iam.serviceAccounts.signJwt"
  ]
}

resource "google_project_iam_member" "remove_admin_privileges_sa_twitch" {
  provider = google
  project = var.project_id
  role = "roles/viewer"
  member = "serviceAccount:twitch-login@${var.project_id}.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "remove_admin_privileges_sa_appspot" {
  provider = google
  project = var.project_id
  role = "roles/viewer"
  member = "serviceAccount:${var.project_id}@appspot.gserviceaccount.com"
}

resource "google_project_iam_member" "remove_admin_privileges_sa_compute" {
  provider = google
  project = var.project_id
  role = "roles/viewer"
  member = "serviceAccount:30647320905-compute@developer.gserviceaccount.com"
}

resource "google_project_iam_member" "remove_admin_privileges_sa_firebase" {
  provider = google
  project = var.project_id
  role = "roles/viewer"
  member = "serviceAccount:firebase-adminsdk-d21rv@${var.project_id}.iam.gserviceaccount.com"
}

resource "google_compute_subnetwork" "default" {
  provider = google
  for_each = toset(var.regions)
  name                     = "default"
  ip_cidr_range            = "10.10.10.0/24"
  network                  = "default"
  project                  = var.project_id
  region                   = each.value
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_storage_bucket" "buckets" {
  provider = google
  for_each = toset(var.bucket_names)
  name          = each.value
  project       = var.project_id
  location      = "AUSTRALIA-SOUTHEAST1"
  force_destroy = true
  uniform_bucket_level_access = true
}

resource "google_project_iam_member" "apikeys_disable" {
  provider = google
  project = var.project_id
  role = "roles/apikeys.viewer"
  member = "allUsers"
}

resource "google_project_service" "apikeys" {
  provider = google
  project            = var.project_id
  service            = "apikeys.googleapis.com"
  disable_on_destroy = true
}

resource "google_apikeys_key" "api_key" {
  provider = google
  for_each = toset(var.api_keys)
  name         = each.value
  project = var.project_id
  restrictions {
    browser_key {
      allowed_referrers = ["*"]
    }
  }
}
