# Repositoty names to be added in alphabatical order
repository_names = [
  "hellow",
  "new",
  "healthcare_identityservice"
]

attach_repository_policy = false

create_repository_policy = false

registry_scan_type = "BASIC"

repository_image_tag_mutability = "MUTABLE"

# Tags to be added in alphabatical order
tag_patterns = ["Dev-k8s*", "QA-k8s*"]

default_tags = {
  Owner       = "terraform"
  Application = "medcore"
  Created_By  = "Terraform"
  Contacts    = "pranat.pattankude@corazonkare.com"
}
