output "subnet" {
  value = aws_subnet.this[2].id
}

output "subnets" {
  value = aws_subnet.this[*].id
}


