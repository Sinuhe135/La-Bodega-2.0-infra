provider "aws" {
  region = "us-west-2"
}

module "database" {
  source = "../../modules/stacks/database"

  vpc_remote_state_key = "dev/vpc/terraform.tfstate"
  identifier  = "labodega-dev"

  db_name     = "labodega"
  db_username = "admin"
  db_password = var.db_password
}

# test vpc and database creation