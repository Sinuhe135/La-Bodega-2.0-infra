resource "aws_apigatewayv2_api" "api" {
  name          = "${var.identifier}-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "default_stage" {
  api_id = aws_apigatewayv2_api.api.id
  name   = "$default"
  description = "Default stage" 

  auto_deploy = true
}

resource "aws_apigatewayv2_route" "auth_login_route" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "POST /auth/login"

  target = "integrations/${aws_apigatewayv2_integration.auth_login_integration.id}"
}

resource "aws_apigatewayv2_integration" "auth_login_integration" {
  api_id           = aws_apigatewayv2_api.api.id
  description               = "Login integration for the API Gateway"
  integration_uri           = var.lambda_function_arn

  integration_type = "AWS_PROXY"
  connection_type           = "INTERNET"
  integration_method        = "POST"
}

#check permission to invoke the lambda function
# Resource-based policy