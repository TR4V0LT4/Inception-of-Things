#!/bin/bash

echo "login: admin"
echo -n "password: "
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode
echo ""
echo ""
kubectl port-forward svc/argocd-server -n argocd 8080:443
