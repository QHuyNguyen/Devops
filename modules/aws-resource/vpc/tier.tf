module "tier" {
  availability_zone_suffixes = var.availability_zone_suffixes
  vpc_id = aws_vpc.this.id
  subnet_cidr = ar.subnet_cidr
  vpc_name = var.vpc_name
}