# Create an EventBridge API Destination
resource "aws_cloudwatch_event_api_destination" "cloudwatch_event_api_destination" {
  name                             = var.resource_name
  description                      = "API Destination for ECR Image Push Events"
  invocation_endpoint              = var.invocation_endpoint
  http_method                      = var.http_method
  invocation_rate_limit_per_second = var.invocation_rate_limit_per_second
  connection_arn                   = var.connection_arn
}

# Create an EventBridge Rule
resource "aws_cloudwatch_event_rule" "cloudwatch_event_rule" {
  name        = var.resource_name
  description = "Rule for ECR Image Push Events"
  event_pattern = jsonencode({
    "source" : ["aws.ecr"],
    "detail-type" : ["ECR Image Action"],
    "detail" : {
      "action-type" : ["PUSH"],
      "result" : ["SUCCESS"],
      "repository-name" : [var.repository_name],
      "image-tag" : [{
        "anything-but" : [""]
      }]
    }
  })
}

# Create an EventBridge Target (API Destination)
resource "aws_cloudwatch_event_target" "cloudwatch_event_target" {
  target_id = var.resource_name
  rule      = aws_cloudwatch_event_rule.cloudwatch_event_rule.name
  arn       = aws_cloudwatch_event_api_destination.cloudwatch_event_api_destination.arn
  role_arn  = var.role_arn
  retry_policy {
    maximum_event_age_in_seconds = var.maximum_event_age_in_seconds
    maximum_retry_attempts       = var.maximum_retry_attempts
  }
}
