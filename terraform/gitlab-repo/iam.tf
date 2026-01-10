# 创建 Cloud Build 的 GSA
resource "google_service_account" "cloudbuild_worker" {
  account_id   = "${var.prefix}-cloudbuild-worker"
  display_name = "Cloud Build Worker Service Account"
}

# 为 GSA 分配角色
resource "google_project_iam_member" "cloudbuild_worker_roles" {
  for_each = toset([
    "roles/logging.logWriter",       # Logs Writer
    "roles/artifactregistry.writer", # Artifact Registry Writer
    "roles/artifactregistry.reader"  # Artifact Registry Reader
  ])

  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.cloudbuild_worker.email}"
}

# 获取当前 Project ID
data "google_project" "project" {}

# 允许 Cloud Build 服务代理访问 Secret Manager 中的 Secrets
resource "google_secret_manager_secret_iam_member" "cloudbuild_secret_accessor" {
  for_each = {
    api     = google_secret_manager_secret.gitlab_api_token.id
    read    = google_secret_manager_secret.gitlab_read_api_token.id
    webhook = google_secret_manager_secret.webhook_secret.id
  }
  secret_id = each.value
  role      = "roles/secretmanager.secretAccessor"
  # 必须使用 Cloud Build 的 Service Agent 账号
  member = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

# 允许 Cloud Build 服务代理以 GSA 身份运行
# 否则 Cloud Build 服务代理无法代表 GSA 执行构建任务
resource "google_service_account_iam_member" "cloudbuild_worker_binding" {
  service_account_id = google_service_account.cloudbuild_worker.name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}
