provider "aws" {
  region = "us-west-2"
}

module "vpc"{
    source="../../modules/vpc"

    vpc_name = "test"
}