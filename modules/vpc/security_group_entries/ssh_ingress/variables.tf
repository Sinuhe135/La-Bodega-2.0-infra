variable "security_group_id" {
  description = "The ID of the security group to which the egress rules will be applied."
  type        = string
}

variable "cidr_ipv4" {
  description = "The CIDR block to allow egress traffic to."
  type        = string
}