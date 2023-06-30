resource "aws_network_acl" "k8s_nacl" {
  vpc_id = aws_vpc.k8s_vpc.id

  egress {
    protocol   = "all"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "all"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "k8s-subnet-nacl"
    Owner = var.owner
  }
}

resource "aws_network_acl_association" "main" {
  count = var.subnet_count
  network_acl_id = aws_network_acl.k8s_nacl.id
  subnet_id      = aws_subnet.k8s_subnet[count.index].id
}