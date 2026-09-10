provider "aws" {
  region = "us-west-2"
}

module "backend" {
  source = "../../modules/stacks/backend"

  identifier           = "labodega-dev"
  vpc_remote_state_key = "dev/vpc/terraform.tfstate"
  rds_remote_state_key = "dev/database/terraform.tfstate"

  bastion_key_name   = "bastion-key"
  bastion_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPMKmX6BLFkflv0olZnBs5y6Ldikxy31c6fPjgKzt/M1 rayma@TunelCuantico"
  
  api_dist_path = "${path.module}/../../../La-Bodega-2.0-API/dist/functions"
  allow_origins = ["https://labodega-dev.velazduran.com", "http://localhost:3000"]
  node_env      = "development"
  jwt_key        = var.jwt_key
  mysql_password = var.mysql_password
}
