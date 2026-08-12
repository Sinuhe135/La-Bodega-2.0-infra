provider "aws" {
  region = "us-west-2"
}

resource "aws_key_pair" "key_pair" {
  key_name = "test-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH26iS1w31qt95EMjBYGSz37N+TQJ0vYHMoItWR09A+z terraform-test"
}

module "backend" {
 source = "../../../modules/services/ec2" 

 instance_name = "learn-terraform-1"

 vpc_remote_state_bucket = "labodega-test-state"
 vpc_remote_state_key = "dev/vpc/terraform.tfstate"
 key_pair_name = aws_key_pair.key_pair.key_name
}

module "backend2" {
 source = "../../../modules/services/ec2" 

 instance_name = "learn-terraform-2"

 vpc_remote_state_bucket = "labodega-test-state"
 vpc_remote_state_key = "dev/vpc/terraform.tfstate"
 key_pair_name = aws_key_pair.key_pair.key_name
}
