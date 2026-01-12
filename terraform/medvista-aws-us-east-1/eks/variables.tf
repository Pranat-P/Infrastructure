variable "vpc_ids" {
  description = "The ID of the VPC where the EKS cluster will be deployed."
  type        = map(string)
}

variable "private_subnets" {
  description = "List of private subnet IDs where the EKS cluster nodes will be deployed."
  type        = map(list(string))
}


variable "eks_clusters" {
  description = "List of EKS clusters and their configurations"
  type = list(object({
    cluster_name                             = string
    cluster_version                          = string
    cluster_endpoint_public_access           = bool
    enable_cluster_creator_admin_permissions = bool
    desired_size                             = number
    min_size                                 = number
    max_size                                 = number
    instance_types                           = list(string)
    capacity_type                            = string
    labels                                   = map(string)
    iam_role_additional_policies             = map(string)
    service_account_name                     = string
    tags                                     = optional(map(string))
    cloudwatch_log_group_retention_in_days   = number
  }))
}

variable "default_tags" {
  description = "Key-value pairs of default tags to apply to all resources."
  type        = map(string)
}
