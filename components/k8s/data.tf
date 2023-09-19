data "aws_subnet" "public_subnet_id" {
  filter {
    name   = "tag:Name"
    values = ["devops-vpc-public-subnet-A"]
  }
}

data "aws_security_group" "selected" {
  filter {
    name   = "tag:Name"
    values = ["allow_SSH_HTTP"]
  }
}