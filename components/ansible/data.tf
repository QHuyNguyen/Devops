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

data "aws_key_pair" "existing" {
  key_name = "cluster-key"
}

data "aws_iam_role" "ssm_role" {
  name = "ssm-arthur"
}

data "terraform_remote_state" "key_pair" {
  backend = "s3"
  config = {
    bucket = "devops-blog-arthur-200"
    key    = "infrastructure/keypair/instance-terraform.tfstate"
    region = "ap-southeast-2"
  }
}

data "terraform_remote_state" "role" {
  backend = "s3"
  config = {
    bucket = "devops-blog-arthur-200"
    key    = "infrastructure/session-manager/instance-terraform.tfstate"
    region = "ap-southeast-2"
  }
}