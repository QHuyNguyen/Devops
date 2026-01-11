data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "this" {
  count         = var.instance_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.test_profile.name
  key_name = var.aws_key_pair

  network_interface {
    network_interface_id = aws_network_interface.this[count.index].id
    device_index         = 0
  }

  tags = {
    Name  = element(var.instance_name, count.index)
    Owner = var.owner
  }
  
  user_data = var.apply_script ? file("${path.module}/${var.script_path}") : null
  
  dynamic "root_block_device" {
    for_each = var.requires_extra_storage ? [1] : []
    content {
      volume_size = 50
      volume_type = "gp3"
      encrypted   = true
      delete_on_termination = true
    }
  }
}

resource "aws_iam_instance_profile" "test_profile" {
  name = var.instance_profile_name # FIRST THING TO DO TMR IS TO DELETE MASTER NODE INSTANCE THEN CREATE VARIABLE FOR INSTANCE PROFILE NAME
  role = var.ssm_role_name
}