module "tier" {
  source                     = "./tier"
  availability_zone_suffixes = var.availability_zone_suffixes
  vpc_id                     = aws_vpc.this.id
  subnet_cidr                = var.subnet_cidr
  vpc_name                   = var.vpc_name
  tiers = var.tiers
}