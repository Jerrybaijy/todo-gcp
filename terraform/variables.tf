# --- Prefix ---
variable "prefix" {
  type        = string
  description = "Project prefix"
  default     = "todo"
}

locals {
  gke_name        = "${var.prefix}-cluster"
  node_pool_name  = "${var.prefix}-node-pool"
  app_ns          = "${var.prefix}-ns"
  sa_id           = "${var.prefix}-sa-id"
  ksa_name        = "${var.prefix}-ksa"
  db_instance     = "${var.prefix}-db-instance"
  db_name         = "${var.prefix}_db"
  app_name        = "${var.prefix}-app"
  chart_repo_name = "${var.prefix}-docker-repo"
  chart_name      = "${var.prefix}-chart"
  chart_repo_url  = "${var.region}-docker.pkg.dev/${var.project_id}/${local.chart_repo_name}"
  code_repo_host  = "${var.prefix}-${var.code_repo}-host"
  project_name    = "${var.prefix}-gcp"
  trigger_name    = "${var.prefix}-trigger"
}

# --- GCP ---
variable "project_id" {
  type        = string
  description = "GCP Project ID"
  default     = "project-60addf72-be9c-4c26-8db"
}

variable "region" {
  type        = string
  description = "GCP Region"
  default     = "asia-east2"
}

variable "zone" {
  type        = string
  description = "GCP Zone"
  default     = "asia-east2-a"
}

# --- Cloud SQL ---
variable "mysql_root_password" {
  type        = string
  description = "MySQL root user password"
  sensitive   = true
}

variable "mysql_jerry_password" {
  type        = string
  description = "MySQL jerry user password"
  sensitive   = true
}

# --- Argo CD ---
variable "my_external_ip" {
  type        = string
  description = "My external IP access to Argo CD"
  sensitive   = true
}

# --- Repo ---
variable "code_repo" {
  type        = string
  description = "Code repo"
  default     = "gitlab"
}

variable "repo_username" {
  type        = string
  description = "Repo username"
  default     = "jerrybai"
}

# --- Secrets ---
variable "gitlab_personal_access_token_api" {
  type        = string
  description = "GitLab Personal Access Token for API"
  sensitive   = true
}

variable "gitlab_personal_access_token_read_api" {
  type        = string
  description = "GitLab Personal Access Token for Read"
  sensitive   = true
}
