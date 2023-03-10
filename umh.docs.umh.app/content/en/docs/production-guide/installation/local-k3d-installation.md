---
title: "Local k3d Installation"
content_type: task
description: |
    This page describes how to deploy the United Manufacturing Hub locally using
    k3d.
weight: 50
---

<!-- overview -->

{{% notice tip %}}
This can now be done using the
[Community Edition of the Management Console](https://mgmt.docs.umh.app/).
Go check it out!
{{% /notice %}}

Here is a step-by-step guide on how to deploy the UMH stack using
[k3d](https://k3d.io), a lightweight wrapper to run
[k3s](https://github.com/rancher/k3s) in Docker. k3d makes it very easy to create
single- and multi-node k3s clusters in Docker, e.g. for local development on
Kubernetes.

## {{% heading "prerequisites" %}}

{{< include "task-befinst-prereqs.md" >}}

You also need to have [Docker](https://docs.docker.com/get-docker/) up and
running.

<!-- If you set the minimum_version or maximum_version parameter in the page's
     front matter, add the version check shortcode {{< version-check >}}.
-->

<!-- steps -->

## Install dependencies

1. Install kubectl. Refer to the [kubectl installation](https://kubernetes.io/docs/tasks/tools/#kubectl)
   if you need help.

   {{< tabs name="kubectl-install" >}}
   {{% tab name="Windows" %}}

   ```powershell
   choco install kubernetes-cli
   ```

   {{% /tab %}}
   {{% tab name="macOS" %}}

   ```bash
   brew install kubectl
   ```

   {{% /tab %}}
   {{% tab name="Linux" %}}

   ```bash
   curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
   sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
   ```

   {{% /tab %}}
   {{< /tabs >}}

2. Install Helm. Refer to the [Helm installation](https://helm.sh/docs/intro/install/)
   if you need help.
  
   {{< tabs name="helm-install" >}}
   {{% tab name="Windows" %}}
  
   ```powershell
   choco install kubernetes-helm
   ```
  
   {{% /tab %}}
   {{% tab name="macOS" %}}
  
   ```bash
   brew install helm
   ```
  
   {{% /tab %}}
   {{% tab name="Linux" %}}
  
   ```bash
   curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
   chmod 700 get_helm.sh
   ./get_helm.sh
   ```
  
   {{% /tab %}}
   {{< /tabs >}}

3. Install k3d. Refer to the [k3d installation](https://k3d.io/#installation)
   if you need help.

   {{< tabs name="k3d-install" >}}
   {{% tab name="Windows" %}}

   ```powershell
   choco install k3d
   ```
  
   {{% /tab %}}
   {{% tab name="macOS" %}}
  
   ```bash
   brew install k3d
   ```
  
   {{% /tab %}}
   {{% tab name="Linux" %}}
  
   ```bash
   curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
   ```
  
   {{% /tab %}}
   {{< /tabs >}}

## Create a cluster

1. Create a cluster.

   ```bash
   k3d cluster create {{% resource type="cluster" name="name" %}} --api-port 127.0.0.1:6443
   ```

2. Verify that the cluster is up and running.

   ```bash
   kubectl get nodes
   ```

   The output should look like this:

   ```bash
   NAME                                            STATUS   ROLES                  AGE   VERSION
   k3d-{{% resource type="cluster" name="name" %}}-server-0           Ready    control-plane,master   10s   v1.24.4+k3s1
   ```

## Install the UMH stack

1. Add the UMH Helm repository.

   ```bash
   helm repo add {{% resource type="helm" name="repo" %}} https://repo.umh.app/
   ```

2. Update the Helm repository.

   ```bash
   helm repo update
   ```

3. Create the namespace.

   ```bash
   kubectl create namespace {{% resource type="ns" name="umh" %}}
   ```

4. Install the UMH stack.

   ```bash
   helm install {{% resource type="helm" name="release" %}} {{% resource type="helm" name="repo" %}}/united-manufacturing-hub -n {{% resource type="ns" name="umh" %}}
   ```

    {{% notice tip %}}
  If you don't want to use the default configuration, you can customize it
  before installing the stack. For more information, refer to the
  [Configuration](/docs/production-guide/administration/customize-umh-installation/#customize-values)
  guide.
    {{% /notice %}}

## Access the UMH stack

1. Open {{< resource type="lens" name="name" >}} on your device. You can get
   [UMHLens](https://github.com/united-manufacturing-hub/UMHLens) or
   [OpenLens](https://github.com/MuhammedKalkan/OpenLens) from GitHub.
2. From the homepage, click on **Browse Clusters in Catalog**. The cluster should
   be listed there.
3. Click on the cluster to connect to it.
4. Navigate to **Helm** > **Releases** and change the namespace from default to
   {{< resource type="ns" name="umh" >}} in the upper right corner.

   ![lens-namespaces](/images/installation/local-k3d-installation/lens-namespaces.png)
5. Select the {{< resource type="helm" name="release" >}} Release to inspect the
   release details, the installed resources, and the Helm values.

<!-- Optional section, but recommended; write the problem/question in H3 -->
## {{% heading "troubleshooting" %}}

### I don't see the cluster in {{< resource type="lens" name="name" >}}

If you don't see the cluster in {{< resource type="lens" name="name" >}}, you
might have to add the cluster manually. To do so, follow these steps:

1. Open a terminal and run the following command to get the kubeconfig file:

   ```bash
   k3d kubeconfig get {{% resource type="cluster" name="name" %}}
   ```

2. Copy the output of the command.
3. Open {{< resource type="lens" name="name" >}}, click on the three horizontal
       lines in the upper left corner and choose **Files** > **Add Cluster**.
4. Paste the kubeconfig and click **Add clusters**.

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- You can follow the [Getting Started](https://learn.umh.app/getstarted) guide
  to get familiar with the UMH stack.
- If you already know your way around the United Manufacturing Hub, you can
  follow the [Administration guides](/docs/production-guide/administration/) to
  configure the stack for production.

