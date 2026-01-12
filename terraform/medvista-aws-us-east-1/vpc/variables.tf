variable "vpcs" {
  description = "Map of VPC configurations"
  type = map(object({
    name               = string
    cidr               = string
    azs                = list(string)
    private_subnets    = list(string)
    public_subnets     = list(string)
    enable_nat_gateway = bool
    single_nat_gateway = bool
    tags               = optional(map(string))
  }))
}

variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(string)
}
