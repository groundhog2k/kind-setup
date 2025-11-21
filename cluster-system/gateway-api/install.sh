#!/bin/bash
echo ">>>>> Installing Gateway API"
echo "Installing Gateway API CRDs"
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.4.0/standard-install.yaml
helm repo add istio https://istio-release.storage.googleapis.com/charts --force-update
helm upgrade istio-base istio/base -n cluster-system -f istio-values.yaml --wait --wait-for-jobs -i
helm upgrade istiod istio/istiod -n cluster-system -f istio-values.yaml --wait --wait-for-jobs -i
echo "<<<<< Gateway API ready."
