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
    source      = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/ansible/script-transfer-run.yaml"
    destination = "/home/ubuntu/script-transfer-run.yaml"
  }

  provisioner "file" {
    source      = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/script-master.sh"
    destination = "/home/ubuntu/script-master.sh"
  }
  provisioner "file" {
    source      = "/Users/krikorgarabedkafalian/Desktop/tf-k8s-cluster/script-worker.sh"
    destination = "/home/ubuntu/script-worker.sh"
  }  

  provisioner "remote-exec" {
    inline = [
        "sudo echo -e "[all-hosts]" >> /etc/ansible/hosts"
        "sudo echo -e "worker01 ansible_host=192.168.2.106" >> /etc/ansible/hosts"
        "sudo echo -e "worker02 ansible_host=192.168.2.197" >> /etc/ansible/hosts"
        "sudo echo -e "master01 ansible_host=192.168.2.130" >> /etc/ansible/hosts"
        "sudo echo -e "[localhost]" >> /etc/ansible/hosts"
        "sudo echo -e "127.0.0.1" >> /etc/ansible/hosts"
        "sudo echo -e "[worker]" >> /etc/ansible/hosts"
        "sudo echo -e "worker01 ansible_host=192.168.2.106" >> /etc/ansible/hosts"
        "sudo echo -e "worker02 ansible_host=192.168.2.197" >> /etc/ansible/hosts"
        "sudo echo -e "[master]" >> /etc/ansible/hosts"
        "sudo echo -e "master01 ansible_host=192.168.2.130" >> /etc/ansible/hosts"
    ]
  }

  tags = {
    Name ="${var.env_prefix}-EC2-jumphost"
  }
}