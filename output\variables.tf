variable "project_id" {
  type        = string
  description = "The ID of the project"
  default     = "aviato-game-fight-rvxirf"
}

variable "regions" {
  type    = list(string)
  default = [
    "africa-south1",
    "southamerica-west1",
    "us-west4",
    "me-central2",
    "asia-east2",
    "asia-northeast1",
    "asia-south2",
    "asia-northeast3",
    "us-south1",
    "australia-southeast1",
    "us-east4",
    "us-west3",
    "asia-southeast1",
    "europe-southwest1",
    "asia-east1",
    "europe-north2",
    "australia-southeast2",
    "northamerica-northeast2",
    "asia-southeast2",
    "northamerica-northeast1",
    "asia-south1",
    "europe-west6",
    "europe-west1",
    "southamerica-east1",
    "asia-northeast2",
    "europe-north1",
    "us-east5",
    "us-west2",
    "us-west1",
    "europe-west10",
    "us-central1",
    "northamerica-south1",
    "europe-west4",
    "europe-west9",
    "europe-west2",
    "europe-west12",
    "europe-west8",
    "me-central1",
    "europe-west3",
    "us-east1",
    "europe-central2",
    "me-west1"
  ]
  description = "List of regions to enable VPC flow logs"
}

variable "default_network_deletion" {
  type        = bool
  description = "Enable deletion of default network"
  default     = true
}

variable "api_key_rotation_period" {
  type        = number
  description = "The number of days after which API keys should be rotated"
  default     = 90
}

variable "uniform_bucket_level_access_buckets" {
  type = list(string)
  default = [
    "aviato-game-fight-rvxirf.appspot.com",
    "aviato-game-fight-rvxirf_bucket",
    "staging.aviato-game-fight-rvxirf.appspot.com"
  ]
  description = "List of cloud storage buckets to enable uniform bucket level access"
}

variable "service_accounts_to_remove_admin_privileges" {
  type = list(string)
  default = [
    "twitch-login@aviato-game-fight-rvxirf.iam.gserviceaccount.com",
    "aviato-game-fight-rvxirf@appspot.gserviceaccount.com",
    "30647320905-compute@developer.gserviceaccount.com",
    "firebase-adminsdk-d21rv@aviato-game-fight-rvxirf.iam.gserviceaccount.com"
  ]
  description = "List of service accounts from which to remove admin privileges"
}
