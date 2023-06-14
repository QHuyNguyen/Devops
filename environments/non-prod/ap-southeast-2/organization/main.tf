module "organization" {
    source = "../../../../modules/aws-organization"
    ou_name      = var.ou_name
}