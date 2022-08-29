#!/bin/bash
sudo cp /etc/kubernetes/admin.conf ~/
sudo chown ubuntu:ubuntu ~/admin.conf
export KUBECONFIG=$HOME/admin.conf