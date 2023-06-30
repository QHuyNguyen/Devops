resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id = aws_subnet.k8s_subnet[1].id
  tags = {
    "Name" = "k8s-arthur-nat-gateway"
  }
}

resource "aws_eip" "nat_gateway_eip" {
  vpc = true
}