resource_name      = "ecr-image-push-event"
authorization_type = "NONE"
# api_key_name                     = "x-api-key"
# api_key_value                    = "b8a38e35b1d321fbbef5d7f0ad4358420e922334"
http_method                      = "POST"
invocation_rate_limit_per_second = 10
maximum_event_age_in_seconds     = 60
maximum_retry_attempts           = 0
endpoint_hostname                = "https://cd-release.pranat.online"
repo_info = {
  "hellow" = "/hook/26c081fdbc55d8da8cd49e009298608a5dc33ba1e2034a8453f7aef5931e8a29"
  "new"    = "/hook/0753799763e410428c26ceb18c2e2f8c7ef1d572393d2100ee63a1c3757bda79"
}
