module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name                             = var.cluster_name
  cluster_version                          = var.cluster_version
  cluster_endpoint_public_access           = var.cluster_endpoint_public_access
  enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions
  cloudwatch_log_group_retention_in_days   = var.cloudwatch_log_group_retention_in_days

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  eks_managed_node_groups = {
    onDemand = {
      desired_size                 = var.desired_size
      min_size                     = var.min_size
      max_size                     = var.max_size
      instance_types               = var.instance_types
      capacity_type                = var.capacity_type
      labels                       = var.labels
      iam_role_additional_policies = var.iam_role_additional_policies
    }
  }

  cluster_upgrade_policy = {
    support_type = "STANDARD"
  }

  tags = var.default_tags
}

resource "null_resource" "update_desired_size" {
  depends_on = [module.eks]
  triggers = {
    desired_size = var.desired_size
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOT
      aws eks update-nodegroup-config \
        --cluster-name ${module.eks.cluster_name} \
        --nodegroup-name ${element(split(":", module.eks.eks_managed_node_groups["onDemand"].node_group_id), 1)} \
        --scaling-config desiredSize=${var.desired_size} && \
      aws eks wait nodegroup-active \
              --cluster-name ${module.eks.cluster_name} \
              --nodegroup-name ${element(split(":", module.eks.eks_managed_node_groups["onDemand"].node_group_id), 1)}
    EOT
  }
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

resource "kubernetes_service_account_v1" "k8s_service_account" {
  provider = kubernetes.k8s

  metadata {
    name      = var.service_account_name
    namespace = "kube-system"
  }

  automount_service_account_token = false
}

resource "kubernetes_cluster_role_binding_v1" "k8s_role_binding" {
  provider = kubernetes.k8s

  metadata {
    name = kubernetes_service_account_v1.k8s_service_account.metadata[0].name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account_v1.k8s_service_account.metadata[0].name
    namespace = kubernetes_service_account_v1.k8s_service_account.metadata[0].namespace
  }
}

resource "kubernetes_secret" "k8s_secret" {
  provider = kubernetes.k8s

  metadata {
    name      = kubernetes_service_account_v1.k8s_service_account.metadata[0].name
    namespace = kubernetes_service_account_v1.k8s_service_account.metadata[0].namespace
    annotations = {
      "kubernetes.io/service-account.name"      = kubernetes_service_account_v1.k8s_service_account.metadata[0].name
      "kubernetes.io/service-account.namespace" = kubernetes_service_account_v1.k8s_service_account.metadata[0].namespace
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
  filename = "${path.cwd}/kubeconfigs/${var.service_account_name}-${var.cluster_name}-kubeconfig.yaml"
  content  = <<-KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${module.eks.cluster_endpoint}
    certificate-authority-data: ${module.eks.cluster_certificate_authority_data}
  name: ${var.cluster_name}
contexts:
- context:
    cluster: ${var.cluster_name}
    user: ${var.cluster_name}
  name: ${var.cluster_name}
current-context: ${var.cluster_name}
kind: Config
preferences: {}
users:
- name: ${var.cluster_name}
  user:
    token: ${data.kubernetes_secret.k8s_secret_data.data.token}
KUBECONFIG
}
