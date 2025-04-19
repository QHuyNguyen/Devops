data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = ["devops-vpc-public_subnet-a"]
  }
}

data "aws_security_group" "selected" {
  filter {
    name   = "tag:Name"
    values = ["allow_SSH_HTTP"]
  }
}