terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.7.1"
    }
  }

  #backend "s3" {
  #  bucket = "arthur-tf-state-bucket"
  #  key    = "s3/bucket-terraform.tfstate"
  #  region = "ap-southeast-2"
  #}
}

provider "aws" {
  profile = "default"
  region = "ap-southeast-2"
}