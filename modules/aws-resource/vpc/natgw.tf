resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id = aws_subnet.k8s_subnet[0].id
  tags = {
    "Name" = "k8s-arthur-nat-gateway"
  }
  depends_on = [aws_internet_gateway.k8s_igw]
}

resource "aws_eip" "nat_gateway_eip" {
  vpc = true
}