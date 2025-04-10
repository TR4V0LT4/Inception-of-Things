#!/bin/bash

# Install dependencies
sudo apt update && sudo apt install -y curl

# Install K3s in server mode
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--write-kubeconfig-mode=644 --node-ip=192.168.56.110" sh -

# # copy the node-token to shared folder
# sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/node-token

# # Alias to k3s
# [ -f /usr/local/bin/kubectl ] || sudo ln -s /usr/local/bin/k3s /usr/local/bin/kubectl

# sleep 5

# # Export KUBECONFIG
# export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

# # Apply your configs
kubectl apply -f /apps/app1.yaml
kubectl apply -f /apps/app2.yaml
kubectl apply -f /apps/app3.yaml
kubectl apply -f /apps/ingress.yaml 