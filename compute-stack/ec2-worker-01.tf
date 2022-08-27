resource "aws_instance" "data-ec2-w01" {
  ami                    = "ami-0c9354388bb36c088"
  instance_type          = "t3.small"
  subnet_id              = var.kgk_priv_id
  key_name               = aws_key_pair.public_key.key_name
  vpc_security_group_ids = [aws_security_group.kgk-SG-private.id]

#   connection {
#     type        = "ssh"
#     user        = "ubuntu"
#     private_key = file("/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/main/exam_rsa")
#     host        = self.public_ip
#   }

#   provisioner "file" {
#     source      = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/main/exam_rsa.pub"
#     destination = "/home/ubuntu/exam_rsa.pub"
#   }

#   provisioner "file" {
#     source      = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/script-worker.sh"
#     destination = "/home/ubuntu/script-worker.sh"
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "sudo chown -R ubuntu:ubuntu /home/ubuntu/exam_rsa.pub",
#       "chmod 400 /home/ubuntu/exam_rsa.pub",
#       "sudo hostnamectl set-hostname worker-01",
#       "chmod 760 /home/ubuntu/script-worker.sh",
#       "sudo /home/ubuntu/script-worker.sh",
#     ]
#   }

  tags = {
    Name ="${var.env_prefix}-EC2-worker-01"
  }
}