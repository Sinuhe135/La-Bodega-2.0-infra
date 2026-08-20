
variable "vpc_remote_state_bucket" {
  description = "The name of the S3 bucket for the VPC's remote state"
  type = string
}

variable "vpc_remote_state_key" {
 description = "The path for the VPC's remote state in S3"
 type = string
}

variable "function_name" {
  description = "The name of the Lambda function."
  type        = string
}

variable "execution_role_arn" {
  description = "The ARN of the IAM role that Lambda assumes when it executes your function."
  type        = string
}