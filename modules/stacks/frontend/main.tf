locals {
  certificate_remote_state_bucket = "labodega-state"
}

resource "aws_s3_bucket" "app_bucket" {
  bucket = "${var.identifier}-frontend"
}

resource "aws_cloudfront_origin_access_control" "default" {
  name                              = "${var.identifier}-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

module "cloudfront" {
  source = "../../services/cloudfront"

  certificate_remote_state_bucket = local.certificate_remote_state_bucket
  certificate_remote_state_key    = var.certificate_remote_state_key

  bucket_regional_domain_name             = aws_s3_bucket.app_bucket.bucket_regional_domain_name
  aws_cloudfront_origin_access_control_id = aws_cloudfront_origin_access_control.default.id
}
