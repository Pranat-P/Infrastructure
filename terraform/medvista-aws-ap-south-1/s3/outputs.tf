output "s3_iam_credentials" {
  value = {
    for key, value in module.s3_buckets : key => {
      aws_access_key = value.aws_access_key
      aws_secret_key = value.aws_secret_key
    }
  }
  sensitive   = true
  description = "AWS S3 IAM credentials."
}
