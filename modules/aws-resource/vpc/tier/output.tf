output "public_subnet" {
  value = aws_subnet.this[0].id
}

