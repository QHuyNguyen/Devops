#resource "aws_network_acl" "k8s_nacl" {
#  vpc_id = aws_vpc.k8s_vpc.id
#
#  egress {
#    protocol   = "tcp"
#    rule_no    = 200
#    action     = "allow"
#    cidr_block = "0.0.0.0/0"
#    from_port  = 443
#    to_port    = 443
#  }
#
#  ingress {
#    protocol   = "tcp"
#    rule_no    = 100
#    action     = "allow"
#    cidr_block = "0.0.0.0/0"
#    from_port  = 80
#    to_port    = 80
#  }
#
#  tags = {
#    Name = "k8s-subnet-nacl"
#    Owner = var.owner
#  }
#}
#
#resource "aws_network_acl_association" "main" {
#  network_acl_id = aws_network_acl.k8s_nacl.id
#  subnet_id      = aws_subnet.k8s_subnet.id
#}