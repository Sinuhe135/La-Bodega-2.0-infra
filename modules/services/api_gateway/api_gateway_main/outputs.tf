output "api_id" {
  value = aws_apigatewayv2_api.api.id
}

output "api_execution_arn" {
  value = aws_apigatewayv2_api.api.execution_arn
}

output "api_url" {
  value       = "${aws_apigatewayv2_api.api.api_endpoint}"
  description = "API Gateway endpoint URL"
}

output "api_domain_name_configuration" {
  value       = aws_apigatewayv2_domain_name.domain.domain_name_configuration
  description = "API Gateway domain name configuration"
}