resource "aws_network_interface" "worker_node_eni" {
  subnet_id       = data.aws_subnet.selected_subnet.id
  private_ips     = ["10.0.1.50"]

  attachment {
    instance     = aws_instance.worker_node.id
    device_index = 1
  }
}

resource "aws_eip" "worker_node_eip" {
  vpc = true

  instance                  = aws_instance.worker_node.id
  associate_with_private_ip = "10.0.1.50"
}