data "aws_subnet" "public_subnet_id" {
  filter {
    name   = "tag:Name"
    values = ["devops-vpc-test-public_subnet-a"]
  }
}

data "aws_subnet" "private_subnet_id" {
  filter {
    name   = "tag:Name"
    values = ["devops-vpc-test-private_subnet-a"]
  }
}

data "aws_security_group" "selected" {
  filter {
    name   = "tag:Name"
    values = ["allow_SSH_HTTP"]
  }
}