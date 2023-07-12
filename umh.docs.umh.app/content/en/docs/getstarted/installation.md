+++
title = "1. Installation"
menuTitle = "1. Installation"
description = "Install the United Manufacturing Hub using the Management Console."
weight = 1000
+++


  The United Manufacturing Hub can be installed locally, on your current 
  computer, or on an external device, for example an edge device or a VM.
  For your first installation or simple tinkering and development, we recommend installing it locally using
  our Management Console.
  {{% notice note %}}
  If you prefer an open-source approach, we also provide instructions for
  using [k3d](/docs/production-guide/installation/local-k3d-installation/).
  {{% /notice %}}


## Hardware Requirements

  If you want to install the United Manufacturing Hub locally, on your own 
  device, you will need a device that fits the following requirements:
  - CPU cores: 4
  - Memory size: 16 GB
  - available disk space: 32 GB

  If you only want to install the Management Console to manage external devices,
  you will need a
  device that fits the following requirements:
  - CPU cores: 4
  - Memory size: 8 GB
  - available disk space: 32 GB

  If you are at the limits of these requirements, the installation might take 
  longer. It is also advised, to close other unused programs during the
  installation.


## Local installation using the Management Console (recommended)


  The Management Console is a client-side software, designed to assist you in 
  the installation, configuration, and maintenance of the United Manufacturing
  Hub (UMH) locally, on edge devices, virtual machines, on-premises servers, or
  in the cloud. Although the Management Console currently operates exclusively
  on Windows, it can facilitate the installation of UMH instances on a wide
  array of platforms, using Flatcar (a very basic and stable Linux version).
  **To avoid any confusion, it's essential to understand that the 
  United Manufacturing Hub does not mandate Windows; this requirement
  only pertains to the Management Console, not the UMH itself.**
  
1. Download the Management Console and follow the instructions in the 
   documentation to install it.

<a class="btn btn-primary" href="https://mgmt.docs.umh.app/docs/getstarted/download/" target="_blank" role="button" aria-label="Management Console">Management Console</a>

2. When you are finished with the creation of your account, continue with the
   [next page](https://umh.docs.umh.app/docs/getstarted/managingthesystem/).

## Do you need more technical background information?

  Here are some links to get you started:
 

  - [Introduction IT](https://learn.umh.app/course/introduction-into-it-ot-information-technology/)
  - [Introduction OT](https://learn.umh.app/course/introduction-into-it-ot-operational-technology-ot/)
  - [Introduction IIoT](https://learn.umh.app/course/introduction-into-it-ot-industrial-internet-of-things-iiot/)
  - [The Architecture of the UMH](https://umh.docs.umh.app/docs/architecture/)    

## What's next?

  Once you have downloaded the Management Console, you can continue with the
  [next page](/docs/getstarted/managingthesystem) of this tutorial to install
  the Management Console and a local United Manufacturing Hub instance, and
  learn how to access the microservices.