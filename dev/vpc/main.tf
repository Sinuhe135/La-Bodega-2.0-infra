provider "aws" {
  region = "us-west-2"
}

module "vpc"{
    source="../../modules/stacks/vpc"

    vpc_name = "labodega-dev"
}