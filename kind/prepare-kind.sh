#!/bin/bash
echo ">>>>> Bootstrapping Kind"
kind create cluster --name $1 --config kind-default.yaml --image kindest/node:v1.29.0@sha256:54a50c9354f11ce0aa56a85d2cacb1b950f85eab3fe1caf988826d1f89bf37eb
echo  "<<<<< Kind ready."
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
