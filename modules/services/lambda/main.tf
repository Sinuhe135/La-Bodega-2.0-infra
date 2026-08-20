resource "aws_lambda_function" "lambda" {
    function_name = var.function_name

    role          = var.execution_role_arn

    handler       = "index.handler"
    runtime       = "nodejs22.x"
    filename      = data.archive_file.example.output_path

    logging_config {
      log_format            = "JSON"
      application_log_level = "INFO"
      system_log_level      = "WARN"
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
  source_file = "${path.module}/index.js"
  output_path = "${path.module}/function.zip"
}