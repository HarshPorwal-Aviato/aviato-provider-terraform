variable "project_id" {
  type        = string
  description = "The ID of the project"
  default     = "aviato-game-fight-rvxirf"
}

variable "location" {
  type        = string
  description = "Location for resources"
  default     = "US"
}

variable "default_ssh_source_range" {
  type        = list(string)
  description = "Source ranges for default ssh firewall rule"
  default     = ["10.0.0.0/8"]
}

variable "default_rdp_source_range" {
  type        = list(string)
  description = "Source ranges for default rdp firewall rule"
  default     = ["10.0.0.0/8"]
}

variable "log_sink_destination" {
  type = string
  description = "The destination for the log sink"
  default = "YOUR_LOG_SINK_BUCKET_NAME"
}

variable "log_sink_filter" {
  type = string
  description = "The filter for the log sink"
  default = ""
}

variable "default_regions" {
  type = list(string)
  description = "List of regions where default subnets exist"
  default = [
    "asia-east1",
    "asia-east2",
    "asia-northeast1",
    "asia-northeast2",
    "asia-northeast3",
    "asia-south1",
    "asia-south2",
    "asia-southeast1",
    "asia-southeast2",
    "australia-southeast1",
    "australia-southeast2",
    "europe-central2",
    "europe-north1",
    "europe-north2",
    "europe-southwest1",
    "europe-west1",
    "europe-west10",
    "europe-west12",
    "europe-west2",
    "europe-west3",
    "europe-west4",
    "europe-west6",
    "europe-west8",
    "europe-west9",
    "me-central1",
    "me-central2",
    "me-west1",
    "northamerica-northeast1",
    "northamerica-northeast2",
    "northamerica-south1",
    "southamerica-east1",
    "southamerica-west1",
    "us-central1",
    "us-east1",
    "us-east4",
    "us-east5",
    "us-south1",
    "us-west1",
    "us-west2",
    "us-west3",
    "us-west4"
  ]
}
