eks_clusters = [
  {
    cluster_name                             = "medvistacloud"
    cluster_version                          = "1.33"
    cluster_endpoint_public_access           = true
    enable_cluster_creator_admin_permissions = true
    desired_size                             = 1
    min_size                                 = 1
    max_size                                 = 1
    instance_types                           = ["t3.xlarge"]
    capacity_type                            = "ON_DEMAND"
    labels                                   = { "role" = "onDemand" }
    iam_role_additional_policies             = { "policy_arn" = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy" }
    service_account_name                     = "devops-admin"
    cloudwatch_log_group_retention_in_days   = 5
  }
  # {
  #   cluster_name                             = "medvistacloud-qa"
  #   cluster_version                          = "1.33"
  #   cluster_endpoint_public_access           = true
  #   enable_cluster_creator_admin_permissions = true
  #   desired_size                             = 5
  #   min_size                                 = 5
  #   max_size                                 = 5
  #   instance_types                           = ["r7i.xlarge"]
  #   capacity_type                            = "ON_DEMAND"
  #   labels                                   = { "role" = "onDemand" }
  #   iam_role_additional_policies             = { "policy_arn" = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy" }
  #   service_account_name                     = "devops-admin"
  #   cloudwatch_log_group_retention_in_days   = 5
  # }
]

default_tags = {
  Owner       = "terraform"
  Project     = "Medvista"
  Created_By  = "Terraform"
  Environment = "Dev/QA"
  Contacts    = "pranat.pattankude@corazoncare.com"
}
