variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(any)
}
variable "iam_policy" {
  description = "List of IAM policies for IAM"
  type = list(object({
    name        = string
    description = string
    policy      = string
  }))
}
