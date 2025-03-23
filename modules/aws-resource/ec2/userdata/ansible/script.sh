#!/bin/bash
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible curl unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo rm -rf awscliv2.zip
sudo ./aws/install
sudo aws s3 cp s3://arthur-mantel-ap-southeast-2-bucket/zip/ansible_k8s-master.zip $HOME
sudo unzip ansible_k8s-master.zip
sudo rm -rf ansible_k8s-master.zip
ssh-keygen -f $HOME/.ssh/id_ed25519 -t ed25519 -N ''