terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "arthur-cmd-state-file-bucket"
    key    = "k8s/instance-terraform.tfstate"
    role_arn = "arn:aws:iam::722141136946:role/arthur-OpenID-role-test"
    region = "ap-southeast-2"
  }
}

provider "aws" {
  region = "ap-southeast-2"
  assume_role {
    role_arn = "arn:aws:iam::722141136946:role/arthur-OpenID-role-test"
  }
}