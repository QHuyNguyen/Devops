output "public_subnet_id" {
    value = aws_subnet.k8s_subnet.id
}

output "k8s_sg_id" {
    value = aws_security_group.allow_SSH_HTTP.id
}