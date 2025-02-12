terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "arthur-mantel-ap-southeast-2-bucket"
    #    key    = "test-vpc/instance-terraform.tfstate"
    key    = "infrastructure/session-manager/instance-terraform.tfstate"
    region = "ap-southeast-2"
  }
}

provider "aws" {
  region = "ap-southeast-2"
}