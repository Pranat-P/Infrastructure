output "iam_policy_arn" {
  value = {
    for name, policy in module.iam_policy : name => policy.arn
  }
}
