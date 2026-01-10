locals {
  services = [
    "cloudbuild.googleapis.com",    # Cloud Build API
    "secretmanager.googleapis.com", # Secret Manager API
  ]
}

resource "google_project_service" "project_services" {
  for_each           = toset(local.services)
  service            = each.key
  disable_on_destroy = false
}
