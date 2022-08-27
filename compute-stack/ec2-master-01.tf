resource "aws_instance" "data-ec2-m01" {
  ami                    = "ami-0c9354388bb36c088"
  instance_type          = "t3.small"
  subnet_id              = var.kgk_priv_id
  key_name               = aws_key_pair.public_key.key_name
  vpc_security_group_ids = [aws_security_group.kgk-SG-private.id]

  tags = {
    Name ="${var.env_prefix}-EC2-master-01"
  }
}