variable "vpc_remote_state_bucket" {
  description = "The name of the S3 bucket for the VPC's remote state"
  type = string
}

variable "vpc_remote_state_key" {
 description = "The path for the VPC's remote state in S3"
 type = string
}

variable "identifier" {
  description = "The identifier for the RDS instance."
  type        = string
}

variable "db_name" {
    description = "The name of the database."
    type        = string
}

variable "db_username" { 
    description = "The username for the database."
    type        = string
    default     = "admin"
}

variable "db_password" {
    description = "The password for the database."
    type        = string
    sensitive   = true
}