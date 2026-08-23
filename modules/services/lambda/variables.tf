variable "vpc_remote_state_bucket" {
  description = "The name of the S3 bucket for the VPC's remote state"
  type = string
}

variable "vpc_remote_state_key" {
 description = "The path for the VPC's remote state in S3"
 type = string
}

variable "rds_remote_state_bucket" {
  description = "The name of the S3 bucket for the RDS's remote state"
  type = string
}

variable "rds_remote_state_key" {
 description = "The path for the RDS's remote state in S3"
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

variable "timeout" {
  description = "The amount of time that Lambda allows a function to run before stopping it."
  type        = number
  default     = 10
}

variable "jwt_key" {
  type      = string
  sensitive = true
}

variable "mysql_password" {
  type      = string
  sensitive = true
}

variable "node_env" {
  type = string
}

variable "file_path" {
  description = "The path to the Lambda function file"
  type        = string
}

variable "file_name" {
  description = "The name of the Lambda function file"
  type        = string
}