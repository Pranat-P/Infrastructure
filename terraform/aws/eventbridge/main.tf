# Create an EventBridge Connection
resource "aws_cloudwatch_event_connection" "cloudwatch_event_connection" {
  name               = var.resource_name
  description        = "Connection for ECR Image Push Events"
  authorization_type = var.authorization_type

  auth_parameters {
    api_key {
      key   = var.api_key_name
      value = var.api_key_value
    }
  }
}

# Create an IAM Role for EventBridge
resource "aws_iam_role" "iam_role" {
  name        = var.resource_name
  description = "IAM Role for EventBridge API Destination"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "events.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Create an IAM Policy for EventBridge
resource "aws_iam_policy" "iam_policy" {
  name        = var.resource_name
  description = "IAM Policy for EventBridge API Destination"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "events:InvokeApiDestination"
        ],
        "Resource" : [
          "arn:aws:events:ap-south-1:587210147621:api-destination/*"
        ]
      }
    ]
  })
}

# Attach the IAM Policy to the IAM Role
resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.iam_policy.arn
}

module "eventbridge" {
  source = "../modules/eventbridge"

  for_each = var.repo_info

  resource_name                    = each.key
  invocation_endpoint              = "${var.endpoint_hostname}${each.value}"
  http_method                      = var.http_method
  invocation_rate_limit_per_second = var.invocation_rate_limit_per_second
  connection_arn                   = aws_cloudwatch_event_connection.cloudwatch_event_connection.arn
  role_arn                         = aws_iam_role.iam_role.arn
  repository_name                  = each.key
  maximum_event_age_in_seconds     = var.maximum_event_age_in_seconds
  maximum_retry_attempts           = var.maximum_retry_attempts
}
