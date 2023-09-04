resource "aws_network_interface" "runner_eni" {
  count = var.instance_count
  subnet_id       = var.public_subnet_id
  private_ips     = [var.private_ips[count.index]]
  security_groups = [var.k8s_sg]

  tags = {
    Name = join("-", ["runner_primary_network_interface", count.index])
    Owner = var.owner
  }
}

resource "aws_eip" "runner_eip" {
  vpc = true
  count = var.instance_count
  network_interface = aws_network_interface.runner_eni[count.index].id
#  associate_with_private_ip = "10.0.1.50"
  depends_on        = [aws_instance.worker_node]
  tags = {
    Name = join("-", ["runner_eip", count.index])
    Owner = var.owner
  }
}