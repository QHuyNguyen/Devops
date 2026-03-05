#output "public_subnet_id" {
#    value = aws_subnet.k8s_subnet.id
#}

output "ssm_role" {
  value = module.identity.ssm_role
}