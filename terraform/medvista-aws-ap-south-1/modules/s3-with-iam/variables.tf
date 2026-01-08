variable "bucket" {
  description = "Name of the S3 bucket."
  type        = string
}

variable "create_iam" {
  description = "Create IAM user and policy."
  type        = bool
}

variable "policy" {
  description = "IAM policy document."
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
}
