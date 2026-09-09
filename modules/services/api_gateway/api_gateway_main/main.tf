resource "aws_apigatewayv2_api" "api" {
  name          = "${var.identifier}-api"
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = var.allow_origins
    allow_methods = ["*"]
    allow_headers = ["content-type", "authorization"]
  }
}

resource "aws_apigatewayv2_stage" "default_stage" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = "$default"
  description = "Default stage"

  auto_deploy = true
}