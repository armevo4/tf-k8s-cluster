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
      "mkdir ansible",
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
      "sleep 2",
      "sudo apt-get update -y",
      "sudo apt-get install -y apt-transport-https ca-certificates curl",
      "sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg",
      "echo 'deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main' | sudo tee /etc/apt/sources.list.d/kubernetes.list",
      "sudo apt-get update -y",
      "sudo apt-get install -y kubectl",
      "sudo apt-mark hold kubectl",
    ]
  }
  provisioner "file" {
    source      = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/compute-stack/index.html"
    destination = "/var/www/html/index.html"
  }

  provisioner "file" {
    source      = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/ansible/hostname.yaml"
    destination = "/home/ubuntu/ansible/hostname.yaml"
  }

  provisioner "file" {
    source      = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/ansible/script-transfer-run.yaml"
    destination = "/home/ubuntu/ansible/script-transfer-run.yaml"
  }

  provisioner "file" {
    source      = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/scripts/script-master.sh"
    destination = "/home/ubuntu/ansible/script-master.sh"
  }
  provisioner "file" {
    source      = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/scripts/script-k8s-all.sh"
    destination = "/home/ubuntu/ansible/script-k8s-all.sh"
  } 

  provisioner "file" {
    source      = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/scripts/add-ansible-hosts.sh"
    destination = "/home/ubuntu/ansible/add-ansible-hosts.sh"
  }

  provisioner "file" {
    source      = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/scripts/script-master-init.sh"
    destination = "/home/ubuntu/ansible/script-master-init.sh"
  }    

  provisioner "file" {
    source      = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/scripts/script-jumper.sh"
    destination = "/home/ubuntu/ansible/script-jumper.sh"
  } 

  provisioner "file" {
    source      = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/ansible/init.yaml"
    destination = "/home/ubuntu/ansible/init.yaml"
  } 


provisioner "file" {
    source      = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/ansible/join.yaml"
    destination = "/home/ubuntu/ansible/join.yaml"
  } 

  provisioner "remote-exec" {
    inline = [
        "cd /home/ubuntu/ansible/",
        "chmod 760 add-ansible-hosts.sh",
        "sudo ./add-ansible-hosts.sh", 
        "chmod 760 script-jumper.sh"
    ]
  }

  tags = {
    Name ="${var.env_prefix}-EC2-jumphost"
  }
}