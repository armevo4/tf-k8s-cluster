resource "aws_instance" "data-ec2-jumphost" {
  ami                    = "ami-0c9354388bb36c088"
  instance_type          = "t3.small"
  subnet_id              = var.kgk_pub_id
  key_name               = aws_key_pair.public_key.key_name
  vpc_security_group_ids = [aws_security_group.kgk-SG.id]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/main/exam_rsa")
    host        = self.public_ip
  }

 
 provisioner "file" {
    source      = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/main/exam_rsa.pub"
    destination = "/home/ubuntu/exam_rsa.pub"
  }


  provisioner "remote-exec" {
    inline = [
      "sudo apt-get install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
      "sudo chown -R ubuntu:ubuntu /var/www/html",
      "sudo chown -R ubuntu:ubuntu /home/ubuntu/exam_rsa.pub",
      "chmod 400 /home/ubuntu/exam_rsa.pub",
      "sudo hostnamectl set-hostname jumphost-01",
    ]
  }
  provisioner "file" {
    source      = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/compute-stack/index.html"
    destination = "/var/www/html/index.html"
  }

  tags = {
    Name ="${var.env_prefix}-EC2-jumphost"
  }
}