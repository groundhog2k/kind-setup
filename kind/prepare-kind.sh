#!/bin/bash
echo ">>>>> Bootstrapping Kind"
kind create cluster --name $1 --config kind-default.yaml --image kindest/node:v1.29.4@sha256:3abb816a5b1061fb15c6e9e60856ec40d56b7b52bcea5f5f1350bc6e2320b6f8
echo  "<<<<< Kind ready."
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.4/manifests/calico.yaml
