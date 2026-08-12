terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  required_version = ">= 1.2"

  backend "s3" {
    bucket = "labodega-state"
    key = "global/s3/terraform.tfstate"
    region = "us-west-2"
    use_lockfile = true
    encrypt = true
  }
}