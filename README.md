# tf-k8s-cluster
1. terraform apply 
# after all EC2 are up 
2. enter to jump host 
# cd ansible
# edit the ips of /etc/ansible/hosts
# edit the ips of hostname.yaml
# run ansible-playbook hostname.yaml
# run ansible-playbook script-transfer-run.yaml
# run ansible-playbook init.yaml
# run ansible-playbook join.yaml
# run ansible-playbook script-jumper.sh