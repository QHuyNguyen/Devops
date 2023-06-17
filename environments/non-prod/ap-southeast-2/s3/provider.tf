terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.0"
    }
  }

  #backend "s3" {
  #  bucket = "arthur-tf-state-bucket"
  #  key    = "s3/bucket-terraform.tfstate"
  #  region = "ap-southeast-2"
  #}
}

#provider "aws" {
#  region = "ap-southeast-2"
#}