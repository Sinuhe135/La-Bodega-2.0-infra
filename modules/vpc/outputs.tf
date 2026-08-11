output "vpc_public_subnets" {
    value = module.vpc.public_subnets
    description = "List of public subnets created in the VPC"
}

output "main_security_group_id" {
    value = aws_security_group.main_sg.id
    description = "ID of the main security group created for the VPC"
}