module "vpc" {
  source   = "../../../../modules/aws-resource/vpc"
  vpc_cidr = var.cidr_range
  vpc_name = var.vpc_name
  owner    = var.owner
}

module "instance" {
  source         = "../../../../modules/aws-resource/ec2"
  instance_count = var.instance_count
  instance_type  = var.instance_type
  instance_name  = var.instance_name
  private_ips    = var.private_ips
  owner          = var.owner
  #  subnet_id = var.subnet_id
  public_subnet_id = module.vpc.public_subnet_id
  k8s_sg           = module.vpc.k8s_sg_id
}