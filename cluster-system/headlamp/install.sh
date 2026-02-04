#!/bin/bash
echo ">>>>> Installing Headlamp"
helm repo add headlamp https://kubernetes-sigs.github.io/headlamp/ --force-update
helm upgrade headlamp headlamp/headlamp -n cluster-system -f headlamp-values.yaml --wait --wait-for-jobs -i
### (Re-)Create headlamp-admin user to have full access
sleep 5
kubectl create serviceaccount -n cluster-system headlamp-admin
kubectl apply -n cluster-system -f serviceaccount.yaml
kubectl delete clusterrolebinding headlamp-admin -n cluster-system --ignore-not-found=true
kubectl create clusterrolebinding headlamp-admin -n cluster-system --clusterrole=cluster-admin --serviceaccount=cluster-system:headlamp-admin

if grep -q headlamp /etc/hosts; then
  echo "headlamp already in hosts file"
else
  echo "Adding headlamp to hosts file"
  echo "127.0.0.1 headlamp" | sudo tee -a /etc/hosts
fi
echo "<<<<< Headlamp ready."

echo -e "\nUse the following token for Headlamp login:\n"
kubectl get secret -n cluster-system headlamp-admin -o jsonpath={".data.token"} | base64 -d
echo -e "\n"

