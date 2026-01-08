include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "iam_policy" {
  config_path = "../iam-policy"
}

inputs = {
  iam_policy_arn = dependency.iam_policy.outputs.iam_policy_arn
}
