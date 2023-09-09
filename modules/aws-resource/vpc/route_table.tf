resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "devops-public-rt"
    Owner = var.owner
  }
}

resource "aws_route_table_association" "public_asso" {
  subnet_id = module.tier["public_subnet"].public_subnet
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.this.id
  }

  tags = {
    Name = "devops-private-rt"
    Owner = var.owner
  }
}

resource "aws_route_table_association" "private_asso" {
  subnet_id = module.tier["private_subnet"].public_subnet
  route_table_id = aws_route_table.private_rt.id
}