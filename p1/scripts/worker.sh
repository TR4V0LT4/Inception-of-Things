#!/bin/bash

# Install dependencies
sudo apt update && sudo apt install -y curl

# Install K3s in agent mode, join the server
SERVER_IP="192.168.56.110"
K3S_TOKEN=$(cat /vagrant/node-token)
curl -sfL https://get.k3s.io | K3S_URL="https://$SERVER_IP:6443" K3S_TOKEN="$K3S_TOKEN" INSTALL_K3S_EXEC="--node-ip=192.168.56.111" sh -
