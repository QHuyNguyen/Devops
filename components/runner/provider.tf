terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    #bucket = "arthur-cmd-state-file-bucket"
    #key    = "ec2/instance-terraform.tfstate"
    #region = "ap-southeast-2"
  }
}

provider "aws" {
  region = "ap-southeast-2"
}