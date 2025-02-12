#!/bin/bash

#Installing kubernetes with kubeadm

#1. Installing kubeadm, kubelet and kubectl

#Download the public signing key for the Kubernetes package repositories
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
#Note:
#* In releases older than Debian 12 and Ubuntu 22.04, directory /etc/apt/keyrings does not exist by default, and it should be created before the curl command. 

#Add the appropriate Kubernetes apt repository
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

#Update the apt package index, install kubelet, kubeadm and kubectl, and pin their version
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

#2. Install container runtime
sudo apt update
sudo apt install -y containerd
sudo mkdir -p /etc/containerd

#3. Configuring a Cgroup driver
#Generate containerd config using containerd config default and update SystemdCgroup to true, then add this to /etc/containerd/config.toml
containerd config default | sed 's/SystemdCgroup = false/SystemdCgroup = true/' | sudo tee /etc/containerd/config.toml

#Restart containerd
sudo systemctl restart containerd

#**THIS STEP IS REQUIRE WHEN SETTING UP CONTAINERD
#Forwarding IPv4
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

#Apply sysctl params without reboot
sudo sysctl --system

#cgroup driver: Allow you to set resource limit on your container
#* ps -p 1 to confirm what group driver your system is suing, could either be
#    * Cgroupfs
#    * Systemd

#4. Create cluster with Kubeadm
#Initialise control-plane node
#* --pod-network-cidr: Subnet for for your pod (pod network)
#* —apiserver-advertise-address: tell cluster what IP address is going to be for kube API Server (IP Add of master node)
#sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=10.0.0.53 --upload-certs

#To use your cluster:
#mkdir -p $HOME/.kube
#sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
#sudo chown $(id -u):$(id -g) $HOME/.kube/config

#Set up network plugin to allow master node status to be ready, by deploying a pod network to cluster
#* Use weave
#* https://github.com/rajch/weave?tab=readme-ov-file#using-weave-on-kubernetes
#* kubectl apply -f https://reweave.azurewebsites.net/k8s/v1.29/net.yaml

#Join other worker node using
#kubeadm join 10.0.0.68:6443 --token pkb5bs.br7sstdzj6bufz9y \
#        --discovery-token-ca-cert-hash sha256:ee11a4814a684094504fe1960896078bc8cdbcaa8292cdb9eef99bb8b40f6d00
