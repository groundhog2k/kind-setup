#!/bin/bash
echo ">>>>> Bootstrapping Kind"
kind create cluster --name $1 --config kind-default.yaml --image kindest/node:v1.29.0@sha256:54a50c9354f11ce0aa56a85d2cacb1b950f85eab3fe1caf988826d1f89bf37eb
echo  "<<<<< Kind ready."
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.0/manifests/tigera-operator.yaml
kubectl create -f custom-resources.yaml
