resource "aws_apigatewayv2_integration" "integration" {
  api_id           = var.api_gateway_id
  integration_uri           = var.lambda_function_arn

  integration_type = "AWS_PROXY"
  connection_type           = "INTERNET"
  integration_method        = "POST"
}

resource "aws_apigatewayv2_route" "route" {
  api_id    = var.api_gateway_id
  route_key = "${var.method} ${var.route}"

  target = "integrations/${aws_apigatewayv2_integration.integration.id}"
}