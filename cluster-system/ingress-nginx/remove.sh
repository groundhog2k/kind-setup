#!/bin/bash
echo ">>>>> Removing Ingress-nginx"
helm uninstall ingress-nginx -n cluster-system
echo "<<<<< Ingress-nginx removed."
