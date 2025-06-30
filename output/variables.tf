variable "project_id" {
  type        = string
  description = "The ID of the project"
  default     = "aviato-game-fight-rvxirf"
}

variable "gcp_region" {
  type        = string
  description = "The GCP region to deploy resources to."
  default     = "us-central1"
}

variable "allowed_ssh_cidrs" {
  type = list(string)
  description = "List of CIDR blocks allowed for SSH access"
  default = ["10.0.0.0/8"]
}

variable "allowed_rdp_cidrs" {
  type = list(string)
  description = "List of CIDR blocks allowed for RDP access"
  default = ["10.0.0.0/8"]
}

variable "bucket_names" {
  type = list(string)
  description = "List of bucket names to apply uniform bucket level access."
  default = [
    "aviato-game-fight-rvxirf.appspot.com",
    "aviato-game-fight-rvxirf_bucket",
    "staging.aviato-game-fight-rvxirf.appspot.com"
  ]
}

variable "default_subnet_regions" {
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
    "europe-west2",
    "europe-west3",
    "europe-west4",
    "europe-west6",
    "europe-west8",
    "europe-west9",
    "europe-west10",
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
