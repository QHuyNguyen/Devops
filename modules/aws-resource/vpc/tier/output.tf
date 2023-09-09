output "public_subnet" {
  value = aws_subnet.this[*].id
}

