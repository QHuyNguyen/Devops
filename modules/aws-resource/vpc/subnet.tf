resource "aws_subnet" "name" {
  vpc_id = aws_vpc.k8s_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-southeast-2a"

  tags = {
    Name = "k8s-vpc-subnet-A"
    Owner = "arthur"
  }
}