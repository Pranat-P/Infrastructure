vpcs = {
  medvista-runner = {
    name               = "medvista-runner"
    cidr               = "10.1.0.0/16"
    azs                = ["ap-south-1a", "ap-south-1b"]
    private_subnets    = ["10.1.0.0/19", "10.1.32.0/19"]
    public_subnets     = ["10.1.64.0/19", "10.1.96.0/19"]
    enable_nat_gateway = true
    single_nat_gateway = true
    tags = {
      Owner       = "terraform"
      Project     = "Medvista"
      Created_By  = "Terraform"
      Environment = "Runners"
      Contacts    = "pranat.pattankude@corazoncare.com"
    }
  },
  medvistacloud = {
    name               = "medvistacloud"
    cidr               = "10.0.0.0/16"
    azs                = ["ap-south-1a", "ap-south-1b"]
    private_subnets    = ["10.0.0.0/19", "10.0.32.0/19"]
    public_subnets     = ["10.0.64.0/19", "10.0.96.0/19"]
    enable_nat_gateway = true
    single_nat_gateway = true
  }
  # medvistacloud-qa = {
  #   name               = "medvistacloud-qa"
  #   cidr               = "10.2.0.0/16"
  #   azs                = ["ap-south-1a", "ap-south-1b"]
  #   private_subnets    = ["10.2.0.0/19", "10.2.32.0/19"]
  #   public_subnets     = ["10.2.64.0/19", "10.2.96.0/19"]
  #   enable_nat_gateway = true
  #   single_nat_gateway = true
  # }
}
default_tags = {
  Owner       = "terraform"
  Project     = "Medvista"
  Created_By  = "Terraform"
  Environment = "Dev/QA"
  Contacts    = "pranat.pattankude@corazoncare.com"
}
