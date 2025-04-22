#!/bin/bash

GREEN='\033[1;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
NC='\033[0m'
clear
echo -e "${CYAN}✅ Restored .git directory in confs/app/${NC}"
mv confs/app/.git-backup/ confs/app/.git
echo -e "${CYAN}🔧 Updating APT and installing dependencies...${NC}"
sudo apt-get update > /dev/null
sudo apt-get install ca-certificates curl -y > /dev/null
echo -e "${CYAN}🐳 Setting up Docker repository and key...${NC}"
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo -e "${CYAN}📦 Adding Docker APT source...${NC}"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo -e "${CYAN}📥 Installing Docker components...${NC}"
sudo apt-get update > /dev/null
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y > /dev/null
echo -e "${CYAN}🧊 Installing k3d...${NC}"
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash  > /dev/null
echo -e "${CYAN}☸️  Setting up Kubernetes repo for kubectl...${NC}"
sudo apt-get update > /dev/null
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg > /dev/null
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo -e "${CYAN}📦 Adding kubectl APT source...${NC}"
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list > /dev/null
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list
echo -e "${CYAN}📥 Installing kubectl...${NC}"
sudo apt-get update > /dev/null
sudo apt-get install -y kubectl > /dev/null
echo -e "${CYAN}👤 Adding current user to docker group...${NC}"
sudo usermod -aG docker $USER
echo -e "${GREEN}✅ Setup complete.${NC}"
echo -e "${YELLOW}👉 You might need to logout and log back in or run 'newgrp docker' to use Docker without sudo.${NC}"
