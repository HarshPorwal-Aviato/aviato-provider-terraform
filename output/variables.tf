variable "project_id" {
  type        = string
  description = "The ID of the project"
  default     = "aviato-game-fight-rvxirf"
}

variable "location" {
  type        = string
  description = "The location where resources will be created"
  default     = "US"
}

variable "default_vpc_regions" {
  type = list(string)
  default = [
    "us-west1",
    "us-west2",
    "us-west3",
    "us-west4",
    "us-central1",
    "us-east1",
    "us-east4",
    "us-south1",
    "northamerica-northeast1",
    "northamerica-northeast2",
    "southamerica-east1",
    "southamerica-west1",
    "europe-west1",
    "europe-west2",
    "europe-west3",
    "europe-west4",
    "europe-west6",
    "europe-west8",
    "europe-west9",
    "europe-west10",
    "europe-west12",
    "europe-north1",
    "europe-north2",
    "europe-central2",
    "europe-southwest1",
    "asia-east1",
    "asia-east2",
    "asia-northeast1",
    "asia-northeast2",
    "asia-northeast3",
    "asia-southeast1",
    "asia-southeast2",
    "asia-south1",
    "asia-south2",
    "australia-southeast1",
    "australia-southeast2",
    "africa-south1",
    "me-central1",
    "me-central2",
    "me-west1"
  ]
  description = "list of regions where default subnets exits"
}
