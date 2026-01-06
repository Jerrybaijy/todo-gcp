# 1. 存储 Token 到 Secret Manager

# 创建存储 API Token 的 Secret
resource "google_secret_manager_secret" "gitlab_api_token" {
  secret_id = "${var.code_repo}-api-token"
  replication {
    auto {}
  }
}

# 存入具体的 API Token 值
resource "google_secret_manager_secret_version" "api_token_version" {
  secret      = google_secret_manager_secret.gitlab_api_token.id
  secret_data = var.gitlab_personal_access_token_api
}

# 创建存储 Read API Token 的 Secret
resource "google_secret_manager_secret" "gitlab_read_api_token" {
  secret_id = "${var.code_repo}-read-api-token"
  replication {
    auto {}
  }
}

# 存入具体的 Read API Token 值
resource "google_secret_manager_secret_version" "read_api_token_version" {
  secret      = google_secret_manager_secret.gitlab_read_api_token.id
  secret_data = var.gitlab_personal_access_token_read_api
}

# 随机生成一个 Webhook 密钥
resource "random_password" "webhook_secret_value" {
  length  = 16
  special = false
}

# 创建 Secret Manager 容器
resource "google_secret_manager_secret" "webhook_secret" {
  secret_id = "gitlab-webhook-secret"
  replication {
    auto {}
  }
}

# 存入随机生成的密钥值
resource "google_secret_manager_secret_version" "webhook_secret_version" {
  secret      = google_secret_manager_secret.webhook_secret.id
  secret_data = random_password.webhook_secret_value.result
}

# 2. 连接到 GitLab 主机 (2nd Gen)
resource "google_cloudbuildv2_connection" "my_gitlab_connection" {
  location = var.region
  name     = local.code_repo_host

  gitlab_config {
    # 引用 Secret Manager 中的令牌
    authorizer_credential {
      user_token_secret_version = google_secret_manager_secret_version.api_token_version.id
    }
    read_authorizer_credential {
      user_token_secret_version = google_secret_manager_secret_version.read_api_token_version.id
    }
    webhook_secret_secret_version = google_secret_manager_secret_version.webhook_secret_version.id
  }
}

# 3. 链接具体的代码仓库
resource "google_cloudbuildv2_repository" "my_repo" {
  name              = "${var.repo_username}-${local.project_name}"
  location          = google_cloudbuildv2_connection.my_gitlab_connection.location
  parent_connection = google_cloudbuildv2_connection.my_gitlab_connection.id
  remote_uri        = "https://gitlab.com/${var.repo_username}/${local.project_name}.git"
}
