+++
title = "1. Installation"
menuTitle = "1. Installation"
description = "Install the United Manufacturing Hub together with all required tools on a Linux Operating System."
weight = 1000
+++


The United Manufacturing Hub (UMH) can be deployed on various external devices, including edge devices and virtual machines (VMs). For initial installations or for development purposes, it is recommended to use a VM.

## Software Requirements
The UMH installation requires one of the following Operaing System on your server:
- Flatcar version current-2023 or higher (3510.3.1). Recommended where where you have full control over the operating system. To install Flatcar on your server, follow [this guide](https://umh.docs.umh.app/docs/production-guide/installation/flatcar-installation-bare-metal/). <!-- This article needs to be merged together https://umh.docs.umh.app/docs/production-guide/installation/flatcar-installation-virtual-machine/ https://learn.umh.app/course/flatcar-installation-on-proxmox/ -->
- Red Hat Enterprise Linux (RHEL) 9.0 and higher. Recommended when you can choose only out of a small amount of potnetial Operating System in your large enterprise

While UMH is optimized for RHEL and Flatcar, it can theoretically run on other Linux distributions. However, support is not guaranteed. For Windows, you could try running on of the above described Operating Systems in a VM (e.g., Hyper-V). If you experiment with other systems, we encourage sharing your experiences on our [Discord](https://discord.gg/F9mqkZnm9d) channel. 

## Hardware Requirements

- CPU: Minimum 4 cores
- Memory: 16 GB RAM
- Disk Space: 32 GB available

Note: Systems at the edge of these requirements may experience longer installation times. Close other programs during installation for optimal performance.

## Installation Steps

1. [Open the Management Console](https://management.umh.app/) in the browser.

2. When you are finished with the creation of your account, enter your information and click on **SIGN IN**.
![Untitled](/images/getstarted/installation/signin.png)

3. If you are not a member, continue with sign up. Register your information and click on **SIGN UP**.
![Untitled](/images/getstarted/installation/signup.png)

4. Click on **+ADD INSTANCE** button.
![Untitled](/images/getstarted/installation/dashboard.png)

5. Select **Install UMH Only**.
![Untitled](/images/getstarted/installation/addinstance.png)

6. Enter your instace name and then click on **CREATE MY COMMAND**.
![Untitled](/images/getstarted/installation/entername.png)

7. You should be able to see a create command. Copy and paste the following command into your server's terminal (via ssh).
![Untitled](/images/getstarted/installation/command.png)

8. The installation script runs a lot of checking and setup. For example, it checks your operating system, installation of requred tools, and internet connection. After the check phase, kubectl and Helm will be installed. The script shall show you what actions will be happen on your system in the next step. If you want to proceed, type **Y** and press **enter key** on with your keyboard
![Untitled](/images/getstarted/installation/checking.png)

9. In this step, k3s will be installed. Then, it installs the UMH Helm Chart in Kubernetes. After that, the Management Companion will be installed into Kubernetes. Until everything is setup, it can take a while.
![Untitled](/images/getstarted/installation/installphase.png)

10. After successful installation, you should be able to see message like in the picture below.
![Untitled](/images/getstarted/installation/successful.png)

11. Go back to the Management Console and click on "LET'S GO!"
![Untitled](/images/getstarted/installation/letsgo.png)

12. Now, you should be able to see your instance on the dashboard.
![Untitled](/images/getstarted/installation/newinstance.png)

<!-- Show how it does now look like. What does this command now do? When is it finished? How can I see if it is finished 

What happens in the install script:
- a lot of checking
- installes basic tools for manageing KUbernetes like Helm and kubectl
- installs k3s (Kubernetes)
- Installs the UMH Helm Chart into Kubernetes
- Installs the Management Companion into Kubernetes
- Waits until everything is setup 

-->

## Do you need more technical background information?

  Here are some links to get you started:

  - [Introduction IT](https://learn.umh.app/course/introduction-into-it-ot-information-technology/)
  - [Introduction OT](https://learn.umh.app/course/introduction-into-it-ot-operational-technology-ot/)
  - [Introduction IIoT](https://learn.umh.app/course/introduction-into-it-ot-industrial-internet-of-things-iiot/)
  - [The Architecture of the UMH](https://umh.docs.umh.app/docs/architecture/)    

## What's next?

  Once you installed UMH, you can continue with the
  [next page](/docs/getstarted/managingthesystem) to learn how to manage the system, for example, access to the microservices.