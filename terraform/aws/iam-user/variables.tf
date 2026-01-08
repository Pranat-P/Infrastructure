variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(any)
}
variable "iam_user" {
  description = "List of IAM users"
  type = list(object({
    name        = string
    policy_name = string
  }))
}
variable "iam_policy_arn" {
  description = "Policy ARNs for the users"
  type        = map(string)
}
