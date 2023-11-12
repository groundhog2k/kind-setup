#!/bin/bash
echo ">>>>> Bootstrapping Kind"
kind create cluster --name $1 --config kind-default.yaml
echo  "<<<<< Kind ready."
