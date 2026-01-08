module "iam_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.59.0"

  for_each                      = { for user in var.iam_user : user.name => user }
  name                          = each.value.name
  create_iam_user_login_profile = false
  create_iam_access_key         = true
  policy_arns                   = [var.iam_policy_arn[each.value.policy_name]]
}
