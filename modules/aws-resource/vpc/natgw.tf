#resource "aws_nat_gateway" "this" {
#  allocation_id = aws_eip.this.id
#  subnet_id = aws_subnet.this[0].id
#  tags = {
#    "Name" = "devops-nat-gateway"
#  }
#  depends_on = [aws_internet_gateway.this]
#}
#
#resource "aws_eip" "this" {
#  vpc = true
#}