#!/bin/bash
echo ">>>>> Installing Sealed secrets"
kseal_version="0.24.3"
helm repo add sealed-secrets https://bitnami-labs.github.io/sealed-secrets
helm install sealed-secrets -n cluster-system sealed-secrets/sealed-secrets -f sealed-secrets-values.yaml
curl -Lo kubeseal.tar.gz https://github.com/bitnami-labs/sealed-secrets/releases/download/v${kseal_version}/kubeseal-${kseal_version}-linux-amd64.tar.gz
sudo tar Cxvzf /usr/local/bin kubeseal.tar.gz kubeseal
sudo chmod 755 /usr/local/bin/kubeseal
rm kubeseal.tar.gz
echo "<<<<< Sealed secrets ready."
