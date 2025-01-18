module "vpc" {
  source   = "../../modules/aws-resource/vpc-testing"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
  tiers    = local.tiers
  owner    = var.owner
}