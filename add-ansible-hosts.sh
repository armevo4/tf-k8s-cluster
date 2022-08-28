#!/bin/bash
sudo echo -e "[all-hosts]" >> /etc/ansible/hosts
sudo echo -e "worker01 ansible_host=192.168.2.106" >> /etc/ansible/hosts
sudo echo -e "worker02 ansible_host=192.168.2.197" >> /etc/ansible/hosts
sudo echo -e "master01 ansible_host=192.168.2.130" >> /etc/ansible/hosts
sudo echo -e "[localhost]" >> /etc/ansible/hosts
sudo echo -e "127.0.0.1" >> /etc/ansible/hosts
sudo echo -e "[worker]" >> /etc/ansible/hosts
sudo echo -e "worker01 ansible_host=192.168.2.106" >> /etc/ansible/hosts
sudo echo -e "worker02 ansible_host=192.168.2.197" >> /etc/ansible/hosts
sudo echo -e "[master]" >> /etc/ansible/hosts
sudo echo -e "master01 ansible_host=192.168.2.130" >> /etc/ansible/hosts
