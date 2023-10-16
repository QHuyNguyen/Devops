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

resource "aws_instance" "public_instance" {
  count         = var.public_instance_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
  security_groups = [var.var.k8s_sg]
  network_interface {
    network_interface_id = aws_network_interface.this[count.index].id
    device_index         = 0
  }

  tags = {
#    Name  = element(var.instance_name, count.index)
    Owner = var.owner
  }

  user_data = file("${path.module}/k8s-script.sh")
}

resource "aws_instance" "private_instance" {
  count         = var.private_instance_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id = var.private_subnet_id
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
  #network_interface {
  #  network_interface_id = aws_network_interface.this[count.index].id
  #  device_index         = 0
  #}

  tags = {
#    Name  = element(var.instance_name, count.index)
    Owner = var.owner
  }

  user_data = file("${path.module}/k8s-script.sh")
}

resource "aws_iam_instance_profile" "ssm_profile" {
  name = "test_profile"
  role = var.ssm_role_name
}