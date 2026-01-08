module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name                             = var.name
  cluster_version                          = var.kubernetes_version
  cluster_endpoint_public_access           = var.endpoint_public_access
  enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions
  cloudwatch_log_group_retention_in_days   = var.cloudwatch_log_group_retention_in_days

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  eks_managed_node_groups = var.eks_managed_node_groups

  cluster_upgrade_policy = {
    support_type = "STANDARD"
  }

  tags = var.default_tags
}

provider "kubernetes" {
  alias                  = "k8s"
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    command     = "aws"
  }
}

resource "kubernetes_service_account" "k8s_service_account" {
  provider = kubernetes.k8s

  metadata {
    name      = var.service_account_name
    namespace = "kube-system"
  }

  automount_service_account_token = false
}

resource "kubernetes_cluster_role_binding" "k8s_role_binding" {
  provider = kubernetes.k8s

  metadata {
    name = kubernetes_service_account.k8s_service_account.metadata[0].name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.k8s_service_account.metadata[0].name
    namespace = kubernetes_service_account.k8s_service_account.metadata[0].namespace
  }
}

resource "kubernetes_secret" "k8s_secret" {
  provider = kubernetes.k8s

  metadata {
    name      = kubernetes_service_account.k8s_service_account.metadata[0].name
    namespace = kubernetes_service_account.k8s_service_account.metadata[0].namespace
    annotations = {
      "kubernetes.io/service-account.name"      = kubernetes_service_account.k8s_service_account.metadata[0].name
      "kubernetes.io/service-account.namespace" = kubernetes_service_account.k8s_service_account.metadata[0].namespace
    }
  }

  type = "kubernetes.io/service-account-token"
}

data "kubernetes_secret" "k8s_secret_data" {
  provider = kubernetes.k8s

  metadata {
    name      = kubernetes_secret.k8s_secret.metadata[0].name
    namespace = kubernetes_secret.k8s_secret.metadata[0].namespace
  }
}

resource "local_file" "kubeconfig" {
  filename = "${path.cwd}/kubeconfigs/${var.service_account_name}-${var.name}-kubeconfig.yaml"
  content  = <<-KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${module.eks.cluster_endpoint}
    certificate-authority-data: ${module.eks.cluster_certificate_authority_data}
  name: ${var.name}
contexts:
- context:
    cluster: ${var.name}
    user: ${var.name}
  name: ${var.name}
current-context: ${var.name}
kind: Config
preferences: {}
users:
- name: ${var.name}
  user:
    token: ${data.kubernetes_secret.k8s_secret_data.data.token}
KUBECONFIG
}
