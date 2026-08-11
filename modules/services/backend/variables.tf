variable "instance_name" {
  description = "Value of the EC2 instance's Name tag."
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance's type."
  type        = string
  default     = "t3.micro"
}

variable "vpc_remote_state_bucket" {
  description = "The name of the S3 bucket for the VPC's remote state"
  type = string
}

variable "vpc_remote_state_key" {
 description = "The path for the VPC's remote state in S3"
 type = string
}

variable "key_pair_name" {
  description = "The ID of the AWS key pair."
  type        = string
}
