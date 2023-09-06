resource "aws_subnet" "this" {
  count             = length(var.availability_zone_suffixes)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.subnet_cidr[count.index]
  availability_zone = "ap-southeast-2${var.availability_zone_suffixes[count.index]}"

  tags = {
    Name  = "${var.vpc_name}-subnet-${var.availability_zone_suffixes[count.index]}"
    Owner = "arthur"
  }
}