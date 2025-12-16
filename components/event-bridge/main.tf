module "event-bridge" {
  source = "../../modules/aws-resource/event-bridge"
  lambda_arn = var.lambda_arn
  lambda_name = var.lambda_name
}