variable "function_name" {
  description = "The name of the Lambda function."
  type        = string
}

variable "execution_role_arn" {
  description = "The ARN of the IAM role that Lambda assumes when it executes your function."
  type        = string
}