output "api_domain_validation_options" {
    value = aws_acm_certificate.api.domain_validation_options
}

output "domain_name" {
  value = aws_acm_certificate.api.domain_name
}

output "api_certificate_arn" {
  value = aws_acm_certificate.api.arn
}