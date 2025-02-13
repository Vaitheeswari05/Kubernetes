#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Install Minikube
echo "Installing Minikube..."
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
sudo mv minikube /usr/local/bin/

# Verify installation
echo "Verifying installation..."
minikube version

echo "Minikube installation completed successfully!"

