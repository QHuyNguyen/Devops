module "vpc" {
  source = "../../../../modules/aws-resource/vpc"
  cidr = var.cidr
  vpc_name = var.name
}