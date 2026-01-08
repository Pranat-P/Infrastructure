locals {
  name               = join("-", ["psp", var.bucket_name])
  backup_bucket_name = join("-", ["psp", var.backup_bucket_name])
}

module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "5.2.0"
  bucket  = local.name
  tags    = var.default_tags
}
module "s3_backup_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "5.2.0"
  bucket  = local.backup_bucket_name
  tags    = var.default_tags
}
