output "kgk-VPC_id" {
  value = aws_vpc.kgk-VPC.id
}

output "kgk-VPC_name" {
  value = aws_vpc.kgk-VPC.arn
}

output "kgk_vpc_cidr_block" {
  value = var.vpc_cidr_block
}

#=====================================

output "kgk_pub_id" {
  value = aws_subnet.kgk-PUBLIC.id
}

output "kgk_pub_name" {
  value = aws_subnet.kgk-PUBLIC.arn
}


output "kgk_pub_cidr_block" {
  value = var.pub_sub_cidr_block
}

#======================================

output "kgk_priv_id" {
  value = aws_subnet.kgk-PRIVATE.id
}

output "kgk_priv_name" {
  value = aws_subnet.kgk-PRIVATE.arn
}

output "kgk_priv_cidr_block" {
  value = var.priv_sub_cidr_block
}

#=======================================

output "kgk-IGW_id" {
  value = aws_internet_gateway.kgk-IGW.id
}

output "kgk-IGW_name" {
  value = aws_internet_gateway.kgk-IGW.arn
}

#======================================

output "kgk-NGW_id" {
  value = aws_nat_gateway.kgk-NGW.id
}

output "kgk-NGW_name" {
  value = aws_nat_gateway.kgk-NGW.id
}

#======================================

output "kgk-PUBLIC-RT-id" {
  value = aws_route_table.kgk-PUBLIC-RT.id
}

output "kgk-PUBLIC-RT_name" {
  value = aws_route_table.kgk-PUBLIC-RT.arn
}

#======================================

output "kgk-PRIVATE-RT_id" {
  value = aws_route_table.kgk-PRIVATE-RT.id
}
output "kgk-PRIVATE-RT_name" {
  value = aws_route_table.kgk-PRIVATE-RT.arn
}
