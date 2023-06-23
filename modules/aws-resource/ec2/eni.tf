resource "aws_network_interface" "worker_node_eni" {
  count = var.instance_count
  subnet_id       = var.public_subnet_id
  private_ips     = var.private_ips

  tags = {
    Name = join("-", ["k8s_primary_network_interface", count.index])
    Owner = var.owner
  }
}

resource "aws_eip" "worker_node_eip" {
  vpc = true
  count = var.instance_count
  network_interface = aws_network_interface.worker_node_eni[count.index].id
  associate_with_private_ip = var.private_ips
  depends_on        = [aws_instance.worker_node]
  tags = {
    Name = join("-", ["k8s_eip", count.index])
    Owner = var.owner
  }
}