variable "api_gateway_id" {
  description = "The ID of the API Gateway"
  type        = string
}

variable "lambda_function_arn" {
  description = "The ARN of the Lambda function to integrate with the API Gateway"
  type        = string
}

variable "route" {
  description = "The route key for the API Gateway route (e.g., '/auth/login')"
  type        = string
}

variable "method" {
  description = "The HTTP method for the API Gateway route (e.g., 'POST')"
  type        = string
}