output "kgk-SG_id" {
  value = aws_security_group.kgk-SG.id
}

output "kgk-SG_name" {
  value = aws_security_group.kgk-SG.arn
}

output "ec2_pub_ip" {
  value = aws_instance.data-ec2-jumphost.public_ip
}

output "ec2_private_ip" {
  value = aws_instance.data-ec2-jumphost.private_ip
}

output "ec2_private_ip-m01" {
  value = aws_instance.data-ec2-m01.private_ip
}

output "ec2_private_ip-w01" {
  value = aws_instance.data-ec2-w01.private_ip
}

output "ec2_private_ip-w02" {
  value = aws_instance.data-ec2-w02.private_ip
}