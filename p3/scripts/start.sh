#!/bin/bash

CYAN='\033[1;36m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m'
clear
echo -e "${CYAN}🚀 Creating k3d cluster named 'p3' and exposing port 8888...${NC}"
k3d cluster create p3 --port 8888:8888@loadbalancer > /dev/null
echo -e "${CYAN}🔁 Switching kubectl context to 'k3d-p3'...${NC}"
kubectl config use-context k3d-p3 > /dev/null
echo -e "${CYAN}📁 Creating 'argocd' namespace...${NC}"
kubectl create namespace argocd > /dev/null
echo -e "${CYAN}⬇️  Installing Argo CD...${NC}"
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml > /dev/null
echo -e "${YELLOW}⏳ Waiting for Argo CD pods to be ready...${NC}"
while true; do
	kubectl get pods -n argocd | grep -v NAME | awk '{print $2}' | grep -v -E '1/1' > /dev/null || break
	sleep 1
done
echo -e "${CYAN}📁 Creating 'dev' namespace...${NC}"
kubectl create namespace dev > /dev/null
echo -e "${CYAN}📄 Creating 'development' Argo CD project...${NC}"
kubectl apply -f confs/development.yaml > /dev/null
echo -e "${CYAN}⬇️  Applying application manifest to 'dev' namespace...${NC}"
kubectl apply -f confs/application.yaml > /dev/null
until kubectl get deploy -n dev 2>&1 | grep -qv "No resources found"; do
  sleep 1
done
echo -e "${YELLOW}⏳ Waiting for dev pods to be ready...${NC}"
while true; do
	kubectl get pods -n dev | grep -v NAME | awk '{print $2}' | grep -v -E '1/1' > /dev/null || break
	sleep 1
done
cd confs/app
git init
git remote add origin https://github.com/EBensalt/hfanzaou.git
git branch -m master main
echo -e "${GREEN}✅ All done! Argo CD and dev app are up and running.${NC}"
