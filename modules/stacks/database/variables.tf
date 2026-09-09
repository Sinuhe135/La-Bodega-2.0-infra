variable "vpc_remote_state_key" {
  description = "The VPC's remote state key for the RDS module."
  type        = string
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
