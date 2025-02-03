module "ansible" {
  source = "../../modules/aws-resource/ec2"
  instance_type = var.instance_type
  instance_name = var.instance_name
  owner = var.owner
  public_subnet_id = var.public_subnet_id
  k8s_sg = var.k8s_sg
  instance_count = var.instance_count
  private_ips = var.private_ips
  ssm_role_name = var.ssm_role_name
}