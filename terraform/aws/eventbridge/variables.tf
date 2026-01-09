# Common variables for the EventBridge module
variable "resource_name" {
  description = "The name used for all resources"
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
# Variables for the EventBridge API Connection
variable "authorization_type" {
  description = "The authorization type for the EventBridge Connection"
  type        = string
}

variable "api_key_name" {
  description = "The name of the API Key"
  type        = string
}

variable "api_key_value" {
  description = "The value of the API Key"
  type        = string
  sensitive   = true
}

variable "http_method" {
  description = "The HTTP method to use when invoking the API Destination"
  type        = string
}

variable "invocation_rate_limit_per_second" {
  description = "The rate limit for the API Destination"
  type        = number
}

variable "endpoint_hostname" {
  description = "The hostname of the endpoint"
  type        = string
}

variable "repo_info" {
  description = "The ECR repository information"
  type        = map(string)
}
