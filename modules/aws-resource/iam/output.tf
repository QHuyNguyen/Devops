#output "public_subnet_id" {
#    value = aws_subnet.k8s_subnet.id
#}

output "ssm_role" {
  value = aws_iam_role.ssm_role.name
}