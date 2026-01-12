include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  vpc_ids         = dependency.vpc.outputs.vpc_ids
  private_subnets = dependency.vpc.outputs.private_subnets
}
