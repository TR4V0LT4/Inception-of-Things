#!/bin/bash

# Installing dependencies
sudo apt update && sudo apt install -y curl

# Installing K3s in server mode
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--write-kubeconfig-mode=644 --node-ip=192.168.56.110" sh -


# Applying configs
kubectl apply -f /configs/app1/app.yaml
kubectl apply -f /configs/app1/ConfigMap.yaml
kubectl apply -f /configs/app2/app.yaml
kubectl apply -f /configs/app2/ConfigMap.yaml
kubectl apply -f /configs/app3/app.yaml
kubectl apply -f /configs/app3/ConfigMap.yaml
kubectl apply -f /configs/ingress.yaml