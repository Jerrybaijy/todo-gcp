# 创建 Argo CD 命名空间
resource "kubernetes_namespace_v1" "argocd_ns" {
  metadata {
    name = "argocd"
  }
}

# 安装 Argo CD
resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = kubernetes_namespace_v1.argocd_ns.metadata[0].name
  version    = "7.7.1"

  set = [
    # 为 argocd-repo-server KSA 添加注解，绑定到 Workload Identity GSA
    {
      name  = "repoServer.serviceAccount.annotations.iam\\.gke\\.io/gcp-service-account"
      value = var.workload_identity_gsa_email
    },
    # 设置服务类型为 LoadBalancer
    {
      name  = "server.service.type"
      value = "LoadBalancer"
    },
    # 允许 HTTP 访问
    {
      name  = "server.extraArgs"
      value = "{--insecure}"
    },
    # 仅允许自己的 IP 访问
    {
      name  = "server.service.loadBalancerSourceRanges"
      value = "{${var.my_external_ip}/32}"
    }
  ]
}

# 创建 Argo CD 访问 GAR 的 Secret
resource "kubernetes_secret_v1" "gar_repo_secret" {
  metadata {
    name      = "gar-repo-secret"
    namespace = kubernetes_namespace_v1.argocd_ns.metadata[0].name
    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  data = {
    name      = "${var.prefix}-docker-repo"
    type      = "helm"
    url       = local.chart_repo_url
    enableOCI = "true"
  }
}
