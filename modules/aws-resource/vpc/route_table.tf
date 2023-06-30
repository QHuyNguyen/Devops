resource "aws_route_table" "k8s_public_rt" {
  vpc_id = aws_vpc.k8s_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k8s_igw.id
  }

  tags = {
    Name = "k8s-public-rt"
    Owner = var.owner
  }
}

resource "aws_route_table_association" "public_asso" {
  subnet_id = aws_subnet.k8s_subnet[0].id
  route_table_id = aws_route_table.k8s_public_rt.id
}

resource "aws_route_table" "k8s_private_rt" {
  vpc_id = aws_vpc.k8s_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "k8s-private-rt"
    Owner = var.owner
  }
}

resource "aws_route_table_association" "public_asso" {
  subnet_id = aws_subnet.k8s_subnet[1].id
  route_table_id = aws_route_table.k8s_private_rt.id
}