#!/bin/bash
echo ">>>>> Installing Envoy Gateway"
kubectl delete -f gateway.yaml -n cluster-system
kubectl delete -f gateway-class.yaml -n cluster-system
helm uninstall envoy-gateway -n cluster-system --wait
helm template eg oci://docker.io/envoyproxy/gateway-crds-helm --version v1.8.1 --set crds.gatewayAPI.enabled=false --set crds.envoyGateway.enabled=true | kubectl delete -f -
echo "<<<<< Envoy Gateway ready."
