provider "aws" {
  region = "us-west-2"
}

module "frontend" {
  source = "../../modules/stacks/frontend"

  identifier                   = "labodega-dev"
  certificate_remote_state_key = "dev/certificates/cloudfront/terraform.tfstate"
  source_dir = "${path.module}/../../../La-Bodega-2.0-Frontend/dist"
}