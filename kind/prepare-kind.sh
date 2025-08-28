#!/bin/bash
echo ">>>>> Bootstrapping Kind"
kind create cluster --name $1 --config kind-default.yaml --image kindest/node:v1.33.4@sha256:25a6018e48dfcaee478f4a59af81157a437f15e6e140bf103f85a2e7cd0cbbf2
kind export kubeconfig --name $1
echo  "<<<<< Kind ready."
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.30.3/manifests/calico.yaml
