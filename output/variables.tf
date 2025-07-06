variable "project_id" {
  type = string
  description = "The ID of the project in which to provision resources."
  default = "aviato-game-fight-rvxirf"
}

variable "region" {
  type = string
  description = "The region in which to provision resources."
  default = "us-central1"
}

variable "default_ssh_source_ranges" {
  type = list(string)
  description = "Source IP ranges for SSH access."
  default = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}

variable "default_rdp_source_ranges" {
  type = list(string)
  description = "Source IP ranges for RDP access."
  default = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}
