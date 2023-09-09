output "public_subnet" {
  value = aws_subnet.this["public_subnet"].id
}

