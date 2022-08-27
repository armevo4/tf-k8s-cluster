resource "aws_nat_gateway" "kgk-NGW" {
  allocation_id = aws_eip.kgk-EIP.id
  subnet_id     = aws_subnet.kgk-PUBLIC.id

  tags = {
    Name ="${var.env_prefix}-NGW"
  }
}

resource "aws_eip" "kgk-EIP" {
  tags = {
    Name ="${var.env_prefix}-EIP"
  }
}