variable "buckets" {
  description = "A list of buckets to create."
  type = list(object({
    prefix     = string
    name       = string
    create_iam = bool
  }))
}

variable "default_tags" {
  description = "A map of tags to add to the buckets."
  type        = map(string)
}
