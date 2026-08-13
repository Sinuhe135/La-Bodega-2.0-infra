module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

  name = "${var.vpc_name}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a"]

  private_subnets = ["10.0.1.0/24"] # "10.0.2.0/24
  private_subnet_tags = {
    Name = "${var.vpc_name}-private-subnet"
  }

  public_subnets  = ["10.0.101.0/24"]
  public_subnet_tags = {
    Name = "${var.vpc_name}-public-subnet"
  }

  manage_default_security_group = false
  enable_dns_hostnames    = true
}