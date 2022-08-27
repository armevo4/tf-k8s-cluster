resource "aws_instance" "data-ec2-jumphost" {
  ami                    = "ami-0c9354388bb36c088"
  instance_type          = "t3.small"
  subnet_id              = var.kgk_pub_id
  key_name               = aws_key_pair.public_key.key_name
  vpc_security_group_ids = [aws_security_group.kgk-SG.id]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/main/id_rsa")
    host        = self.public_ip
  }

 
 provisioner "file" {
    source      = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/main/id_rsa.pub"
    destination = "/home/ubuntu/.ssh/id_rsa.pub"
  }

   provisioner "file" {
    source      = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/main/id_rsa"
    destination = "/home/ubuntu/.ssh/id_rsa"
  }


  provisioner "remote-exec" {
    inline = [
      "sudo apt-get install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
      "sudo chown -R ubuntu:ubuntu /var/www/html",
      "sudo chown -R ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa.pub",
      "chmod 400 /home/ubuntu/.ssh/id_rsa.pub",
      "sudo chown -R ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa",
      "chmod 400 /home/ubuntu/.ssh/id_rsa",
      "sudo hostnamectl set-hostname jumphost-01",
      "sudo apt update",
      "sudo apt install software-properties-common",
      "sudo add-apt-repository --yes --update ppa:ansible/ansible",
      "sudo apt install ansible -y",

    ]
  }
  provisioner "file" {
    source      = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/compute-stack/index.html"
    destination = "/var/www/html/index.html"
  }

  provisioner "file" {
    source      = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/ansible/hostname.yaml"
    destination = "/home/ubuntu/hostname.yaml"
  }

  provisioner "file" {
    source      = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/ansible/playbook.yaml"
    destination = "/home/ubuntu/playbook.yaml"
  }

  provisioner "file" {
    source      = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/script-master.sh"
    destination = "/home/ubuntu/script-master.sh"
  }
  provisioner "file" {
    source      = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/script-worker.sh"
    destination = "/home/ubuntu/script-worker.sh"
  }  

  tags = {
    Name ="${var.env_prefix}-EC2-jumphost"
  }
}