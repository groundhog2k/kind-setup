#!/bin/bash
master_nodes=$(kubectl get nodes -o custom-columns=":metadata.name" -l "node-role.kubernetes.io/control-plane=true")
kubectl taint node $master_nodes node-role.kubernetes.io/control-plane:NoSchedule
## 1. Create internal namespace
kubectl apply -f namespace.yaml

## 2. Install Kubernetes Gateway API CRDs
kubectl apply --server-side -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.5.1/standard-install.yaml

## 3. Install metrics-server
cd metrics-server
./install.sh

## 4. Install jetstack cert-manager, local rootca and cert issuer
cd ../cert-manager
./install.sh

## 5. Install envoy-gateway
cd ../envoy-gateway
./install.sh

## 6. Install headlamp as K8s dashboard
cd ../headlamp
./install.sh

## 7. Install sealed-secrets
cd ../sealed-secrets
./install.sh
