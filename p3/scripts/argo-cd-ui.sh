#!/bin/bash

CYAN='\033[1;36m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m'
echo -e "${CYAN}🔐 Retrieving Argo CD initial admin credentials...${NC}"
echo -e "${YELLOW}👤 login: ${NC}admin"
echo -ne "${YELLOW}🔑 password: ${NC}"
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode
echo -e "\n"
echo -e "${CYAN}🔁 Forwarding Argo CD server to localhost:8889...${NC}"
kubectl port-forward svc/argocd-server -n argocd 8889:443
