module "organization" {
    source = "../../../../modules/aws-organization"
    ou_name      = var.random_name
}