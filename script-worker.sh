#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update -y
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo apt-get install -y containerd
sudo modprobe br_netfilter
sudo echo -e "br_netfilter" >> /etc/modules-load.d/modules.conf
sudo echo -e "net.bridge.bridge-nf-call-iptables = 1\nnet.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sudo sysctl -p /etc/sysctl.conf
echo walla yeghav