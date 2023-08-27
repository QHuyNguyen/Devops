resource "aws_subnet" "this" {
  count = var.subnet_count
  vpc_id = aws_vpc.this.id
  cidr_block = var.subnet_cidr[count.index]
  availability_zone = "ap-southeast-2a"
  

  tags = {
    Name = element(var.subnet_name, count.index)
    Owner = "arthur"
  }
}