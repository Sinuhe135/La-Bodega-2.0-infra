provider "aws" {
  region = "us-west-2"
}

# resource "aws_key_pair" "key_pair" {
#   key_name = "test-key"
#   public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH26iS1w31qt95EMjBYGSz37N+TQJ0vYHMoItWR09A+z terraform-test"
# }

module "rds" {
  source = "../../modules/services/rds"

  vpc_remote_state_bucket = "labodega-state"
  vpc_remote_state_key = "dev/vpc/terraform.tfstate"

  identifier = "labodega-dev"

  db_name = "labodega"
  db_username = "admin"
  db_password = var.db_password
}