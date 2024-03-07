#!/bin/bash
echo ">>>>> Installing Kubernetes dashboard"
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/ --force-update
helm upgrade k8s-dashboard kubernetes-dashboard/kubernetes-dashboard -n cluster-system -f k8s-dashboard-values.yaml --wait --wait-for-jobs -i
### Fix permissions for kubernetes-dashboard user to have full access
sleep 5
kubectl create serviceaccount -n cluster-system kubernetes-dashboard
kubectl apply -n cluster-system -f serviceaccount.yaml
kubectl delete clusterrolebinding kubernetes-dashboard -n cluster-system --ignore-not-found=true
kubectl create clusterrolebinding kubernetes-dashboard -n cluster-system --clusterrole=cluster-admin --serviceaccount=cluster-system:kubernetes-dashboard

if grep -q dash.k8s.local /etc/hosts; then
  echo "dash.k8s.local already in hosts file"
else
  echo "Adding dash.k8s.local to hosts file"
  echo "127.0.0.1 dash.k8s.local" | sudo tee -a /etc/hosts
fi
echo "<<<<< Kubernetes dashboard ready."

echo -e "\nUse the following token for Kubernetes dashboard login:\n"
kubectl get secret -n cluster-system kubernetes-dashboard -o jsonpath={".data.token"} | base64 -d
echo -e "\n"
