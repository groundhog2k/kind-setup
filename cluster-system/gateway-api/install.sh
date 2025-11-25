#!/bin/bash
echo ">>>>> Installing Gateway API"
echo "Installing Gateway API CRDs"
helm install envoy-gateway oci://docker.io/envoyproxy/gateway-helm --version 1.6.0 -n cluster-system
kubectl apply -f gatewayclass.yaml
kubectl apply -n cluster-system -f gateway.yaml
kubectl apply -n cluster-system -f route.yaml
echo "<<<<< Gateway API ready."
