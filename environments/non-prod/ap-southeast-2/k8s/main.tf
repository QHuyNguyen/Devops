module "vpc" {
  source = "../../../../modules/aws-resource/vpc"
  cidr = var.cidr_range
  vpc_name = var.vpc_name
  owner = var.owner
}

module "instance" {
  for_each = var.instance_name
  source = "../../../../modules/aws-resource/ec2"
  instance_name = each.value
  instance_type = var.instance_type
  owner = var.owner
  public_subnet_id = module.vpc.public_subnet_id
}