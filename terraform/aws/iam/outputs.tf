# output "role_arn" {
#   value = module.autoscaller_assume_role.iam_role_arn
# }

output "psp_1_backup_iam_access_key_id" {
  description = "The access key ID"
  value       = module.psp_1_backup_iam_user.iam_access_key_id
}
output "psp_1_backup_iam_access_key_secret" {
  description = "The access key secret"
  value       = module.psp_1_backup_iam_user.iam_access_key_secret
  sensitive   = true
}
