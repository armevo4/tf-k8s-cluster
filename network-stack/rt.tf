resource "aws_route_table" "kgk-PUBLIC-RT" {
  vpc_id = aws_vpc.kgk-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kgk-IGW.id
  }

  tags = {
    Name ="${var.env_prefix}-PUB-RT"
  }
}

resource "aws_route_table_association" "PUB" {
  subnet_id      = aws_subnet.kgk-PUBLIC.id
  route_table_id = aws_route_table.kgk-PUBLIC-RT.id
}



resource "aws_route_table" "kgk-PRIVATE-RT" {
  vpc_id = aws_vpc.kgk-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.kgk-NGW.id
  }

  tags = {
    Name ="${var.env_prefix}-PRIVE-RT"
  }
}

resource "aws_route_table_association" "PRIVE" {
  subnet_id      = aws_subnet.kgk-PRIVATE.id
  route_table_id = aws_route_table.kgk-PRIVATE-RT.id
}




