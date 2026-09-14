provider "aws" {
  region = "us-east-1"
}

resource "aws_acm_certificate" "frontend" {
  domain_name       = "labodega-dev.velazduran.com"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    ManagedBy   = "terraform"
  }
}