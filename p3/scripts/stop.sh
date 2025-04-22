#!/bin/bash

CYAN='\033[1;36m'
GREEN='\033[1;32m'
NC='\033[0m'
clear
echo -e "${CYAN}🧹 Deleting 'argocd' namespace...${NC}"
kubectl delete namespace argocd > /dev/null
echo -e "${GREEN}✅ 'argocd' namespace deleted.${NC}"
echo -e "${CYAN}🧹 Deleting 'dev' namespace...${NC}"
kubectl delete namespace dev > /dev/null
echo -e "${GREEN}✅ 'dev' namespace deleted.${NC}"
echo -e "${CYAN}🧹 Deleting k3d cluster 'p3'...${NC}"
k3d cluster delete p3 > /dev/null
echo -e "${GREEN}✅ k3d cluster 'p3' deleted.${NC}"
