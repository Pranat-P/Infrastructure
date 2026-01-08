include "root" {
  path = find_in_parent_folders("root.hcl")
}

# dependency "eks" {
#   config_path = "../eks"
#   mock_outputs = {
#     oidc_provider     = "12345"
#     oidc_provider_arn = "12345"
#   }
# }

# inputs = {
#   oidc_provider     = dependency.eks.outputs.oidc_provider
#   oidc_provider_arn = dependency.eks.outputs.oidc_provider_arn
# }
