#module "identity" {
#  source = "../../modules/aws-resource/iam"
#  owner = var.owner
#  role_name = var.role_name
#}

data "aws_iam_role" "ssm_role" {
  name = "ssm-arthur"
}

module "ansible" {
  source = "../../modules/aws-resource/ec2"
  instance_type = var.instance_type
  instance_name = var.instance_name
  owner = var.owner
  public_subnet_id = data.aws_subnet.selected.id
  k8s_sg = data.aws_security_group.selected.id
  instance_count = var.instance_count
  private_ips = var.private_ips
  ssm_role_name = data.aws_iam_role.ssm_role.name
  apply_script = var.apply_script
  script_path = var.script_path
  instance_profile_name = var.instance_profile_name
  aws_key_pair = data.aws_key_pair.existing.key_name
  requires_extra_storage = var.requires_extra_storage
}