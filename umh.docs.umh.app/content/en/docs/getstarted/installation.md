+++
title = "1. Installation"
menuTitle = "1. Installation"
description = "Install the United Manufacturing Hub using the Management Console."
weight = 1000
+++


  The United Manufacturing Hub will be installed, or you can linking your existing UMH instance with the Management Console.

## Software Requirements
  The UMH installation requires one of the following Operaing System on your server:
  - Flatcar version current-2023 or higher
  - RHEL 9.0 or higher

  If you already have one of them runnning or if you don't have it yet running, but would like to install Flatcar on the server, you can follow this guide.

  You can try other OS, but proceed on your own risk (but we would be glad if you could write us if it worked or not on a certain OS, just contact us in [Discord](https://discord.gg/F9mqkZnm9d))

## Hardware Requirements

  You will need a device that fits the following requirements:
  - CPU cores: 4
  - Memory size: 16 GB
  - available disk space: 32 GB

  If you are at the limits of these requirements, the installation might take 
  longer. It is also advised, to close other unused programs during the
  installation.


## Flatcar Installation
  If you would like to install Flatcar on your server, follow [this documentaion](https://umh.docs.umh.app/docs/production-guide/installation/flatcar-installation-bare-metal/). If you have the mentioned OS running, skip this step.

  {{% notice note %}}
  **The Management Console provides a demo mode for a quick overview without additional setups.**
  If you would like to run the UMH on a VM, setup the environment and install a OS. We recommend you to install it with Flatcar or simmilar OS. [This guide](https://umh.docs.umh.app/docs/production-guide/installation/flatcar-installation-virtual-machine/) helps you for installing the UMH on Flatcar with VM.
  You can also read a instruction for [UMH Deployment on Proxmox with Flatcar and k3s](https://learn.umh.app/course/flatcar-installation-on-proxmox/).
  {{% /notice %}}


## Install UMH with the Management Console

  The Management Console is a client-side web application, designed to assist you in 
  the installation, configuration, and maintenance of the United Manufacturing
  Hub (UMH).
  **To avoid any confusion, it's essential to understand that the 
  United Manufacturing Hub does not mandate Windows; this requirement
  only pertains to the Management Console, not the UMH itself.**
  
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

## Do you need more technical background information?

  Here are some links to get you started:
 

  - [Introduction IT](https://learn.umh.app/course/introduction-into-it-ot-information-technology/)
  - [Introduction OT](https://learn.umh.app/course/introduction-into-it-ot-operational-technology-ot/)
  - [Introduction IIoT](https://learn.umh.app/course/introduction-into-it-ot-industrial-internet-of-things-iiot/)
  - [The Architecture of the UMH](https://umh.docs.umh.app/docs/architecture/)    

## What's next?

  Once you installed UMH, you can continue with the
  [next page](/docs/getstarted/managingthesystem) to learn how to manage the system, for example, access to the microservices.