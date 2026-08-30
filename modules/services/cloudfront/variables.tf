variable "certificate_remote_state_bucket" {
  description = "S3 bucket for the certificate manager remote state"
  type        = string
}

variable "certificate_remote_state_key" {
  description = "S3 key for the certificate manager remote state"
  type        = string
}

variable "bucket_regional_domain_name" {
  type        = string
}

variable "s3_origin_id" {
  type = string
  description = "ID of the origin of the distribution"
  default = "frontend-s3-origin"
}

variable "aws_cloudfront_origin_access_control_id" {
  type = string
}