data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    region = "us-west-2"
    bucket = var.vpc_remote_state_bucket
    key = var.vpc_remote_state_key
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

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = var.key_pair_name

  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.main_security_group_id]
  subnet_id = data.terraform_remote_state.vpc.outputs.vpc_public_subnets[0]
  associate_public_ip_address = true

  tags = {
    Name = var.instance_name
  }
}
