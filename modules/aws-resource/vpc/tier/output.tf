output "public_subnet" {
  value = aws_subnet.this[0].id
}

output "private_subnet" {
  value = aws_subnet.this[1].id
}

output "subnet" {
  value = aws_subnet.this[*].id
}


