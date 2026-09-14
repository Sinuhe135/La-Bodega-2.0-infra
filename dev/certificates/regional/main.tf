provider "aws" {
  region = "us-west-2"
}

resource "aws_acm_certificate" "api" {
  domain_name       = "labodegapi-dev.velazduran.com"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    ManagedBy   = "terraform"
  }
}