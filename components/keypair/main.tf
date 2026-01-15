module "keypair" {
  source = "../../modules/aws-resource/keypair"
  keypair_name = var.keypair_name
}