output "frontend_domain_validation_options" {
    value = aws_acm_certificate.frontend.domain_validation_options
}

output "domain_name" {
  value = aws_acm_certificate.frontend.domain_name
}

output "frontend_certificate_arn" {
  value = aws_acm_certificate.frontend.arn
}