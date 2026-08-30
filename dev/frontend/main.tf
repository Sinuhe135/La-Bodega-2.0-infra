provider "aws" {
  region = "us-west-2"
}

resource "aws_cloudfront_origin_access_control" "default" {
  name                              = "default-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

module "cloudfront" {
  source = "../../modules/services/cloudfront"

  certificate_remote_state_bucket = "labodega-state"
  certificate_remote_state_key = "dev/certificates/terraform.tfstate"

  aws_cloudfront_origin_access_control_id = aws_cloudfront_origin_access_control.default.id
  bucket_regional_domain_name = aws_s3_bucket.app_bucket.bucket_regional_domain_name
}