output "aws_access_key" {
  value       = try(aws_iam_access_key.s3_iam_access_key[0].id, null)
  description = "AWS access key."
}

output "aws_secret_key" {
  value       = try(aws_iam_access_key.s3_iam_access_key[0].secret, null)
  sensitive   = true
  description = "AWS secret key."
}
