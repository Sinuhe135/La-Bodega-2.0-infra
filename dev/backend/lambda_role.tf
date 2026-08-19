
# IAM role for Lambda execution
data "aws_iam_policy_document" "lambda_role_trust_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "test_role" {
  name = "test_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_role_trust_policy.json

  tags = {
    tag-key = "tag-value"
  }
}