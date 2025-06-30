variable "project_id" {
  type        = string
  description = "The ID of the project"
  default     = "aviato-game-fight-rvxirf"
}

variable "region" {
  type        = string
  description = "The region to deploy resources to"
  default     = "us-central1"
}

variable "default_allowed_ssh_source_ranges" {
  type = list(string)
  default = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16"
  ]
  description = "The allowed source ranges for SSH access"
}

variable "default_allowed_rdp_source_ranges" {
  type = list(string)
  default = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16"
  ]
  description = "The allowed source ranges for RDP access"
}
