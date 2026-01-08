variable "name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version to use for the EKS cluster."
  type        = string
}

variable "endpoint_public_access" {
  description = "Whether the EKS cluster endpoint is publicly accessible."
  type        = bool
}

variable "enable_cluster_creator_admin_permissions" {
  description = "Indicates whether or not to add the cluster creator (the identity used by Terraform) as an administrator via access entry"
  type        = bool
}

variable "vpc_id" {
  description = "The ID of the VPC where the EKS cluster will be deployed."
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs where the EKS cluster nodes will be deployed."
  type        = list(string)
}

variable "eks_managed_node_groups" {
  description = "Configuration for EKS managed node groups."
  type        = any
}

variable "service_account_name" {
  description = "Name of the Kubernetes service account."
  type        = string
}

variable "default_tags" {
  description = "Key-value pairs of default tags to apply to all resources."
  type        = map(string)
}

variable "cloudwatch_log_group_retention_in_days" {
  description = "Number of days to retain log events"
  type        = number
}
