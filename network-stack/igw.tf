resource "aws_internet_gateway" "kgk-IGW" {
  vpc_id = aws_vpc.kgk-VPC.id

  tags = {
    Name ="${var.env_prefix}-IGW"
  }
}