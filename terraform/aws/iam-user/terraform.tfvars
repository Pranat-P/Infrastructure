default_tags = {
  Owner       = "terraform"
  Application = "medcore"
  Created_By  = "Terraform"
  Environment = "Test"
  Contacts    = "pranat.pattankude@corazonkare.com"
}
iam_user = [
  {
    name        = "ecr_user"
    policy_name = "ecr_user"
  },
  {
    name        = "psp-1-backup-s3"
    policy_name = "psp-1-backup-s3"
  }
]
