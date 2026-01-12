module "medvistacloud" {
  source = "../modules/eks-with-kubeconfig"

  # Cluster configuration
  cluster_name                             = var.eks_clusters[0].cluster_name
  cluster_version                          = var.eks_clusters[0].cluster_version
  cluster_endpoint_public_access           = var.eks_clusters[0].cluster_endpoint_public_access
  enable_cluster_creator_admin_permissions = var.eks_clusters[0].enable_cluster_creator_admin_permissions

  # Node group configuration
  desired_size   = var.eks_clusters[0].desired_size
  min_size       = var.eks_clusters[0].min_size
  max_size       = var.eks_clusters[0].max_size
  instance_types = var.eks_clusters[0].instance_types
  capacity_type  = var.eks_clusters[0].capacity_type
  labels         = var.eks_clusters[0].labels

  # Networking
  vpc_id          = var.vpc_ids["medvistacloud"]
  private_subnets = var.private_subnets["medvistacloud"]

  # Additional configuration
  default_tags                           = var.eks_clusters[0].tags != null ? var.eks_clusters[0].tags : var.default_tags
  iam_role_additional_policies           = var.eks_clusters[0].iam_role_additional_policies
  service_account_name                   = var.eks_clusters[0].service_account_name
  cloudwatch_log_group_retention_in_days = var.eks_clusters[0].cloudwatch_log_group_retention_in_days
}

# module "medvistacloud-qa" {
#   source = "../modules/eks-with-kubeconfig"

#   # Cluster configuration
#   cluster_name                             = var.eks_clusters[1].cluster_name
#   cluster_version                          = var.eks_clusters[1].cluster_version
#   cluster_endpoint_public_access           = var.eks_clusters[1].cluster_endpoint_public_access
#   enable_cluster_creator_admin_permissions = var.eks_clusters[1].enable_cluster_creator_admin_permissions

#   # Node group configuration
#   desired_size   = var.eks_clusters[1].desired_size
#   min_size       = var.eks_clusters[1].min_size
#   max_size       = var.eks_clusters[1].max_size
#   instance_types = var.eks_clusters[1].instance_types
#   capacity_type  = var.eks_clusters[1].capacity_type
#   labels         = var.eks_clusters[1].labels

#   # Networking
#   vpc_id          = var.vpc_ids["medvistacloud-qa"]
#   private_subnets = var.private_subnets["medvistacloud-qa"]

#   # Additional configuration
#   default_tags                           = var.default_tags
#   iam_role_additional_policies           = var.eks_clusters[1].iam_role_additional_policies
#   service_account_name                   = var.eks_clusters[1].service_account_name
#   cloudwatch_log_group_retention_in_days = var.eks_clusters[1].cloudwatch_log_group_retention_in_days
# }
