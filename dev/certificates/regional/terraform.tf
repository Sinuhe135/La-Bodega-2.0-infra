terraform {
  backend "s3" {
    bucket       = "labodega-state"
    key          = "dev/certificates/regional/terraform.tfstate"
    region       = "us-west-2"
    use_lockfile = true
    encrypt      = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  required_version = ">= 1.2"
}

#export AWS_ACCESS_KEY_ID=
#export AWS_SECRET_ACCESS_KEY=
#aws configure list