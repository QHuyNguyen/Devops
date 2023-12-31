module "vpc" {
  source       = "../../modules/aws-resource/vpc"
  vpc_cidr     = var.vpc_cidr
  subnet_count = var.subnet_count
  subnet_cidr  = var.subnet_cidr
  vpc_name     = var.vpc_name
  owner        = var.owner
  #  subnet_name  = var.subnet_name
  tiers = local.tiers
}