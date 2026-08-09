provider "aws" {
  region = "us-west-2"
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    region = "us-west-2"
    bucket = "labodega-test-state"
    key = "dev/vpc/terraform.tfstate"
  }
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

  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.main_security_group_id]
  subnet_id = data.terraform_remote_state.vpc.outputs.vpc_public_subnets[0]
  associate_public_ip_address = true

  tags = {
    Name = var.instance_name
  }
}
