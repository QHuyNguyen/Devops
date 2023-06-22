resource "aws_subnet" "k8s_subnet" {
  vpc_id = aws_vpc.k8s_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-southeast-2a"

  depends_on = [aws_internet_gateway.k8s_igw]

  tags = {
    Name = "k8s-vpc-subnet-A"
    Owner = "arthur"
  }
}