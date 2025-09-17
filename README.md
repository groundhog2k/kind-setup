# kind-setup

## What is it good for?

This project will make it very easy to automatically setup a Kind based Kubernetes cluster with one master and three agent nodes on your local development machine with metrics, certificate manager, ingress controller and Kubernetes dashboard.

It supports native Linux and also a WSL2 based setup.

The setup was tested for following environments:

- Ubuntu Linux 22.04
- Debian 11/12
- Ubuntu Linux 22.04 for WSL2 (MS Windows 10 / 11)
- Debian 11/12 for WSL2 (MS Windows 10 / 11)

## How to start? (TL;DR)

### Requirements

- Make sure your Linux or WSL2 environment has access to the Internet (directly or via properly configured HTTP/HTTPS proxy)
- You must have Docker installed and accessible from WSL2 by a) having docker services running in WSL2 or b) using Docker for Desktop
- Make sure you have `sudo` permissions
- You need to have `curl`, `tar` and [helm installed](https://helm.sh/docs/intro/install/) on your Linux environment

### Really.. I want to start it now and create a cluster named `mycluster`

```bash
git clone https://github.com/groundhog2k/kind-setup.git
cd kind-setup
./kind-setup.sh mycluster
```

Install the self-signed root certificate that was generated in `./cluster-system/cert-manager/certs/tls.crt` into your local browser or computer truststore for root certificates.

When setup is finished and all services are running open [https://k8sdash](https://k8sdash) in your browser and enjoy Kubernetes.

**Important - For Windows only:**

Edit the hosts file (typically in [`C:\Windows\system32\drivers\etc\hosts`](C:/Windows/system32/drivers/etc/hosts)) and add a mapping line for the hostname k8sdash:

```text
127.0.0.1 k8sdash
```

## How to stop or (re)-start?

You can stop the installed cluster with:

```bash
kindstop mycluster
```

...and start it again with:

```bash
kindstart start mycluster
```

## How to uninstall?

Uninstall everything related to the kind cluster with a simple:

```bash
kind delete clusters mycluster
```

## Troubleshooting

### What if cluster doesn't start after a machine or docker restart?

In some cases (restart of machine, WSL2 or docker) the cluster doesn't fully start and you will see that some of the worker node IP adresses overlap with control planes IP address. (`kubectl get nodes -o wide`)

If this happen you can reset the worker nodes and assign static IP addresses to the workers.
A simple script will do this automatically for you:

```bash
kindreset mycluster
```

---

## Give me the details

### For Linux and WSL2

For Linux and WSL2 it will simply install *kind* and prepare a few more services like, metrics server, Jetstack certificate manager, Ingress nginx and Kubernetes dashboard.

### All the scripts in detail

The script `kind-setup.sh [name] [version]` builds the bracket around a few other scripts.
It will call the following sub-scripts:

1. `kind/prepare-kind.sh [name]`

    The script will take the optional name (default: `kind`) and the template file kind-default.yaml to deploy a Kind cluster in docker.
    Kind is using docker to start the nodes as containers with nested Kubernetes.

    Take a look at the `kind-default.yaml` to change the number of master and agent nodes or customize other [kind options](https://kind.sigs.k8s.io/docs/user/configuration/#getting-started).

2. `cluster-system/cluster-setup.sh`

   This sub-script creates a namespace `cluster-system`. All following custom cluster-wide components will be deployed to this namespace via helm charts.

   1. `cluster-system/metrics-server/install.sh`

      Installs the Kubernetes metrics-server from the [original helm chart](https://github.com/kubernetes-sigs/metrics-server).

   2. `cluster-system/cert-manager/install.sh`

      The script generates a self-signed root certificate (if not already existend in the [`certs`](https://github.com/groundhog2k/kind-setup/tree/main/cluster-system/cert-manager/certs) folder) and deploys this together with the [Jetstack cert-manager](https://github.com/cert-manager/cert-manager).

   3. `cluster-system/ingress-nginx/install.sh`

      Deploys the [Ingress-nginx](https://github.com/kubernetes/ingress-nginx) service as Kubernetes Ingress Controller.

   4. `cluster-system/k8s-dashboard/install.sh`

      This scripts deploys the [Kubernetes dashboard](https://github.com/kubernetes/dashboard) management UI from the original helm chart.

      Together with the Ingress component from previous step the UI should appear for the local URI [https://k8sdash](https://k8sdash)

   5. `cluster-system/sealed-secrets/install.sh`

      Installs Sealed Secrets support for the cluster. Read more in the [docs about Sealed Secrets](https://github.com/bitnami-labs/sealed-secrets#sealed-secrets-for-kubernetes)

      **Important:**

      **Install the self-signed root certificate into your local browser or computer truststore for root certificates.**
