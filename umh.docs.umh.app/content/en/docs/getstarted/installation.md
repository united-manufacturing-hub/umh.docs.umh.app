---
title: "1. Installation"
menuTitle: "1. Installation"
description: |
  Install the United Manufacturing Hub together with all required tools on a Linux Operating System.
weight: 1000
edition: community
---

If you are new to the United Manufacturing Hub and need a place to start, you
are correct here. You will be guided through setting up an account, installing
your first instance and connect it to an OPC UA simulator in no time.

## Requirements

- You need an edge device, bare metal server or a virtual machine with internet
access. The operating system will be installed in a later step.
- Your edge device, bare metal server or VM should meet the following minimum
requirements, or the installation will fail:
  - CPU: 4 Cores
  - Memory: 16 GB
  - Storage: 32 GB
- A personal computer with a recent browser to access the
[Management Console](https://www.management.umh.app).

## Sign Up to the Management Console

1. [Open the Management Console](https://management.umh.app/) in the browser,
click on **Sign up now** and create a new account.

2. Once you are signed in with your new account, click on
**Add Your First Instance**.

## Create your first Instance

1. As operating system we support Rocky, RHEL or
  Flatcar, but highly recommend using Rocky. You can find a list of the
  supported versions and the image for Rocky by clicking
  on **Requirements** on the right side of the Management Console.
  {{% notice note %}}
  Newer or older versions of the OS, or other OS such as Ubuntu, might
  work, but please note that we do not support those commercially.
  {{% /notice %}}

2. Once you have successfully installed your OS you can configure your instance
  in the Management Console. For the first instance you should only change the
  **Name** and the **Location** of the instance. These will help you identify
  an instance once you have more of them.

3. Once Name and Location are set, continue by clicking on the
  **Add Instance** button. To install the UMH copy the command shown in
  the dialogue, SSH into the new machine, paste the command and follow the
  instructions. This command will run the installation script for the UMH
  and connect it to you Management Console account.

4. Once the installation of the UMH was successful, you can click on the
  **Continue** button. You should now see your instance in the **Instances**
  and in the **Topology** section in the left menu.

5. To learn how to connect a data source like an OPC UA server to this machine,
  follow the [Data Aquisition and Manioulation](https://umh.docs.umh.app/docs/getstarted/dataacquisitionmanipulation/)
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
