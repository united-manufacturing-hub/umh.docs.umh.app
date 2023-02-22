+++
title = "Installation"
menuTitle = "Installation"
description = ""
weight = 1000
+++


The United Manufacturing Hub can be installed locally or on an edge device, depending on your needs. For simple tinkering and development, we recommend installing it locally using our Management Console. If you prefer an open-source approach, we also provide instructions for using k3d.


## Local installation using the Management Console (recommended)

We have a very detailed documentation on how to install the management console and how to create your first local instance with it. Click here to view the [documentation](https://mgmt.docs.umh.app/docs/getstarted/).

![Untitled](/images/getstarted/installation/getStartedIntallationMC.png)

## Local installation using k3d (may not be upto date)


### Requirements

- Operating system (64-bit):
    - Windows 10 version 2004 and higher or Windows 11
- Hardware:
    - CPU: 2 cores or more
    - RAM: 8GB or more
    - Storage: 10GB free

### Dependencies

1. Verify that you have WSL installed.
    - Open Powershell and type `wsl --status`. If you get an error you probably need to install it. Refer to the Microsoft [documentation](https://learn.microsoft.com/en-us/windows/wsl/install) on how to do that.

1. Docker Desktop
    - You can follow the Docker documentation [here](https://docs.docker.com/desktop/install/windows-install/#install-docker-desktop-on-windows).

1. Chocolatey
    - Read how to do that [here](https://chocolatey.org/install#individual).

### Installation

1. Make sure your Docker Desktop application is running.
2. Open a PowerShell terminal. Be sure to use the option Run as Administrator.
3. Install kubectl

   `choco install kubernetes-cli`

4. Install helm

   `choco install kubernetes-helm`

5. Install k3d
   `choco install k3d`
6. Create the cluster

   `k3d cluster create united-manufacturing-hub`

7. Create a namespace in Kubernetes
   `kubectl create namespace united-manufacturing-hub`
    1. If you get an error like this (the IP doesn’t matter):

        ```
        Unable to connect to the server: dial tcp 123.456.789.132:63074: connectex: 
        A connection attempt failed because the connected party did not properly 
        respond after a period of time, or established connection failed because 
        connected host has failed to respond.
        ```

       delete your k3d cluster and re-create it with the api-port flag:

        1. `k3d cluster delete united-manufacturing-hub`
        2. `k3d cluster create united-manufacturing-hub --api-port 127.0.0.1:6443`
8. Add the UMH repo
   `helm repo add united-manufacturing-hub https://repo.umh.app/`
9. Ensure it is up-to-date with
   `helm repo update`
10. Install the stack

    `helm install united-manufacturing-hub united-manufacturing-hub/united-manufacturing-hub -n united-manufacturing-hub`

11. Open UMHLens on your device. You can get UMHLens for free from this [GitHub Repository](https://github.com/MuhammedKalkan/OpenLens).
12. Sometimes UMHLens automatically creates a k3d-Cluster. Click on Browse-Clusters to check. If there is no cluster you have to create it manually (follow step 13-18) otherwise continue with step 18.
13. Get the Helm config to import into UMHLens

    `kubectl config view --raw`

14. Click the three horizontal lines in the upper left corner and choose files → preferences
15. Click on Kubernetes and select “Add custom repo”, type in `https://repo.umh.app`
    as the URL and decide on a name for the repository.
16. Click again file → Add Cluster
17. Paste the clipboard (which you got from `kubectl config view --raw`) into the kubectl prompt of UMHLens.
18. Click on Add Cluster.
19. Click on Browse Clusters in Catalog, then connect to the Cluster.
20. Click on Helm -> Releases and change the namespace from default to united-manufacturing-hub in the upper right corner

    ![Untitled](/images/getstarted/installation/getStartedIntallationMC.png)

21. Click on the Release `united-manufacturing-hub`to be able to inspect the values.yaml file, which holds the configurations of all microservices used in the cluster.

<aside>
{{% notice warning %}}  ️ Accessing the services like Node-RED can only be done using the [port-forwarding feature](/guides/knowledge-base/4d2b03ecbd5f45089d7c06d8c356134d/) from UMHLens.  {{% /notice %}} 

</aside>