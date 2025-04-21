#!/bin/bash

# Installing dependencies
sudo apt-get update && sudo apt-get install -y curl

# Installing K3s in server mode
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--write-kubeconfig-mode=644 --node-ip=192.168.56.110" sh -

# deploying apps
kubectl apply -f /configs/app1.yaml
kubectl apply -f /configs/app2.yaml
kubectl apply -f /configs/app3.yaml
kubectl apply -f /configs/ingress.yaml