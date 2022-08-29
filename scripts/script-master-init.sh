#!/bin/bash
cd ~
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 >> testing.txt
cat testing.txt | tail -n 2 >> total.txt
scp -o "StrictHostKeyChecking no" ./total.txt ubuntu@jumphost-01:~/ansible/