module "vpcs" {
  for_each = var.vpcs
  source   = "terraform-aws-modules/vpc/aws"
  version  = "6.0.1"

  name               = each.value.name
  cidr               = each.value.cidr
  azs                = each.value.azs
  private_subnets    = each.value.private_subnets
  public_subnets     = each.value.public_subnets
  enable_nat_gateway = each.value.enable_nat_gateway
  single_nat_gateway = each.value.single_nat_gateway

  tags = each.value.tags != null ? each.value.tags : var.default_tags
}
