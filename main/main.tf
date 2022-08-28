module "network-stack" {
  source = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/network-stack"
  vpc_cidr_block      = var.vpc_cidr_block
  pub_sub_cidr_block  = var.pub_sub_cidr_block
  priv_sub_cidr_block = var.priv_sub_cidr_block
  env_prefix          = var.env_prefix   
}

module "compute-stack" {
  source = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/compute-stack"
  kgk-VPC_id = module.network-stack.kgk-VPC_id
  kgk_pub_id = module.network-stack.kgk_pub_id
  kgk_priv_id = module.network-stack.kgk_priv_id
  env_prefix    = var.env_prefix  
}

output "vpc_id" {
  value = module.network-stack.kgk-VPC_id
}

output "pub_id" {
  value = module.network-stack.kgk_pub_id
}

output "jumphost-pub-ip"{
  value = module.compute-stack.ec2_pub_ip
}

output "jumphost-private-ip"{
  value = module.compute-stack.ec2_private_ip
}

output "ec2_private_ip-m01" {
  value = module.compute-stack.ec2_private_ip-m01
}

output "ec2_private_ip-w01" {
  value = module.compute-stack.ec2_private_ip-w01
}

output "ec2_private_ip-w02" {
  value = module.compute-stack.ec2_private_ip-w02
}