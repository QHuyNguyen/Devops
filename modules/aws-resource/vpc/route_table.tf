resource "aws_route_table" "k8s_custom_rt" {
  vpc_id = aws_vpc.k8s_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k8s_igw.id
  }

  tags = {
    Name = "k8s-rt"
    Owner = var.owner
  }
}

resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.k8s_vpc.id
  route_table_id = aws_route_table.k8s_custom_rt.id
}