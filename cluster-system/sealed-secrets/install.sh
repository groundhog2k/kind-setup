#!/bin/bash
helm repo add sealed-secrets https://bitnami-labs.github.io/sealed-secrets
helm repo update
helm upgrade -i sealed-secrets -n cluster-system sealed-secrets/sealed-secrets -f sealed-secrets-values.yaml
kseal_version="0.30.0"
wget https://github.com/bitnami-labs/sealed-secrets/releases/download/v${kseal_version}/kubeseal-${kseal_version}-linux-amd64.tar.gz
sudo tar Cxvzf /usr/local/bin kubeseal-${kseal_version}-linux-amd64.tar.gz kubeseal
sudo chmod 755 /usr/local/bin/kubeseal
rm kubeseal-${kseal_version}-linux-amd64.tar.gz
