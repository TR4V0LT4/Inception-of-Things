#!/bin/bash

kubectl delete -f confs/argocd-application.yaml
k3d cluster delete P3
