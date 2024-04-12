---
title: "1. Installation"
menuTitle: "1. Installation"
description: |
  Install the United Manufacturing Hub together with all required tools on a Linux Operating System.
weight: 1000
edition: community
---

The United Manufacturing Hub (UMH) can be deployed on various external devices,
including edge devices and virtual machines (VMs). For initial installations
or for development purposes, it is recommended to use a VM.

## Software Requirements

The UMH installation requires one of the following Operating System on your server:

- Flatcar version current-2023 or higher (3510.3.1).
  It is recommended that you have full control over the operating system. To install Flatcar on your server,
  follow [this guide](/docs/production-guide/installation/flatcar-installation/). <!-- This article needs to be merged together https://umh.docs.umh.app/docs/production-guide/installation/flatcar-installation-virtual-machine/ https://learn.umh.app/course/flatcar-installation-on-proxmox/ -->
- Red Hat Enterprise Linux (RHEL) 9.0 and higher. Recommended when you can choose
  out of a small amount of potential Operating Systems.
- Community Supported: Ubuntu 22.04.4 LTS. This approach is useful
  when you're for example trying to install the UMH on a cloud instance like AWS EC2
  and struggle to install Flatcar or RHEL there.

While UMH is optimized for RHEL and Flatcar, it can theoretically run on other Linux distributions.
However, support is not guaranteed.
For Windows, you could try running one of the above described Operating Systems in a VM (e.g., Hyper-V).
If you experiment with other systems, we encourage sharing your experiences
on our [Discord](https://discord.gg/F9mqkZnm9d) channel.

## Hardware Requirements

- CPU: Minimum 4 cores
- Memory: 16 GB RAM
- Disk Space: 32 GB available

Note: Systems at the edge of these requirements may experience longer installation times.
Close other programs during installation for optimal performance.

## Network Requirements

Before proceeding with the installation, ensure your system meets the necessary network requirements.

To learn about configuring firewall and network rules for your UMH instances,
please refer to our dedicated [Firewall Rules](/docs/production-guide/security/firewall-rules/) page.

## Installation Steps

1. [Open the Management Console](https://management.umh.app/) in the browser.

2. When you are finished with the creation of your account, enter your information and click on **SIGN IN**.
   ![Sign in page](/images/getstarted/installation/signin.png)

3. If you are not a member, continue with sign up. Register your information and click on **SIGN UP**.
   ![Sign up page](/images/getstarted/installation/signup.png)

4. You should've been redirected to the **Network View**. Now click on the **+Add Instance** button at the top right corner.

5. Go through the installation wizard by first clicking on **Install the UMH** and then on **UMH Classic**.

6. Configure your instance with the necessary details. Naming your instance is mandatory, while setting its location is
   optional but beneficial for management. The location follows a hierarchical format based on the ISA95 model, allowing
   for increasing specificity. For example, if your instance monitors a packaging line located in Building B of a factory in
   Ehrenfeld, Cologne, you could name it 'Packaging' and set the location as follows: Enterprise: UMH; Site: Ehrenfeld;
   Area: Building B. The Management Console organizes instances in this structure, making it easy to oversee multiple instances.
   Additionally, it helps in verifying data accuracy; for instance, if the enterprise is mistakenly entered as 'UHM' instead of
   'UMH', the console will highlight the error based on the mismatch in received data.

7. Once you're ready, create the installation command, and then Copy and paste it into your server's
   terminal (via ssh).
   ![Installation command](/images/getstarted/installation/command.png)

8. The installation script runs a lot of checking and setup. For example, it checks your operating system,
   installation of required tools, and internet connection.
   After the check phase, kubectl and Helm will be installed.
   The script shall show you what actions will happen to your system in the next step.
   If you want to proceed, type **Y** and press **enter key**.
   ![Installation checks](/images/getstarted/installation/checking.png)

9. In this step, k3s will be installed. Then, it installs the UMH Helm Chart in Kubernetes.
   After that, the Management Companion will be installed into Kubernetes.
   Until everything is set up, it can take a while.
   ![Installation logs](/images/getstarted/installation/installphase.png)

10. After a successful installation, you should be able to see messages like in the picture below.
    ![Installation success message](/images/getstarted/installation/successful.png)

11. Back to the Management Console, everything's ready and you click on **Let's Go!**.

12. Now in the Network View, a single node representing your newly created UMH instance should be visible.
    ![Network View](/images/getstarted/installation/networkView.png)

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
[next page](/docs/getstarted/managingthesystem) to learn how to manage the system,
for example, access to the microservices.
