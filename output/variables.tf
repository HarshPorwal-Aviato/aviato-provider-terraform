variable "project_id" {
  type        = string
  description = "The ID of the project to configure."
  default     = "aviato-game-fight-rvxirf"
}

variable "bigquery_dataset_id" {
  type        = string
  description = "The ID of the BigQuery dataset to use for logging."
  default     = "gcp_logging_dataset"
}
