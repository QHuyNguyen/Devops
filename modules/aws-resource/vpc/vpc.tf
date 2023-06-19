resource "aws_vpc" "k8s_vpc" {
  cidr_block = var.cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = var.vpc_name
    Owner = var.owner
  }
}