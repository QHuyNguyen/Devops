resource "aws_network_interface" "worker_node_eni" {
  subnet_id       = data.aws_subnet.selected_subnet.id
  private_ips     = ["10.0.1.50"]

  tags = {
    Name = "k8s_primary_network_interface"
    Owner = var.owner
  }
}

resource "aws_eip" "worker_node_eip" {
  vpc = true

  network_interface = aws_network_interface.worker_node_eni.id

  tags = {
    Name = "k8s_eip"
    Owner = var.owner
  }
}