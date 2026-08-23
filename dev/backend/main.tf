provider "aws" {
  region = "us-west-2"
}

locals {
  api_dist_path = "${path.module}/../../../La-Bodega-2.0-API/dist/functions"

  lambda_common = {
    vpc_remote_state_bucket = "labodega-state"
    vpc_remote_state_key    = "dev/vpc/terraform.tfstate"
    rds_remote_state_bucket = "labodega-state"
    rds_remote_state_key    = "dev/database/terraform.tfstate"
    execution_role_arn      = aws_iam_role.lambda_execution_role.arn
    jwt_key                 = var.jwt_key
    mysql_password          = var.mysql_password
    node_env                = "development"
  }

  lambda_functions = {
    auth_check                  = { dir = "auth", file_name = "check" }
    auth_current                = { dir = "auth", file_name = "current" }
    auth_login                  = { dir = "auth", file_name = "login" }
    auth_signup                 = { dir = "auth", file_name = "signup" }

    category_create             = { dir = "category", file_name = "create" }
    category_get_all            = { dir = "category", file_name = "get_all" }

    account_create              = { dir = "account", file_name = "create" }
    account_get_all_by_category = { dir = "account", file_name = "get_all_by_category" }
  }
}

# resource "aws_key_pair" "key_pair" {
#   key_name = "test-key"
#   public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH26iS1w31qt95EMjBYGSz37N+TQJ0vYHMoItWR09A+z terraform-test"
# }

module "lambda" {
  for_each = local.lambda_functions
  source   = "../../modules/services/lambda"

  vpc_remote_state_bucket = local.lambda_common.vpc_remote_state_bucket
  vpc_remote_state_key    = local.lambda_common.vpc_remote_state_key
  rds_remote_state_bucket = local.lambda_common.rds_remote_state_bucket
  rds_remote_state_key    = local.lambda_common.rds_remote_state_key

  function_name      = "labodega-dev2-${replace(each.key, "_", "-")}"
  execution_role_arn = local.lambda_common.execution_role_arn

  jwt_key        = local.lambda_common.jwt_key
  mysql_password = local.lambda_common.mysql_password
  node_env       = local.lambda_common.node_env

  file_path          = "${local.api_dist_path}/${each.value.dir}"
  file_name          = each.value.file_name

  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs,
    aws_iam_role_policy_attachment.lambda_vpc_access,
  ]
}