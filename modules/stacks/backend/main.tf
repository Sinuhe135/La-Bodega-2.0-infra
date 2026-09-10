locals {
  vpc_remote_state_bucket = "labodega-state"
  rds_remote_state_bucket = "labodega-state"

  lambda_functions = {
    auth_check   = { dir = "auth", file_name = "check", route = "/auth/check", method = "GET" }
    auth_current = { dir = "auth", file_name = "current", route = "/auth/current", method = "GET" }
    auth_login   = { dir = "auth", file_name = "login", route = "/auth/login", method = "POST" }
    auth_signup  = { dir = "auth", file_name = "signup", route = "/auth/signup", method = "POST" }

    category_create  = { dir = "category", file_name = "create", route = "/category", method = "POST" }
    category_get_all = { dir = "category", file_name = "get_all", route = "/category/all", method = "GET" }

    account_create              = { dir = "account", file_name = "create", route = "/account", method = "POST" }
    account_get_all_by_category = { dir = "account", file_name = "get_all_by_category", route = "/account/all/{categoryId}", method = "GET" }
  }
}

resource "aws_key_pair" "bastion_key" {
  key_name   = var.bastion_key_name
  public_key = var.bastion_public_key
}

module "ec2" {
  source = "../../services/ec2"

  vpc_remote_state_bucket = local.vpc_remote_state_bucket
  vpc_remote_state_key    = var.vpc_remote_state_key

  instance_name = "${var.identifier}-bastion"
  instance_type = var.bastion_instance_type
  key_pair_name = aws_key_pair.bastion_key.key_name
}

module "api_gateway" {
  source = "../../services/api_gateway/api_gateway_main"

  identifier    = "${var.identifier}-api"
  allow_origins = var.allow_origins
}

module "lambda" {
  for_each = local.lambda_functions
  source   = "../../services/lambda"

  vpc_remote_state_bucket = local.vpc_remote_state_bucket
  vpc_remote_state_key    = var.vpc_remote_state_key
  rds_remote_state_bucket = local.rds_remote_state_bucket
  rds_remote_state_key    = var.rds_remote_state_key

  function_name      = "${var.identifier}-${replace(each.key, "_", "-")}"
  execution_role_arn = aws_iam_role.lambda_execution_role.arn
  timeout            = 10

  jwt_key        = var.jwt_key
  mysql_password = var.mysql_password
  node_env       = var.node_env

  file_path = "${var.api_dist_path}/${each.value.dir}"
  file_name = each.value.file_name

  api_gateway_execution_arn = module.api_gateway.api_execution_arn

  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs,
    aws_iam_role_policy_attachment.lambda_vpc_access,
  ]
}

module "api_gateway_route" {
  source = "../../services/api_gateway/api_gateway_route"

  for_each = module.lambda

  api_gateway_id      = module.api_gateway.api_id
  lambda_function_arn = each.value.lambda_invoke_arn

  route  = local.lambda_functions[each.key].route
  method = local.lambda_functions[each.key].method
}
