#!/bin/bash
echo ">>>>> Bootstrapping Kind cluster '$1' with image '$2'"
kind create cluster --name $1 --config kind-default.yaml --image $2
kind export kubeconfig --name $1
echo  "<<<<< Kind ready."
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.30.3/manifests/calico.yaml
