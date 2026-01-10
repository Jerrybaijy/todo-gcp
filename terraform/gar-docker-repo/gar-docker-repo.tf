# 创建 Docker 仓库
resource "google_artifact_registry_repository" "docker_repo" {
  repository_id = local.chart_repo
  format        = "DOCKER"
  depends_on    = [google_project_service.project_services]
}