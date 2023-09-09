resource "aws_nat_gateway" "this" {
  #count = length(var.availability_zone_suffixes)
  allocation_id = aws_eip.this.id
  subnet_id = module.tier["public_subnet"].subnet_az_a
  tags = {
    "Name" = "devops-nat-gateway"
  }
  depends_on = [aws_internet_gateway.this]
}

resource "aws_eip" "this" {
  vpc = true
}