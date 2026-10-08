provider "aws" {
  region = "us-west-2"
}

resource "aws_budgets_budget" "demo" {
  name              = "Demo Budget"
  budget_type       = "COST"
  time_unit         = "MONTHLY"

  limit_amount      = "20"
  limit_unit        = "USD"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 50
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = ["sinuhe9999@gmail.com"]
  }
  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = ["sinuhe9999@gmail.com"]
  }
  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = ["sinuhe9999@gmail.com"]
  }

}