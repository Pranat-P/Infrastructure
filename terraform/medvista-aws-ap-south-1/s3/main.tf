module "s3_buckets" {
  source = "../modules/s3-with-iam"

  for_each = { for bucket in var.buckets : bucket.name => bucket }

  bucket     = "${each.value.prefix}-${each.value.name}"
  create_iam = each.value.create_iam
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:*",
        ]
        Resource = [
          "arn:aws:s3:::${each.value.prefix}-${each.value.name}",
          "arn:aws:s3:::${each.value.prefix}-${each.value.name}/*"
        ]
      }
    ]
  })
  tags = var.default_tags
}
