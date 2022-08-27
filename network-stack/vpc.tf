resource "aws_vpc" "kgk-VPC" {
  cidr_block = var.vpc_cidr_block


  tags = {
    Name ="${var.env_prefix}-VPC"
  }
}
