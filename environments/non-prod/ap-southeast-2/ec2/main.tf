module "instance" {
  source = "../../../../modules/aws-resource/ec2"
  instance_type = var.instance_type
  name = var.name
  owner = var.owner
  subnet_id = var.subnet_id
}