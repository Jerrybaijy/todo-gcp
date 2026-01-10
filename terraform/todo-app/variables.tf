variable "prefix" {
  type        = string
  description = "Project prefix"
}

locals {
  project_name   = "${var.prefix}-gcp"
  app_name       = "${var.prefix}-app"
  chart_name     = "${var.prefix}-chart"
  chart_repo_url = "asia-east2-docker.pkg.dev/project-60addf72-be9c-4c26-8db/${var.prefix}-docker-repo"
}

variable "argocd_ns" {
  type        = string
  description = "Argo CD Namespace"
}

variable "app_ns" {
  type        = string
  description = "Kubernetes Namespace for the Application"
}
