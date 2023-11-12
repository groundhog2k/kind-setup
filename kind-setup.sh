#!/bin/bash
# Bootstrap a Kind based Kubernetes setup with metrics, ingress, cert-manager and K8s dashboard

## 0. Install latest kind first
wget https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind-linux-amd64
chmod +x scripts/kind*
sudo mv ./kind-linux-amd64 /usr/local/bin/kind
sudo cp ./scripts/kind* /usr/local/bin

## 1. Bootstrap Kind
clustername=${1:kind}
cd kind
./prepare-kind.sh $clustername

## 2. Prepare cluster services
cd ../cluster-system
./cluster-setup.sh

echo "*** Finished! Enjoy your local K8d environment. ***"
