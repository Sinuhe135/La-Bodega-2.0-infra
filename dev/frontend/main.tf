provider "aws" {
  region = "us-west-2"
}

module "frontend" {
  source = "../../modules/stacks/frontend"

  identifier                   = "labodega-dev"
  certificate_remote_state_key = "dev/certificates/terraform.tfstate"
}