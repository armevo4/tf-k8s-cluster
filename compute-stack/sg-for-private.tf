resource "aws_security_group" "kgk-SG-private" {
  name        = "allow_myservices-private"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.kgk-VPC_id

  ingress {
    description = "allow all"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

 tags = {
    Name ="${var.env_prefix}-SG-private"
  }

}

