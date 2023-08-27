module "instance" {
  source = "../../../../modules/aws-resource/ec2"
  instance_count = var.instance_count
  instance_type = var.instance_type
  instance_name = var.instance_name
  private_ips = var.private_ips
  owner = var.owner
  public_subnet_id = module.vpc.public_subnet_id
  k8s_sg = module.vpc.k8s_sg_id
}