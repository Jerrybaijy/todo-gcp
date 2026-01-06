# 为 GitLab 仓库创建 Cloud Build 触发器
resource "google_cloudbuild_trigger" "gitlab_trigger" {
  name            = local.trigger_name
  location        = google_cloudbuildv2_repository.my_repo.location
  service_account = google_service_account.cloudbuild_worker.id

  # 使用第 2 代连接 (v2 repository)
  repository_event_config {
    repository = google_cloudbuildv2_repository.my_repo.id
    push {
      branch = "^main$"
    }
  }

  # 指定构建配置
  filename = "cloudbuild.yaml"

  included_files = [
    "backend/**",
    "frontend/**",
    "helm-chart/**"
  ]

  depends_on = [
    google_cloudbuildv2_repository.my_repo,
    google_secret_manager_secret_iam_member.cloudbuild_secret_accessor,
    google_project_iam_member.cloudbuild_worker_roles,
    google_service_account_iam_member.cloudbuild_worker_binding
  ]
}
