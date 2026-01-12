module "s3_buckets" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "5.2.0"

  bucket = var.bucket
  tags   = var.tags
}

resource "aws_iam_user" "s3_iam_user" {
  count = var.create_iam ? 1 : 0

  name = "s3-${var.bucket}"
  path = "/"
  tags = var.tags
}

resource "aws_iam_user_policy" "s3_iam_policy" {
  count = var.create_iam ? 1 : 0

  name   = "s3-${var.bucket}"
  user   = aws_iam_user.s3_iam_user[count.index].name
  policy = var.policy
}


resource "aws_iam_access_key" "s3_iam_access_key" {
  count = var.create_iam ? 1 : 0

  user = aws_iam_user.s3_iam_user[count.index].name
}
