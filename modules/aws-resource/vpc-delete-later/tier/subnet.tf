resource "aws_subnet" "this" {
  count             = length(var.availability_zone_suffixes)
  vpc_id            = var.vpc_id
  cidr_block        = var.tiers.subnet_cidrs[count.index]
  availability_zone = "ap-southeast-2${var.availability_zone_suffixes[count.index]}"

  tags = {
    Name  = "${var.vpc_name}-${var.subnet_name}-${var.availability_zone_suffixes[count.index]}"
    Owner = "arthur"
  }
}