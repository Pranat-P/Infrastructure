resource_name                    = "ecr-image-push-event"
authorization_type               = "API_KEY"
api_key_name                     = "x-api-key"
api_key_value                    = "b8a38e35b1d321fbbef5d7f0ad4358420e922334"
http_method                      = "POST"
invocation_rate_limit_per_second = 10
maximum_event_age_in_seconds     = 60
maximum_retry_attempts           = 0
endpoint_hostname                = "https://cd-release.pranat.online"
repo_info = {
  "hellow" = "/hook/5b0102e921d3184378e872cf57ec2a2a713ec371734114826f7b5a7a46b88531"
  "new"    = "/hook/0753799763e410428c26ceb18c2e2f8c7ef1d572393d2100ee63a1c3757bda79"
}
