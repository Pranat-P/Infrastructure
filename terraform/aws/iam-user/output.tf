output "access_keys" {
  value = {
    for key, value in module.iam_user : key => {
      access_key_id     = value.iam_access_key_id
      secret_access_key = value.iam_access_key_secret
    }
  }
  sensitive = true
}
