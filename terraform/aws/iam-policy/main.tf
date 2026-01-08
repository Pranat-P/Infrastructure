module "iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.59.0"

  for_each    = { for policy in var.iam_policy : policy.name => policy }
  name        = each.value.name
  description = each.value.description
  policy      = each.value.policy
  tags        = var.default_tags
}
