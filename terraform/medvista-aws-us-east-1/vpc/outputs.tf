output "vpc_ids" {
  description = "Map of VPC IDs"
  value       = { for k, v in module.vpcs : k => v.vpc_id }
}

output "vpc_owner_ids" {
  description = "Map of VPC Owner IDs"
  value       = { for k, v in module.vpcs : k => v.vpc_owner_id }
}

output "private_subnets" {
  description = "Map of private subnet IDs"
  value       = { for k, v in module.vpcs : k => v.private_subnets }
}

output "public_subnets" {
  description = "Map of public subnet IDs"
  value       = { for k, v in module.vpcs : k => v.public_subnets }
}
