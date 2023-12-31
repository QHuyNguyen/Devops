resource "aws_network_interface" "this" {
  count     = var.public_instance_count
  subnet_id = var.public_subnet_id
  #  private_ips     = [var.private_ips[count.index]]
  security_groups = [var.k8s_sg]

  tags = {
    Name  = join("-", ["pod_primary_network_interface", count.index])
    Owner = var.owner
  }
}

resource "aws_eip" "this" {
  vpc               = true
  count             = var.public_instance_count
  network_interface = aws_network_interface.this[count.index].id
  #  associate_with_private_ip = "10.0.1.50"
  depends_on = [aws_instance.public_instance]
  tags = {
    Name  = join("-", ["pod_eip", count.index])
    Owner = var.owner
  }
}