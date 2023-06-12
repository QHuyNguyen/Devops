data "aws_organizations_organization" "example" {}

resource "aws_organizations_organizational_unit" "example" {
  name      = "example"
  parent_id = data.aws_organizations_organization.example.roots[0].id
}