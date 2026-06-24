#!/bin/bash
echo ">>>>> Installing Envoy Gateway"
helm template eg oci://docker.io/envoyproxy/gateway-crds-helm --version v1.8.0 --set crds.gatewayAPI.enabled=false --set crds.envoyGateway.enabled=true | kubectl apply --server-side -f -
helm install envoy-gateway oci://docker.io/envoyproxy/gateway-helm --version v1.8.0 -n cluster-system --skip-crds --wait --wait-for-jobs
kubectl apply -f gateway-class.yaml -n cluster-system
kubectl apply -f envoyproxy.yaml -n cluster-system
kubectl apply -f gateway.yaml -n cluster-system
echo "<<<<< Envoy Gateway ready."
