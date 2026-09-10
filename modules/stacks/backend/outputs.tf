output "api_gateway_endpoint" {
  value       = module.api_gateway.api_url
  description = "API Gateway endpoint URL"
}
