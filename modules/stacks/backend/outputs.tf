output "api_gateway_endpoint" {
  value       = module.api_gateway.api_url
  description = "API Gateway endpoint URL"
}

output "api_gateway_domain_name_configuration" {
  value       = module.api_gateway.api_domain_name_configuration
  description = "API Gateway domain name configuration"
}
