# Common variables for the EventBridge module
variable "resource_name" {
  description = "The name used for all resources"
  type        = string
}

# Variables for the EventBridge API Destination
variable "invocation_endpoint" {
  description = "The endpoint to invoke the API Destination"
  type        = string
}

variable "http_method" {
  description = "The HTTP method to use when invoking the API Destination"
  type        = string
}

variable "invocation_rate_limit_per_second" {
  description = "The rate limit for the API Destination"
  type        = number
}

variable "connection_arn" {
  description = "The ARN of the EventBridge Connection"
  type        = string
}

variable "repository_name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "role_arn" {
  description = "The ARN of the IAM Role"
  type        = string
}

variable "maximum_event_age_in_seconds" {
  description = "The maximum age of the event in seconds"
  type        = number
}

variable "maximum_retry_attempts" {
  description = "The maximum number of retry attempts"
  type        = number
}
