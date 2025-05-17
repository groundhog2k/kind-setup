#!/bin/bash
echo ">>>>> Bootstrapping Kind"
kind create cluster --name $1 --config kind-default.yaml --image kindest/node:v1.33.1@sha256:8d866994839cd096b3590681c55a6fa4a071fdaf33be7b9660e5697d2ed13002
kind export kubeconfig --name $1
echo  "<<<<< Kind ready."
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.2/manifests/calico.yaml
