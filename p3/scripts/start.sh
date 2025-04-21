#!/bin/bash

k3d cluster create p3
kubectl config use-context k3d-p3
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
while true; do
	kubectl get pods -n argocd | grep -v NAME | awk '{print $2}' | grep -v -E '1/1' > /dev/null || break
	sleep 1
done
kubectl create namespace dev
echo "login: admin"
echo -n "password: "
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode
echo ""
echo ""
kubectl port-forward svc/argocd-server -n argocd 8443:443

# k3d cluster create P3 \
# 	--agents 1 \
# 	--port 8888:8888@loadbalancer \
# 	--port 8443:443@loadbalancer
# kubectl apply -f confs/namespaces.yaml
# kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
# kubectl apply -f confs/argocd-application.yaml
