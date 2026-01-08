variable "bucket_name" {
  type        = string
  description = "Name of S3 Bucket will be `<bucket_name>`"
}
variable "backup_bucket_name" {
  type        = string
  description = "Name of S3 Bucket will be `<bucket_name>`"
}
variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(any)
}
