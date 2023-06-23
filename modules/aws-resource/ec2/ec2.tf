#data "aws_subnet" "selected_subnet" {
#  id = var.subnet_id
#}

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
  count = var.instance_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
#  subnet_id = var.public_subnet_id
#  subnet_id = data.aws_subnet.selected_subnet.id
  vpc_security_group_ids = var.k8s_sg

  network_interface {
    network_interface_id = aws_network_interface.worker_node_eni[count.index].id
    device_index         = 0
  }

  tags = {
    Name = element(var.instance_name, count.index)
    Owner = var.owner
  }
}