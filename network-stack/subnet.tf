resource "aws_subnet" "kgk-PUBLIC" {
  vpc_id                  = aws_vpc.kgk-VPC.id
  cidr_block              = var.pub_sub_cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name ="${var.env_prefix}-PUBLIC"
  }
}

resource "aws_subnet" "kgk-PRIVATE" {
  vpc_id     = aws_vpc.kgk-VPC.id
  cidr_block = var.priv_sub_cidr_block

  tags = {
    Name ="${var.env_prefix}-PRIVATE"
  }
}
