# Todo GCP

Todo GCP 是一个完整的全栈 Web 应用原型，采用 GitOps 理念设计和部署。

## 项目特点

- **模块化设计**：前后端分离，便于独立开发和部署
- **容器化实现**：所有组件均容器化，确保环境一致性
- **GitOps 实践**：代码即基础设施，自动化部署和同步
- **可扩展性**：使用 Kubernetes 和 Helm 实现应用的水平扩展

## 技术栈

### 前端

- **框架**: React
- **构建工具**: Vite
- **样式**: CSS
- **容器化**: Docker + Nginx

### 后端

- **框架**: Flask (Python)
- **数据库**: MySQL
- **ORM**: SQLAlchemy
- **迁移工具**: Flask-Migrate (Alembic)
- **API**: RESTful API
- **容器化**: Docker

### 部署

- **容器编排**: Docker Compose, Kubernetes
- **GitOps**: Argo CD
- **包管理**: Helm
- **CI/CD**: GitLab CI
- **Cloud**：GCP, Cloud SQL, Terraform

## 项目结构

```
todo-gcp/
│
├── argo-cd/                # Argo CD 部署配置
│   ├── chart-app.yaml      # Helm Chart Argo CD 应用配置
│   └── k8s-app.yaml        # Kubernetes Argo CD 应用配置
│
├── backend/                # 后端代码目录
│   ├── app/                # 后端应用目录
│   │   ├── api/            # API 路由目录
│   │   │   ├── __init__.py # API 蓝图文件
│   │   │   └── rutes.py    # API 路由文件
│   │   ├── __init__.py     # 后端应用初始化文件
│   │   └── models.py       # 数据库模型文件
│   ├── migrations/         # 数据库迁移目录
│   ├── boot.sh             # 后端启动脚本
│   ├── config.py           # 后端配置文件
│   ├── Dockerfile          # 后端 Docker 镜像构建文件
│   ├── requirements.txt    # 后端依赖列表
│   └── run.py              # 后端入口文件
│
├── frontend/               # 前端代码目录
│   ├── src/                # 前端应用代码
│   │   ├── App.css         # 主组件样式表
│   │   ├── App.jsx         # 主组件
│   │   └── main.jsx        # 前端入口文件
│   ├── Dockerfile          # 前端 Docker 镜像构建文件
│   ├── index.html          # 前端入口 HTML 文件
│   ├── nginx.conf          # 前端请求反向代理（容器化环境）
│   ├── package.json        # npm 依赖
│   └── vite.config.js      # 前端请求代理（本地环境）
│
├── helm-chart/             # Helm Chart 目录
│   ├── templates/          # Kubernetes 资源模板目录
│   │   ├── namespace.yaml  # 命名空间配置模板
│   │   ├── _helpers.tpl    # 模板函数
│   │   ├── mysql.yaml      # MySQL 部署配置模板
│   │   ├── backend.yaml    # 后端部署配置模板
│   │   └── frontend.yaml   # 前端部署配置模板
│   ├── Chart.yaml          # Chart 元数据
│   └── values.yaml         # 模板文件参数配置
│
├── k8s/                    # Kubernetes 部署文件
│   ├── backend.yaml        # 后端部署配置
│   ├── frontend.yaml       # 前端部署配置
│   ├── mysql.yaml          # MySQL 部署配置
│   └── namespace.yaml      # 命名空间配置
│
├── terraform/              # Terraform 配置文件
│   ├── argocd/             # argocd 模块
│   │   ├── argocd.tf       # argocd 模块主文件
│   │   ├── outputs.tf      # argocd 模块输出文件
│   │   ├── Terraform.tf    # argocd 模块 provider version 文件
│   │   └── variables.tf    # argocd 模块变量文件
│   │
│   ├── cloud-sql/          # cloud-sql 模块
│   │   ├── api.tf          # cloud-sql 模块 API 文件
│   │   ├── cloud-sql.tf    # cloud-sql 模块主文件
│   │   ├── outputs.tf      # cloud-sql 模块输出文件
│   │   ├── Terraform.tf    # cloud-sql 模块 provider version 文件
│   │   └── variables.tf    # cloud-sql 模块变量文件
│   │
│   ├── gar-docker-repo/    # gar-docker-repo 模块
│   │   ├── api.tf          # gar-docker-repo 模块 API 文件
│   │   ├── gar-docker-repo.tf # gar-docker-repo 模块主文件
│   │   ├── Terraform.tf    # gar-docker-repo 模块 provider version 文件
│   │   └── variables.tf    # gar-docker-repo 模块变量文件
│   │
│   ├── gitlab-repo/        # gitlab-repo 模块
│   │   ├── api.tf          # gitlab-repo 模块 API 文件
│   │   ├── gitlab-repo.tf  # gitlab-repo 模块主文件
│   │   ├── iam.tf          # gitlab-repo 模块 IAM 文件
│   │   ├── Terraform.tf    # gitlab-repo 模块 provider version 文件
│   │   └── variables.tf    # gitlab-repo 模块变量文件
│   │
│   ├── gke/                # gke 模块
│   │   ├── api.tf          # gke 模块 API 文件
│   │   ├── gke.tf          # gke 模块主文件
│   │   ├── iam.tf          # gke 模块 IAM 文件
│   │   ├── outputs.tf      # gke 模块输出文件
│   │   ├── Terraform.tf    # gke 模块 provider version 文件
│   │   └── variables.tf    # gke 模块变量文件
│   │
│   ├── todo-app/           # todo-app 模块
│   │   ├── todo-app.tf     # todo-app 模块主文件
│   │   └── variables.tf    # todo-app 模块变量文件
│   │
│   ├── main.tf             # 根模块主文件
│   ├── providers.tf        # 根模块 Provider 文件
│   ├── terraform.tfvars    # 根模块敏感变量赋值文件
│   ├── terraform.tfvars.example # 根模块敏感变量赋值文件模板
│   └── variables.tf        # 根模块变量文件
│
├── .env                    # 环境变量（未推送至代码仓库）
├── .env.example            # 环境变量示例文件
├── .gitignore              # Git 忽略文件配置
├── .gitlab-ci.yml          # GitLab CI/CD 配置
├── docker-compose.yml      # Docker Compose 配置
└── README.md               # 项目说明文档
```

## 环境要求

- Docker 19.03+
- Docker Compose 3.8+
- Kubernetes 1.20+ (用于 K8s 部署)
- Helm 3.0+ (用于 Helm Chart 部署)
- Argo CD 2.0+ (用于 GitOps 部署)
- GCP

## GitOps 工作流

1. **代码变更**：开发者提交代码到 Git 仓库
2. **CI 触发**：Trriger 触发 Cloud Build 自动构建和测试
3. **镜像推送**：构建成功后推送 Docker Image 和 Helm Chart 到 GAR Docker Repositories
4. **Argo CD 同步**：Argo CD 监控 GAR Docker Repositories 变更
5. **自动部署**：Argo CD 自动将变更部署到 GKE 集群
