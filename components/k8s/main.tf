module "instance_role" {
  source         = "../../modules/aws-resource/iam"
  owner          = var.owner
  role_name = var.role_name
}

module "instance" {
  source         = "../../modules/aws-resource/instance"
  instance_count = var.instance_count
  instance_type  = var.instance_type
  instance_name  = var.instance_name
  private_ips    = var.private_ips
  owner          = var.owner
  #  subnet_id = var.subnet_id
  public_subnet_id = data.aws_subnet.public_subnet_id.id
  k8s_sg           = data.aws_security_group.selected.id
  ssm_role_arn = module.instance_role.ssm_role
}