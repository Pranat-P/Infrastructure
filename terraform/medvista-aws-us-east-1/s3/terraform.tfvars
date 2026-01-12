buckets = [
  {
    prefix     = "medvistacloud"
    name       = "dev-document"
    create_iam = true
  },
  {
    prefix     = "medvistacloud"
    name       = "backup"
    create_iam = true
  }
]

default_tags = {
  Owner       = "terraform"
  Project     = "Medvista"
  Created_By  = "Terraform"
  Environment = "Dev/QA"
  Contacts    = "pranat.pattankude@corazoncare.com"
}
