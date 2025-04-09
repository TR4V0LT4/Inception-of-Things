#!/bin/bash

k3d cluster create P3 \
	--agents 1 \
	--port 8888:8888@loadbalancer \
	--port 8443:443@loadbalancer
kubectl apply -f confs/namespaces.yaml
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -f confs/argocd-application.yaml
