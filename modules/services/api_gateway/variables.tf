variable "identifier" {
  description = "A unique identifier for the API Gateway"
  type        = string
}

variable "lambda_function_arn" {
  description = "The ARN of the Lambda function to integrate with the API Gateway"
  type        = string
}