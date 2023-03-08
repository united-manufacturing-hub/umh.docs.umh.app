---
title: "Local k3d installation"
description: "Deploy the UMH stack with k3d"
---

{{% notice tip %}}
This installation method can now be done automatically by using the [Community Edition of the Management Console](https://mgmt.docs.umh.app/). Go check it out!
{{% /notice %}}

Here is a step-by-step guide on how to deploy the UMH stack using
[k3d](https://k3d.io), a lightweight wrapper to run
[k3s](https://github.com/rancher/k3s) in docker. k3d makes it very easy to create
single- and multi-node k3s clusters in docker, e.g. for local development on
Kubernetes.

## {{< heading "prerequisites" >}}

### System requirements

- Operating system (64-bit):
  - Windows 10 version 2004 and higher or Windows 11
- Hardware:
  - CPU: 2 cores or more
  - RAM: 8GB or more
  - Storage: 10GB free

### Dependencies

- Verify that you have WSL installed. Open Powershell and type

  ```powershell
  wsl --status
  ```

  The output should look like this:

  ```none
  Default Distribution: Debian
  Default Version: 2

  Windows Subsystem for Linux was last updated on 30/01/2023
  WSL automatic updates are on.

  Kernel version: 5.10.102.1
  ```
  
  If you get an error, efer to the Microsoft
  [documentation](https://learn.microsoft.com/en-us/windows/wsl/install) on how
  to install WSL.
- [Docker Desktop](https://docs.docker.com/desktop/install/windows-install/#install-docker-desktop-on-windows)
- [Chocolatey](https://chocolatey.org/install#individual)

## Installation

1. Make sure your Docker Desktop application is running.
2. Open a PowerShell terminal as Administrator.
3. Install kubectl

   ```powershell
   choco install kubernetes-cli
   ```

4. Install helm

   ```powershell
   choco install kubernetes-helm
   ```

5. Install k3d

   ```powershell
   choco install k3d
    ```

6. Create the cluster

   ```powershell
   k3d cluster create {{< resource type="cluster" name="name" >}} --api-port 127.0.0.1:6443
   ```

7. Create a namespace in Kubernetes

   ```powershell
   kubectl create namespace {{< resource type="ns" name="name" >}}
   ```

8. Add the UMH repo

   ```powershell
   helm repo add {{< resource type="helm" name="repo" >}} https://repo.umh.app/
   ```

9. Ensure it is up-to-date with

   ```powershell
   helm repo update
   ```

10. Install the stack

    ```powershell
    helm install {{< resource type="helm" name="release" >}} {{< resource type="helm" name="repo" >}}/united-manufacturing-hub -n {{< resource type="ns" name="name" >}}
    ```

11. Open {{< resource type="lens" name="name" >}} on your device. You can get
    [UMHLens](https://github.com/united-manufacturing-hub/UMHLens) or
    [OpenLens](https://github.com/MuhammedKalkan/OpenLens) from GitHub.
12. From the homepage, click on **Browse Clusters in Catalog**. The cluster should
    be listed there.

    If it is not listed, you can add it manually by following the steps below.

    1. From the terminal, get the kubeconfig for the cluster

       ```powershell
       k3d kubeconfig get united-manufacturing-hub
       ```

    2. Copy the output of the command
    3. In {{< resource type="lens" name="name" >}}, click on the three horizontal
       lines in the upper left corner and choose **Files** > **Add Cluster**.
    4. Paste the kubeconfig and click **Add clusters**.
13. Click on the cluster to connect to it.
14. Navigate to **Helm** > **Releases** and change the namespace from default to
    {{< resource type="ns" name="name" >}} in the upper right corner

    ![lens-namespaces](/images/installation/local-k3d-installation/lens-namespaces.png)

15. Select the {{< resource type="helm" name="release" >}} Release to inspect the
    Helm values, which holds the configurations of all microservices used in the
    cluster.

## {{< heading "whatsnext" >}}

- You can follow the [Getting Started](https://learn.umh.app/getstarted) guide
  to get familiar with the UMH stack.
- If you already know your way around the United Manufacturing Hub, you can
  follow the [Administration guides](/docs/production-guide/administration/) to
  configure the stack for production.
