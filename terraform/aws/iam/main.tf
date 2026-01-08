# data "aws_iam_policy_document" "autoscaller_trust_policy" {
#   statement {
#     actions = ["sts:AssumeRoleWithWebIdentity"]
#     effect  = "Allow"

#     condition {
#       test     = "StringEquals"
#       variable = "${replace(var.oidc_provider, "https://", "")}:sub"
#       values   = ["system:serviceaccount:kube-system:cluster-autoscaller"]
#     }

#     principals {
#       identifiers = [var.oidc_provider_arn]
#       type        = "Federated"
#     }
#   }
# }

# module "autoscaller_iam_policy" {
#   source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
#   version = "5.39.1"
#   name    = var.autoscaler_policy

#   policy = <<EOF
# {
#       "Version": "2012-10-17",
#       "Statement": [
#           {
#               "Action": [
#                   "autoscaling:DescribeAutoScalingGroups",
#                   "autoscaling:DescribeAutoScalingInstances",
#                   "autoscaling:DescribeLaunchConfigurations",
#                   "autoscaling:DescribeTags",
#                   "autoscaling:SetDesiredCapacity",
#                   "autoscaling:TerminateInstanceInAutoScalingGroup",
#                   "ec2:DescribeLaunchTemplateVersions"
#               ],
#               "Resource": "*",
#               "Effect": "Allow"
#           }
#       ]

# }
# EOF
#   tags   = var.default_tags
# }

# module "autoscaller_assume_role" {
#   source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
#   version = "5.39.1"

#   role_name   = var.autoscaller_role
#   create_role = true

#   create_custom_role_trust_policy = true
#   custom_role_trust_policy        = data.aws_iam_policy_document.autoscaller_trust_policy.json
#   custom_role_policy_arns = [
#     module.autoscaller_iam_policy.arn
#   ]
#   tags = var.default_tags
# }

module "psp_1_backup_iam_policy" {
  source      = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version     = "5.59.0"
  name        = var.psp_1_backup_iam_policy
  description = "iam policy for s3 bucket"

  policy = <<EOF
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

  tags = var.default_tags
}
module "psp_1_backup_iam_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.59.0"
  name    = var.psp_1_backup_iam_user_name

  create_iam_user_login_profile = false
  create_iam_access_key         = true
  policy_arns                   = [module.psp_1_backup_iam_policy.arn]
}
