resource "aws_subnet" "k8s_subnet" {
  count = var.subnet_count
  vpc_id = aws_vpc.k8s_vpc.id
  cidr_block = var.subnet_cidr[count.index]
  availability_zone = "ap-southeast-2a"

  tags = {
    Name = "k8s-vpc-subnet-A"
    Owner = "arthur"
  }
}