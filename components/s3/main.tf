module "bucket" {
  source = "../../modules/aws-resource/s3"
  region = var.region
  environment = var.environment
  owner = var.owner
}