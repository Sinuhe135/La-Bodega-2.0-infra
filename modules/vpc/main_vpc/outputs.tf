output "vpc_public_subnets" {
    value = module.vpc.public_subnets
    description = "List of public subnets created in the VPC"
}

output "vpc_private_subnets" {
    value = module.vpc.private_subnets
    description = "List of private subnets created in the VPC"
}

output "default_security_group_id" {
  value = module.vpc.default_security_group_id
  description = "ID of the default security group created for the VPC"
}

output "bastion_security_group_id" {
    value = aws_security_group.bastion_sg.id
    description = "ID of the bastion security group created for the VPC"
}