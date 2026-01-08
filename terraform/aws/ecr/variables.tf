variable "repository_names" {
  description = "List of ECR repository names to create"
  type        = list(string)
}

variable "attach_repository_policy" {
  description = "Determines whether a repository policy will be attached to the repository"
  type        = bool
}

variable "create_repository_policy" {
  description = "create_repository_policy"
  type        = bool
}

variable "registry_scan_type" {
  description = "The scanning type to set for the registry. Can be either ENHANCED or BASIC"
  type        = string
}

variable "repository_image_tag_mutability" {
  description = "The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE"
  type        = string
}

variable "tag_patterns" {
  description = "List of tag patterns to apply lifecycle policies"
  type        = list(string)
}

variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(any)
}
