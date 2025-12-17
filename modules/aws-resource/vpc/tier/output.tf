output "subnet_az" {
  value = aws_subnet.this[*].id
}