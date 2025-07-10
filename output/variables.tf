variable "project_id" {
  type        = string
  description = "The ID of the project"
  default     = "aviato-game-fight-rvxirf"
}

variable "regions" {
  type    = list(string)
  default = [
    "asia-east2",
    "asia-south1",
    "us-east4",
    "europe-west9",
    "us-west3",
    "asia-northeast2",
    "me-central2",
    "asia-southeast2",
    "me-central1",
    "us-west1",
    "southamerica-west1",
    "asia-southeast1",
    "australia-southeast2",
    "asia-south2",
    "asia-east1",
    "northamerica-south1",
    "us-east5",
    "australia-southeast1",
    "europe-west1",
    "us-west2",
    "asia-northeast3",
    "asia-northeast1",
    "europe-north2",
    "europe-west12",
    "me-west1",
    "us-east1",
    "northamerica-northeast1",
    "us-south1",
    "us-central1",
    "europe-west2",
    "europe-southwest1",
    "europe-west8",
    "europe-north1",
    "africa-south1",
    "southamerica-east1",
  ]
  description = "List of regions where subnets exist"
}
