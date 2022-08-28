#!/bin/bash
mkdir ~/.kube
scp -o "StrictHostKeyChecking no" ubuntu@master01:admin.conf /home/ubuntu/.kube/config
chmod 600 ~/.kube/config
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml