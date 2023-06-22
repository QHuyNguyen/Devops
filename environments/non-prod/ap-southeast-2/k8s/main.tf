module "vpc" {
  source = "../../../../modules/aws-resource/vpc"
  cidr = var.cidr_range
  vpc_name = var.vpc_name
  owner = var.owner
}

module "instance" {
  source = "../../../../modules/aws-resource/ec2"
  instance_type = var.instance_type
  instance_name = var.instance_name
  owner = var.owner
  public_subnet_id = module.vpc.public_subnet_id
}