resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id = module.tier["public_subnet"].public_subnet
  tags = {
    "Name" = "devops-nat-gateway"
  }
  depends_on = [aws_internet_gateway.this]
}

resource "aws_eip" "this" {
  vpc = true
}