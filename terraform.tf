terraform {
  cloud {
    organization = "TerranovaLabs"

    workspaces {
      project = "Learn Terraform"
      name = "learn-terraform-aws-get-started"
    }
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