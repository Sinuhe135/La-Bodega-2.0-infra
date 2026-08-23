data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    region = "us-west-2"
    bucket = var.vpc_remote_state_bucket
    key = var.vpc_remote_state_key
  }
}

data "terraform_remote_state" "rds" {
  backend = "s3"
  config = {
    region = "us-west-2"
    bucket = var.rds_remote_state_bucket
    key = var.rds_remote_state_key
  }
}

resource "aws_lambda_function" "lambda" {
    function_name = var.function_name
    role          = var.execution_role_arn

    runtime       = "nodejs22.x"
    handler       = "${var.file_name}.handler"
    filename      = data.archive_file.example.output_path
    
    timeout = 10

    # environment {
    #   variables = {
    #     JWT_KEY        = var.jwt_key
    #     MYSQL_HOST     = data.terraform_remote_state.rds.outputs.endpoint
    #     MYSQL_PORT     = data.terraform_remote_state.rds.outputs.port
    #     MYSQL_DATABASE = data.terraform_remote_state.rds.outputs.database_name
    #     MYSQL_USER     = data.terraform_remote_state.rds.outputs.username
    #     MYSQL_PASSWORD = var.mysql_password
    #     NODE_ENV       = var.node_env
    #   }
    # }

    logging_config {
      log_format            = "JSON"
      application_log_level = "INFO"
      system_log_level      = "WARN"
    }

    vpc_config {
      subnet_ids         = [
        data.terraform_remote_state.vpc.outputs.vpc_private_subnets[0], 
        data.terraform_remote_state.vpc.outputs.vpc_private_subnets[1]
      ]
      security_group_ids = [
        data.terraform_remote_state.vpc.outputs.default_security_group_id
      ]
    }

    depends_on = [
      aws_cloudwatch_log_group.log_group
    ]
}

resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 14

  tags = {
    Function    = var.function_name
  }
}

data "archive_file" "example" {
  type        = "zip"
  source_file = "${var.file_path}/${var.file_name}.${var.function_extension}"
  output_path = "${path.module}/${var.function_name}.zip"
}