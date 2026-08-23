provider "aws" {
  region = "us-west-2"
}

# resource "aws_key_pair" "key_pair" {
#   key_name = "test-key"
#   public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH26iS1w31qt95EMjBYGSz37N+TQJ0vYHMoItWR09A+z terraform-test"
# }

module "lambda" {
  source = "../../modules/services/lambda"

  vpc_remote_state_bucket = "labodega-state"
  vpc_remote_state_key = "dev/vpc/terraform.tfstate"
  rds_remote_state_bucket = "labodega-state"
  rds_remote_state_key = "dev/database/terraform.tfstate"

  function_name = "labodega-dev-auth-check"
  execution_role_arn = aws_iam_role.lambda_execution_role.arn

  jwt_key        = var.jwt_key
  mysql_password = var.mysql_password
  node_env = "development"

  file_path = "${path.module}/../../../La-Bodega-2.0-API/dist/functions/auth"
  file_name = "check"
  function_extension = "js"

  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs,
    aws_iam_role_policy_attachment.lambda_vpc_access,
  ]
}