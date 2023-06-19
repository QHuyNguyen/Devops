resource "aws_vpc" "k8s_vpc" {
  cidr_block = var.cidr
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
    Owner = var.owner
  }
}