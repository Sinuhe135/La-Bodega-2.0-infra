provider "aws" {
  region = "us-west-2"
}

module "vpc"{
    source="../../modules/vpc/main_vpc"

    vpc_name = "labodega-dev"
}