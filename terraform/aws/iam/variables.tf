# variable "oidc_provider" {
#   type = string
# }
variable "psp_1_backup_iam_user_name" {
  type = string
}
variable "psp_1_backup_iam_policy" {
  type = string
}
# variable "oidc_provider_arn" {
#   type = string
# }

variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(any)
}

# variable "autoscaler_policy" {
#   type = string
# }

# variable "autoscaller_role" {
#   type = string
# }
