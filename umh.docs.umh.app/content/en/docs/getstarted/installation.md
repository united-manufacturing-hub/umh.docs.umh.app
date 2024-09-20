---
title: "1. Installation"
menuTitle: "1. Installation"
description: |
  Install the United Manufacturing Hub together with all required tools on a Linux Operating System.
weight: 1000
edition: community
---

If you are new to the United Manufacturing Hub and need a place to start, you
are correct here. You will be guided through setting up an account, install
your first instance and connect it to a OPC UA simulator in no time.

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

1. [Open the Management Console](https://management.umh.app/) in the browser.

2. Click on **Sign up now** and create a new account.

3. Once you are sign in with your new account, click on
**Add Your First Instance**.

## Create your first Instance

1. _Select & Install OS -> TO DO: This depends on the changes to the add instance page_

2. Once you have successfully installed your OS you can continue to the next
page in the Management Console to install the UMH. Here you can configure your
instance. For the first instance you should only change the **Name** and the
**Location** of the instance. These will help you identify an instance once you
have more of them.

3. After this, you can continue by clicking on the **Add Instance** button.
In the dialogue you can find a command you can use to install the UMH on the
machine you set up in the previous steps. To execute it, ssh into the new
machine and paste it in the terminal.

4. Once the installation of the UMH was successful, you can click in the
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
[next page](/docs/getstarted/managingthesystem) to learn how to manage the system,
for example, access to the microservices.
