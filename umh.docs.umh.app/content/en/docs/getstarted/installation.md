---
title: "1. Installation"
menuTitle: "1. Installation"
description: |
  Install the United Manufacturing Hub together with all required tools on a Linux Operating System.
weight: 1000
edition: community
---

If you are new to the United Manufacturing Hub and need a place to start, this
is the place to be. You will be guided through setting up an account,
installing your first instance and connecting to an OPC UA simulator in no time.

## Requirements

- You will need an edge device, bare metal server or virtual machine with
  internet access. The operating system will be installed at a later stage.
- Your edge device, bare metal server or VM should meet the following minimum
  requirements or the installation will fail:
  - CPU: 4 cores
  - Memory: 16 GB
  - Storage: 32 GB
- A personal computer with a recent browser to access the
[Management Console](https://www.management.umh.app).

## Sign Up to the Management Console

1. [Open the Management Console](https://management.umh.app/) in the browser,
click on **Sign up now** and create a new account.

2. Once logged in with your new account, click on
**Add Your First Instance**.

## Create your first Instance

1. We support Rocky, RHEL or
  Flatcar, but we strongly recommend using Rocky. You can find a list of
  supported versions and the image for Rocky by clicking on the
  on the right hand side of the Management Console.
  {{% notice note %}}
  Newer or older versions of the operating system, or other operating systems
  such as Ubuntu, may work, but please note that we do not support them
  commercially.
  {{% /notice %}}

2. Once you have successfully installed
  your operating system, you can configure your instance in the Management
  Console. For the first instance you should only change the **Name** and
  **Location** of the instance. These will help you to identify an instance
  if you have more than one.

3. Once the name and location are set,
  continue by clicking on the **Add Instance** button. To install the UMH, copy
  the command shown in the dialogue box, SSH into the new machine, paste the
  command and follow the instructions. This command will run the installation
  script for the UMH and connect it to your Management Console account.

4. If the UMH installation was
  successful, you can click the **Continue** button. Your instance should appear in the **Instances** and **Topology** sections of the left-hand menu after a few minutes.

5. To learn how to connect a data source such as an OPC UA server to this
machine, follow the [Data Acquisition and Management](https://umh.docs.umh.app/docs/getstarted/dataacquisitionmanipulation/)
guide.

## Do you need more technical background information?

Here are some links to get you started:

- [Introduction IT](https://learn.umh.app/course/introduction-into-it-ot-information-technology/)
- [Introduction OT](https://learn.umh.app/course/introduction-into-it-ot-operational-technology-ot/)
- [Introduction IIoT](https://learn.umh.app/course/introduction-into-it-ot-industrial-internet-of-things-iiot/)
- [The Architecture of the UMH](https://umh.docs.umh.app/docs/architecture/)

## What's next?

Once you installed UMH, you can continue with the
[next page](/docs/getstarted/dataacquisitionmanipulation) to learn how to
connect an OPC UA server to your instance.
