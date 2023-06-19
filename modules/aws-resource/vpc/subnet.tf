resource "aws_subnet" "name" {
  vpc_id = aws_vpc.k8s_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Subnet A"
    Owner = "arthur"
  }
}