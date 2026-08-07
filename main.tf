provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

  name = "example-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24"]
  manage_default_security_group = true

  enable_dns_hostnames    = true
}

#define security group for the EC2 instance

resource "aws_security_group" "main_sg" {
  name = "main_sg"
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

# EC2 instance configuration

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "key_pair" {
  key_name = "test-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH26iS1w31qt95EMjBYGSz37N+TQJ0vYHMoItWR09A+z terraform-test"
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = aws_key_pair.key_pair.key_name

  vpc_security_group_ids = [aws_security_group.main_sg.id]
  subnet_id = module.vpc.public_subnets[0]
  associate_public_ip_address = true

  tags = {
    Name = var.instance_name
  }
}
