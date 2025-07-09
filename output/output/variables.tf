variable "project_id" {
  type        = string
  description = "The ID of the project in which to provision resources."
  default     = "aviato-game-fight-rvxirf"
}

variable "regions" {
  type    = list(string)
  default = [
    "europe-west10",
    "europe-west8",
    "europe-west12",
    "australia-southeast2",
    "southamerica-west1",
    "asia-southeast1",
    "us-east5",
    "europe-west3",
    "asia-south1",
    "asia-northeast1",
    "asia-east2",
    "northamerica-northeast2",
    "me-west1",
    "asia-south2",
    "europe-west1",
    "australia-southeast1",
    "northamerica-south1",
    "asia-east1",
    "europe-southwest1",
    "asia-southeast2",
    "us-west3",
    "europe-west2",
    "asia-northeast2",
    "us-west1",
    "europe-north2",
    "us-south1",
    "us-central1",
    "northamerica-northeast1",
    "europe-west6",
    "europe-west9",
    "europe-central2",
    "us-west4",
    "me-central2",
    "asia-northeast3",
    "southamerica-east1",
    "us-west2",
    "us-east4",
    "europe-north1",
    "us-east1"
  ]
}

variable "default_allow_ssh_source_ranges" {
  type    = list(string)
  default = ["0.0.0.0/0"]
  description = "The allowed address ranges for SSH access."
}

variable "default_allow_rdp_source_ranges" {
  type = list(string)
  default = ["0.0.0.0/0"]
  description = "The allowed address ranges for RDP access."
}
