variable "identifier" {
  description = "A unique identifier for the environment's resources (e.g. labodega-dev)."
  type        = string
}

variable "vpc_remote_state_key" {
  description = "The VPC's remote state key."
  type        = string
}

variable "rds_remote_state_key" {
  description = "The RDS/database's remote state key."
  type        = string
}

variable "regional_certificates_remote_state_key" {
  description = "The regional certificates remote state key."
  type        = string
}

variable "api_dist_path" {
  description = "Path to the compiled API Lambda functions (dist/functions)."
  type        = string
}

variable "allow_origins" {
  description = "Allowed origins for the API Gateway CORS configuration."
  type        = list(string)
}

variable "node_env" {
  description = "The NODE_ENV value passed to the Lambda functions."
  type        = string
}

variable "jwt_key" {
  description = "The JWT signing key used by the Lambda functions."
  type        = string
  sensitive   = true
}

variable "mysql_password" {
  description = "The MySQL/RDS password used by the Lambda functions."
  type        = string
  sensitive   = true
}

variable "bastion_public_key" {
  description = "The public SSH key for the bastion host's key pair."
  type        = string
}

variable "bastion_key_name" {
  description = "The name of the bastion host's AWS key pair."
  type        = string
}

variable "bastion_instance_type" {
  description = "The bastion EC2 instance's type."
  type        = string
  default     = "t3.micro"
}
