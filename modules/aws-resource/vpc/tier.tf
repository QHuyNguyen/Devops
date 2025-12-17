#module "tier" {
#    source = "./tier"
#    for_each = var.tiers
#    vpc_name = var.vpc_name
#    vpc_id = aws_vpc.this.id
#    subnet_name = each.value
#    subnet_cidr = ["sdfd"]
#    tiers = each.value
#}
module "tier" {
  source      = "./tier"
  for_each    = var.tiers
  vpc_id      = aws_vpc.this.id
  vpc_name    = var.vpc_name
  tiers       = each.value
  subnet_name = each.key
}