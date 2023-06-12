data "aws_organizations_organization" "org" {}

resource "aws_organizations_organizational_unit" "non_prod" {
  name      = "Non Prod"
  parent_id = data.aws_organizations_organization.org.roots.id
}