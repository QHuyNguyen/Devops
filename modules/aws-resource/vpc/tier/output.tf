output "public_subnet" {
  value = aws_subnet.this["devops-vpc-public_subnet-*"].id
}

