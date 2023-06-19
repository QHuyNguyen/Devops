module "vpc" {
  source = "../../../../modules/aws-resource/vpc"
  cidr = var.cidr_range
  vpc_name = var.name
  owner = var.owner
}