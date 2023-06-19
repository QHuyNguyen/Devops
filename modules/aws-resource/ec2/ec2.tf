data "aws_subnets" "k8s_subnet" {
  filter {
    name   = "k8s-vpc-subnet-A"
    values = ["k8s-vpc-subnet-A"]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "worker_node" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id = data.aws_subnets.k8s_subnet.id

  tags = {
    Name = var.name
    Owner = var.owner
  }
}