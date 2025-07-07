terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.68.0"
    }
  }
}

provider "google" {
  project = var.project_id
}

resource "google_project_service_identity" "gcr_service_account" {
  provider = google
  project  = var.project_id
  service  = "containerregistry.googleapis.com"
}

resource "google_project_service_identity" "artifactregistry_service_account" {
  provider = google
  project  = var.project_id
  service  = "artifactregistry.googleapis.com"
}

resource "google_container_registry" "default" {
  project = var.project_id
  location = "US"
}

resource "google_artifact_registry_repository" "default" {
  provider = google
  project  = var.project_id
  location = "us-central1"
  repository_id = "my-repo"
  format = "DOCKER"
}

resource "google_project_service" "artifactregistry" {
  provider = google
  project  = var.project_id
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudasset" {
  provider = google
  project  = var.project_id
  service            = "cloudasset.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "apikeys" {
  provider = google
  project  = var.project_id
  service            = "apikeys.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_project_metadata" "oslogin" {
  provider = google
  project = var.project_id
  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_compute_network" "default" {
  provider = google
  name                    = var.default_network_name
  project                 = var.project_id
  delete_default_routes_on_create = true
}

resource "google_compute_firewall" "rdp" {
  provider = google
  name    = "default-allow-rdp"
  project = var.project_id
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["rdp"]
}

resource "google_compute_firewall" "ssh" {
  provider = google
  name    = "default-allow-ssh"
  project = var.project_id
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["ssh"]
}

resource "google_compute_network" "default_network_dns_logging" {
  provider = google
  name                    = var.default_network_name
  project                 = var.project_id
  delete_default_routes_on_create = true
  enable_logging = true
}

resource "google_logging_project_sink" "default" {
  provider = google
  name        = "all-logs"
  project     = var.project_id
  description = "sink for all logs"
  destination = "bigquery.googleapis.com/projects/${var.project_id}/datasets/logging_dataset"
  filter      = "NOT logName:projects/${var.project_id}/logs/cloudaudit.googleapis.com%2Fdata_access"

}

resource "google_bigquery_dataset" "dataset" {
  provider = google
  dataset_id = "logging_dataset"
  project = var.project_id
}

resource "google_logging_metric" "audit_configuration_changes" {
  provider = google
  name        = "audit-configuration-changes"
  project     = var.project_id
  description = "alert on audit configuration changes"
  filter      = "resource.type=audited_resource AND protoPayload.methodName=SetIamPolicy OR protoPayload.methodName=google.cloud.audit.AuditPolicies.UpdateAuditConfig"

  metric_descriptor {
    launch_stage = "BETA"
    metric_kind  = "COUNTER"
    value_type  = "INT64"
    unit         = "1"
  }
}

resource "google_monitoring_alert_policy" "audit_configuration_changes" {
  provider = google
  project     = var.project_id
  display_name = "Audit Configuration Changes"
  combiner     = "OR"
  conditions {
    display_name = "Metric threshold"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/audit-configuration-changes\" resource.type = \"gcp_project\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
    }
  }
}

resource "google_logging_metric" "bucket_permission_changes" {
  provider = google
  name        = "bucket-permission-changes"
  project     = var.project_id
  description = "alert on bucket permission changes"
  filter      = "resource.type=gcs_bucket AND protoPayload.methodName=storage.setIamPermissions"

  metric_descriptor {
    launch_stage = "BETA"
    metric_kind  = "COUNTER"
    value_type  = "INT64"
    unit         = "1"
  }
}

resource "google_monitoring_alert_policy" "bucket_permission_changes" {
  provider = google
  project     = var.project_id
  display_name = "Bucket Permission Changes"
  combiner     = "OR"
  conditions {
    display_name = "Metric threshold"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/bucket-permission-changes\" resource.type = \"gcp_project\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
    }
  }
}

resource "google_logging_metric" "custom_role_changes" {
  provider = google
  name        = "custom-role-changes"
  project     = var.project_id
  description = "alert on custom role changes"
  filter      = "resource.type=iam_role AND protoPayload.methodName=google.iam.admin.v1.CreateRole OR protoPayload.methodName=google.iam.admin.v1.UpdateRole OR protoPayload.methodName=google.iam.admin.v1.DeleteRole"

  metric_descriptor {
    launch_stage = "BETA"
    metric_kind  = "COUNTER"
    value_type  = "INT64"
    unit         = "1"
  }
}

resource "google_monitoring_alert_policy" "custom_role_changes" {
  provider = google
  project     = var.project_id
  display_name = "Custom Role Changes"
  combiner     = "OR"
  conditions {
    display_name = "Metric threshold"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/custom-role-changes\" resource.type = \"gcp_project\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
    }
  }
}

resource "google_logging_metric" "project_ownership_changes" {
  provider = google
  name        = "project-ownership-changes"
  project     = var.project_id
  description = "alert on project ownership changes"
  filter      = "resource.type=project AND protoPayload.methodName=SetIamPolicy"

  metric_descriptor {
    launch_stage = "BETA"
    metric_kind  = "COUNTER"
    value_type  = "INT64"
    unit         = "1"
  }
}

resource "google_monitoring_alert_policy" "project_ownership_changes" {
  provider = google
  project     = var.project_id
  display_name = "Project Ownership Changes"
  combiner     = "OR"
  conditions {
    display_name = "Metric threshold"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/project-ownership-changes\" resource.type = \"gcp_project\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
    }
  }
}

resource "google_logging_metric" "sql_instance_configuration_changes" {
  provider = google
  name        = "sql-instance-configuration-changes"
  project     = var.project_id
  description = "alert on sql instance configuration changes"
  filter      = "resource.type=cloudsql_database AND protoPayload.methodName=cloudsql.instances.update"

  metric_descriptor {
    launch_stage = "BETA"
    metric_kind  = "COUNTER"
    value_type  = "INT64"
    unit         = "1"
  }
}

resource "google_monitoring_alert_policy" "sql_instance_configuration_changes" {
  provider = google
  project     = var.project_id
  display_name = "SQL Instance Configuration Changes"
  combiner     = "OR"
  conditions {
    display_name = "Metric threshold"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/sql-instance-configuration-changes\" resource.type = \"gcp_project\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
    }
  }
}

resource "google_logging_metric" "vpc_firewall_rule_changes" {
  provider = google
  name        = "vpc-firewall-rule-changes"
  project     = var.project_id
  description = "alert on vpc firewall rule changes"
  filter      = "resource.type=gce_firewall_rule AND protoPayload.methodName=compute.firewalls.insert OR protoPayload.methodName=compute.firewalls.delete"

  metric_descriptor {
    launch_stage = "BETA"
    metric_kind  = "COUNTER"
    value_type  = "INT64"
    unit         = "1"
  }
}

resource "google_monitoring_alert_policy" "vpc_firewall_rule_changes" {
  provider = google
  project     = var.project_id
  display_name = "VPC Firewall Rule Changes"
  combiner     = "OR"
  conditions {
    display_name = "Metric threshold"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-firewall-rule-changes\" resource.type = \"gcp_project\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
    }
  }
}

resource "google_logging_metric" "vpc_network_changes" {
  provider = google
  name        = "vpc-network-changes"
  project     = var.project_id
  description = "alert on vpc network changes"
  filter      = "resource.type=gce_network AND protoPayload.methodName=compute.networks.insert OR protoPayload.methodName=compute.networks.delete"

  metric_descriptor {
    launch_stage = "BETA"
    metric_kind  = "COUNTER"
    value_type  = "INT64"
    unit         = "1"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_changes" {
  provider = google
  project     = var.project_id
  display_name = "VPC Network Changes"
  combiner     = "OR"
  conditions {
    display_name = "Metric threshold"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-network-changes\" resource.type = \"gcp_project\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
    }
  }
}

resource "google_logging_metric" "vpc_network_route_changes" {
  provider = google
  name        = "vpc-network-route-changes"
  project     = var.project_id
  description = "alert on vpc network route changes"
  filter      = "resource.type=gce_route AND protoPayload.methodName=compute.routes.insert OR protoPayload.methodName=compute.routes.delete"

  metric_descriptor {
    launch_stage = "BETA"
    metric_kind  = "COUNTER"
    value_type  = "INT64"
    unit         = "1"
  }
}

resource "google_monitoring_alert_policy" "vpc_network_route_changes" {
  provider = google
  project     = var.project_id
  display_name = "VPC Network Route Changes"
  combiner     = "OR"
  conditions {
    display_name = "Metric threshold"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/vpc-network-route-changes\" resource.type = \"gcp_project\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "60s"
    }
  }
}

resource "google_project_iam_binding" "project" {
  provider = google
  project = var.project_id
  role = "roles/viewer"
  members = [
    "user:test@example.com",
  ]
}

resource "google_project_iam_audit_config" "audit_config" {
  provider = google
  project = var.project_id
  service = "allServices"

  audit_log_config {
    log_type = "ADMIN_READ"
  }

   audit_log_config {
    log_type = "DATA_READ"
  }

   audit_log_config {
    log_type = "DATA_WRITE"
  }
}

resource "google_organization_iam_binding" "org_iam" {
  org_id = "478439067989"
  role = "roles/viewer"
  members = [
    "user:test@example.com"
  ]
}

resource "google_folder_iam_binding" "folder_iam" {
  folder = "folders/11111111"
  role = "roles/viewer"
  members = [
    "user:test@example.com"
  ]
}

resource "google_folder_iam_audit_config" "folder_audit_config" {
  folder = "folders/11111111"
  service = "allServices"

  audit_log_config {
    log_type = "ADMIN_READ"
  }

  audit_log_config {
    log_type = "DATA_READ"
  }

  audit_log_config {
    log_type = "DATA_WRITE"
  }
}

resource "google_project_iam_member" "service_account_admin" {
  provider = google
  project = var.project_id
  role   = "roles/iam.serviceAccountAdmin"
  member = "user:test@example.com"
}

resource "google_project_iam_binding" "no_service_account_token_creator" {
  provider = google
  project = var.project_id
  role = "roles/iam.serviceAccountTokenCreator"
  members = []
}

resource "google_project_iam_binding" "no_service_account_user" {
  provider = google
  project = var.project_id
  role = "roles/iam.serviceAccountUser"
  members = []
}

resource "google_service_account_iam_binding" "service_account_iam_binding" {
  provider = google
  service_account_id = "projects/${var.project_id}/serviceAccounts/${var.service_account_emails[0]}"
  role               = "roles/viewer"
  members          = ["user:test@example.com"]
}

resource "google_organization_iam_binding" "org" {
  org_id  = "123456789"
  role    = "roles/viewer"
  members = ["user:test@example.com"]
}

resource "google_folder_iam_member" "mem" {
  folder = "folders/123456789"
  role   = "roles/viewer"
  member = "user:test@example.com"
}

resource "google_project_iam_member" "project_mem" {
  project = var.project_id
  role    = "roles/viewer"
  member  = "user:test@example.com"
}

resource "google_project_default_service_accounts" "project" {
  project = var.project_id
  action  = "DISABLE"
}

resource "google_project_iam_binding" "project_binding" {
  project = var.project_id
  role = "roles/viewer"
  members = ["user:test@example.com"]
}

resource "google_organization_iam_policy" "org_policy" {
  org_id  = "123456789"
  policy_data = data.google_iam_policy.policy.policy_data
}

resource "google_folder_iam_policy" "folder_policy" {
  folder  = "folders/123456789"
  policy_data = data.google_iam_policy.policy.policy_data
}

data "google_iam_policy" "policy" {
  binding {
    role = "roles/viewer"
    members = ["user:test@example.com"]
  }
}

resource "google_project_iam_policy" "project_policy" {
  project     = var.project_id
  policy_data = data.google_iam_policy.project_policy.policy_data
}

data "google_project_iam_policy" "project_policy" {
  binding {
    role = "roles/viewer"
    members = ["user:test@example.com"]
  }
}

resource "google_cloudfunctions2_function" "function" {
 location = "us-central1"
  name     = "function"
 project = var.project_id
 build_config {
   entry_point = "Run"
   runtime     = "nodejs16"
 }
 service_config {
   max_instance_count = 1
   min_instance_count = 1
 }
}

resource "google_app_engine_application" "app" {
  project = var.project_id
 location_id = "us-central"
}

resource "google_app_engine_service_split_traffic" "split_traffic" {
  project = var.project_id
  service = "default"
  split {
    by_network = {
      network = "default"
    }
  }
}

resource "google_network_connectivity_service_connection_policy" "service_connection_policy" {
  location = "us-central1"
  name     = "service_connection_policy"
  project = var.project_id
 psc_config {
   subnetworks = ["default"]
   subnetworks = ["default"]
 }
}

resource "google_network_connectivity_service_connection_map" "service_connection_map" {
  location = "us-central1"
  name     = "service_connection_map"
  project = var.project_id
 service_class = "google-apis"
}

resource "google_compute_router_peer" "peer" {
  name                         = "peer"
  project                      = var.project_id
  router                       = "router"
  region                       = "us-central1"
  advertised_route_priority    = 100
  peer_asn                     = 65001
  peer_ip_address              = "169.254.20.2"
  router_appliance_instance    = "instance"
}

resource "google_compute_ha_vpn_gateway" "ha_vpn_gateway" {
  name    = "ha_vpn_gateway"
  project = var.project_id
  region  = "us-central1"
}

resource "google_compute_vpn_tunnel" "vpn_tunnel" {
  name               = "vpn_tunnel"
  project            = var.project_id
  region             = "us-central1"
  ike_version        = 2
  local_traffic_selector = ["10.0.1.0/24"]
  peer_traffic_selector  = ["10.0.2.0/24"]
  router             = "router"
  target_vpn_gateway = "ha_vpn_gateway"
}

resource "google_service_networking_connection" "connection" {
  network                 = "networks/default"
  reserved_peering_ranges = ["default"]
 service                 = "servicenetworking.googleapis.com"
  project                 = var.project_id
}

resource "google_compute_global_network_endpoint_group" "global_network_endpoint_group" {
  name               = "global_network_endpoint_group"
  default_port         = 80
  network              = "default"
  project                 = var.project_id
  global = true
}

resource "google_compute_network_endpoint_group" "network_endpoint_group" {
  name               = "network_endpoint_group"
  default_port         = 80
  network              = "default"
  project                 = var.project_id
 location_id = "us-central1"
}

resource "google_compute_backend_service" "backend_service" {
  name               = "backend_service"
  project                 = var.project_id
 health_checks          = ["default"]
}

resource "google_compute_region_backend_service" "region_backend_service" {
  name               = "region_backend_service"
  project                 = var.project_id
  region                    = "us-central1"
 health_checks          = ["default"]
}

resource "google_compute_global_address" "global_address" {
  name         = "global_address"
  project      = var.project_id
 address_type = "EXTERNAL"
}

resource "google_compute_address" "address" {
  name         = "address"
  project      = var.project_id
  region       = "us-central1"
  address_type = "EXTERNAL"
}

resource "google_compute_global_forwarding_rule" "global_forwarding_rule" {
  name         = "global_forwarding_rule"
  project      = var.project_id
  port_range      = "80-80"
  target      = "default"
  ip_address = "global_address"
}

resource "google_compute_forwarding_rule" "forwarding_rule" {
  name         = "forwarding_rule"
  project      = var.project_id
  region       = "us-central1"
  port_range      = "80-80"
  target      = "default"
  ip_address = "address"
}

resource "google_compute_router" "router" {
  bgp {
    asn = 65000
  }
  name    = "router"
  network = "default"
  project = var.project_id
  region  = "us-central1"
}

resource "google_compute_instance" "instance" {
  name         = "instance"
  project      = var.project_id
  machine_type = "e2-medium"
  zone         = "us-central1-a"
 boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
 network_interface {
    network = "default"
  }
}

resource "google_network_connectivity_spoke" "spoke" {
 location = "us-central1"
  name     = "spoke"
  project = var.project_id
 hub      = "hub"
}

resource "google_network_connectivity_hub" "hub" {
 location = "us-central1"
  name     = "hub"
  project = var.project_id
}

resource "google_compute_firewall_policy" "firewall_policy" {
 location = "us-central1"
  name     = "firewall_policy"
  project = var.project_id
}

resource "google_compute_firewall_policy_rule" "firewall_policy_rule" {
 location = "us-central1"
  name     = "firewall_policy_rule"
  project = var.project_id
 firewall_policy = "firewall_policy"
}

resource "google_dataproc_cluster" "dataproc_cluster" {
  project      = var.project_id
  region       = "us-central1"
  cluster_config {
  }
  name         = "dataproc_cluster"
}

resource "google_dataflow_job" "dataflow_job" {
  project             = var.project_id
  region              = "us-central1"
 name                = "dataflow_job"
  template_gcs_path = "template_gcs_path"
}

resource "google_cloudbuildv2_connection" "cloudbuildv2_connection" {
  location = "us-central1"
 name     = "cloudbuildv2_connection"
  project = var.project_id
 gitlab_config {
    service_directory = "default"
  }
}

resource "google_endpoints_service" "endpoints_service" {
  config_id = "config_id"
  project   = var.project_id
  service_name  = "default"
}

resource "google_secret_manager_secret" "secret" {
 project   = var.project_id
 replication {
    automatic {}
  }
  secret_id = "default"
}

resource "google_storage_bucket_iam_binding" "bucket_iam_binding" {
 bucket = "bucket"
  members = ["user:test@example.com"]
  role   = "roles/viewer"
}

resource "google_storage_bucket_iam_member" "bucket_iam_member" {
 bucket = "bucket"
  member = "user:test@example.com"
  role   = "roles/viewer"
}

resource "google_storage_transfer_job" "transfer_job" {
 project                  = var.project_id
  description            = "default"
  name                     = "transfer_job"
  transfer_spec {
    aws_s3_data_source {
      bucket_name = "bucket_name"
      aws_access_key {
        access_key_id     = "access_key_id"
        secret_access_key = "secret_access_key"
      }
    }
    gcs_data_sink {
      bucket_name = "bucket_name"
    }
  }
}

resource "google_kms_crypto_key" "crypto_key" {
 key_ring   = "key_ring"
  name       = "crypto_key"
  project    = var.project_id
}

resource "google_monitoring_uptime_check_config" "uptime_check_config" {
  project = var.project_id
 display_name = "uptime_check_config"
  http_check {
    port = 80
  }
  monitored_resource {
    labels {
      host = "default"
    }
    type = "uptime_url"
  }
}

resource "google_monitoring_dashboard" "dashboard" {
  project = var.project_id
  dashboard_json = jsonencode({
    "category": "default",
    "displayName": "default",
  })
}

resource "google_gke_hub_feature" "feature" {
  project = var.project_id
 location = "global"
  name    = "feature"
}

resource "google_gke_hub_feature_membership" "feature_membership" {
  project = var.project_id
 location = "global"
  name     = "feature_membership"
 feature  = "feature"
 membership = "membership"
}

resource "google_gke_hub_membership" "membership" {
  project = var.project_id
 location = "global"
  name     = "membership"
  endpoint {
    gke_cluster {
      resource_link = "default"
    }
  }
}

resource "google_migration_center_preference_set" "preference_set" {
 location = "us-central1"
  name     = "preference_set"
  project = var.project_id
 virtual_machine_preferences {
    sizing_optimization_strategy = "default"
    target_product               = "default"
    commitment_plan {
      commitment_years = 1
    }
    machine_preferences {
      allowed_machine_series {
        machine_series = "default"
      }
    }
    region_preferences {
      regions = ["us-central1"]
    }
  }
}

resource "google_migration_center_source" "source" {
 location = "us-central1"
  name     = "source"
  project = var.project_id
  description = "default"
  display_name = "default"
  managed_source {
    vmware_vcenter {
  }
  }
}

resource "google_tags_tag_key" "tag_key" {
 location = "us-central1"
  name     = "tag_key"
  project = var.project_id
  description = "default"
}

resource "google_tags_tag_value" "tag_value" {
 location = "us-central1"
  name     = "tag_value"
  project = var.project_id
 tag_key = "tag_key"
}

resource "google_organization_policy" "policy" {
 project  = var.project_id
  constraint = "default"
  policy_type = "default"
}

resource "google_project_organization_policy" "project_policy" {
  project = var.project_id
 constraint = "default"
  policy_type = "default"
}

resource "google_cloudbuild_trigger" "trigger" {
 project   = var.project_id
  name      = "trigger"
  trigger_template {
  }
}

resource "google_scc_notification_config" "notification_config" {
