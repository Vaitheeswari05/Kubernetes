#!/bin/bash

set -e

# Update and upgrade system packages
sudo apt-get update && sudo apt-get upgrade -y

# Install dependencies
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Create keyrings directory
sudo mkdir -p /etc/apt/keyrings

# Add Kubernetes signing key
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Set correct permissions for the keyring
sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Add Kubernetes repository
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Update package list
sudo apt-get update

# Install Kubernetes components
sudo apt-get install -y kubelet kubeadm kubectl

# Prevent automatic updates for Kubernetes components
sudo apt-mark hold kubelet kubeadm kubectl

# Enable and start kubelet service
sudo systemctl enable --now kubelet

#Completion message
echo "Kubectl,Kubelet - Downloaded Sucessfully"

# Verify installation
echo "Kubectl Version: $(kubectl version --client)"
echo "Kubeadm: $(kubeadm version)"
echo "Kubelet Version: $(kubelet --version)"
