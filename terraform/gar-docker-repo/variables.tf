# --- Prefix ---
variable "prefix" {
  type        = string
  description = "Project prefix"
}

locals {
  chart_repo = "${var.prefix}-docker-repo"
}

# --- GCP ---
variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  description = "GCP Region"
}
