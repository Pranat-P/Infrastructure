default_tags = {
  Owner       = "terraform"
  Application = "medcore"
  Created_By  = "Terraform"
  Environment = "Test"
  Contacts    = "pranat.pattankude@corazonkare.com"
}
iam_policy = [
  {
    name        = "ecr_user"
    description = "IAM policy to the access all the ECR repositories."
    policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:GetRepositoryPolicy",
        "ecr:DescribeRepositories",
        "ecr:ListImages",
        "ecr:DescribeImages",
        "ecr:BatchGetImage",
        "ecr:GetLifecyclePolicy",
        "ecr:GetLifecyclePolicyPreview",
        "ecr:ListTagsForResource",
        "ecr:DescribeImageScanFindings",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload",
        "ecr:PutImage"
      ],
      "Resource": "*"
    }
  ]
}
EOF
  },
  {
    name        = "psp-1-backup-s3"
    description = "IAM policy to the access all the ECR repositories."
    policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource" : [
        "arn:aws:s3:::psp-1-backup",
        "arn:aws:s3:::psp-1-backup/*"
      ]
    }
  ]
}
EOF
  }
]
