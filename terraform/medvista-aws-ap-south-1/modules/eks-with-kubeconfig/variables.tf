variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster."
  type        = string
}

variable "cluster_endpoint_public_access" {
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

variable "desired_size" {
  description = "Desired number of nodes for the EKS node group."
  type        = number
}

variable "min_size" {
  description = "Minimum number of nodes for the EKS node group."
  type        = number
}

variable "max_size" {
  description = "Maximum number of nodes for the EKS node group."
  type        = number
}

variable "instance_types" {
  description = "List of EC2 instance types to use for EKS managed node groups."
  type        = list(string)
}

variable "capacity_type" {
  description = "Capacity type of EKS managed node groups (e.g., ON_DEMAND, SPOT)."
  type        = string
}

variable "labels" {
  description = "Labels to apply to the EKS managed node group."
  type        = map(string)
}

variable "iam_role_additional_policies" {
  description = "Additional IAM policies to attach to the EKS node group IAM role."
  type        = map(string)
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
