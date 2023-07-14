variable "project_name" {
  type        = string
  description = "The name to be used for prefixing S3 and Lambda names."
  default     = ""
}

variable "aws_region" {
  type        = string
  description = "The AWS region to use for everything."
  default     = "eu-central-1"
}
