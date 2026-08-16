variable "db_password" {
  description = "The password for the RDS database."
  type        = string
  sensitive   = true
} # TF_VAR_db_password