# --- Prefix ---
variable "prefix" {
  type        = string
  description = "Project prefix"
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

# --- Argo CD ---
variable "my_external_ip" {
  type        = string
  description = "My external IP access to Argo CD"
  sensitive   = true
}

locals {
  chart_repo_url = "${var.region}-docker.pkg.dev/${var.project_id}/${var.prefix}-docker-repo"
}

variable "workload_identity_gsa_email" {
  type        = string
  description = "Workload Identity GSA email"
}
