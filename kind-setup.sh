#!/bin/bash
# Bootstrap a Kind based Kubernetes setup with metrics, ingress, cert-manager and K8s dashboard

kindversion="v0.31.0"
clustername=${1:-"kind"}
imageversion=${2:-"kindest/node:v1.35.0@sha256:452d707d4862f52530247495d180205e029056831160e22870e37e3f6c1ac31f"}

echo "*** Starting Kind based Kubernetes setup ***"
## 0. Install latest kind first
curl -Lo kind-linux-amd64 https://kind.sigs.k8s.io/dl/${kindversion}/kind-linux-amd64
chmod +x ./kind-linux-amd64
chmod +x scripts/kind*
sudo mv ./kind-linux-amd64 /usr/local/bin/kind
sudo cp ./scripts/kind* /usr/local/bin

## 1. Bootstrap Kind
cd kind
./prepare-kind.sh $clustername $imageversion

../scripts/stickcp $clustername
../scripts/kindreset $clustername

## 2. Prepare cluster services
cd ../cluster-system
./cluster-setup.sh

echo "*** Finished! Enjoy your local Kubernetes environment. ***"
