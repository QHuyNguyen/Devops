output "subnet_az_a" {
  value = aws_subnet.this[0].id
}

output "subnets" {
  value = aws_subnet.this[*].id
}


