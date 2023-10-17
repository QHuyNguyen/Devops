data "aws_organizations_organization" "org" {}

resource "aws_organizations_organizational_unit" "non_prod" {
  name      = var.ou_name
  parent_id = data.aws_organizations_organization.org.roots[0].id
}