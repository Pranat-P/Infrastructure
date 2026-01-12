terraform {
  extra_arguments "no_color" {
    commands = [
      "plan",
      "apply"
    ]
    arguments = [
      "-no-color",
    ]
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {}
EOF
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  backend "s3" {
    bucket = "medvista-us-terraform-tf-states"
    key    = "tf-states/${path_relative_to_include()}/terraform.tfstate"
    region = "us-east-1"

    skip_region_validation = true
  }
}
EOF
}

generate "versions" {
  path      = "versions.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_version = ">=1.6.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.33.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.10.0"
    }
  }
}
EOF
}
