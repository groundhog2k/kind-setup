#!/bin/bash
echo ">>>>> Installing Gateway API"
echo "Installing Gateway API CRDs"
helm repo add istio https://istio-release.storage.googleapis.com/charts --force-update
helm upgrade istio-base istio/base -n cluster-system -f istio-values.yaml --wait --wait-for-jobs -i
helm upgrade istiod istio/istiod -n cluster-system -f istio-values.yaml --wait --wait-for-jobs -i
kubectl apply -n cluster-system -f gateway.yaml
echo "<<<<< Gateway API ready."
