resource "aws_lambda_function" "lambda" {
    function_name = var.function_name

    role          = var.execution_role_arn

    handler       = "index.handler"
    runtime       = "nodejs22.x"
    filename      = data.archive_file.example.output_path
}

data "archive_file" "example" {
  type        = "zip"
  source_file = "${path.module}/index.js"
  output_path = "${path.module}/function.zip"
}