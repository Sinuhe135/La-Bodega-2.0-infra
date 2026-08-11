module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

  name = "${var.vpc_name}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24"]
  manage_default_security_group = true

  enable_dns_hostnames    = true
}

#define security group for the EC2 instance

resource "aws_security_group" "main_sg" {
  name = "${var.vpc_name}-main_sg"
  description = "Allow SSH"
  vpc_id = module.vpc.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ingress" {
  security_group_id = aws_security_group.main_sg.id
  ip_protocol = "tcp"

  from_port = 22
  to_port = 22
  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_egress" {
  security_group_id = aws_security_group.main_sg.id
  ip_protocol = "-1"

  cidr_ipv4 = "0.0.0.0/0"
}