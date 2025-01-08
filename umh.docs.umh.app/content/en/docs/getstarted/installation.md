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

### Device

- You will need an **edge device, bare metal server or virtual machine** with
  internet access. The device should meet the following
  **minimum requirements or the installation will fail**:

  <!-- Dynamic Requirements Section -->
  <div id="requirements-2">
  <!-- Dynamic content will be loaded here -->
  </div>

- ARM-based systems, such as a Raspberry Pi, are not currently supported.

- Ensure the root partition (`/`) has at least <span id="storage-requirements"></span> of free space. The default Rocky Linux installation creates a large `/home` partition, so custom partitioning during the installation of Rocky Linux may be required.
- For network connectivity with other machines, use a bridged network adapter in the virtual machine. NAT or host-only adapters will prevent external connections to your instance.

### Operating System

  We support the following **operating systems**:

  <div id="requirements-3">
  <!-- Dynamic content will be loaded here -->
  </div>
  You can find the image for Rocky in the Management Console when you are
  setting up your first instance. A minimal installation (without GUI) is sufficient
  and recommended for faster setup.

  {{% notice note %}}
  Newer or older versions of the operating system, or other operating systems
  such as Ubuntu, may work, but please note that we do not support them
  commercially.
  
  {{% /notice %}}

### Network

- A personal computer with a recent browser to access the
[Management Console](https://management.umh.app).
- Ensure that management.umh.app is allowlisted on TCP port 443 for HTTPS traffic.

  {{% notice note %}}
  You can also check our [Recommended Firewall Settings](https://umh.docs.umh.app/docs/production-guide/security/firewall-rules/).
  {{% /notice %}}

## Sign Up to the Management Console

1. [Open the Management Console](https://management.umh.app/) in the browser,
click on **Sign up now** and create a new account.

2. Once logged in with your new account, click on
**Add Your First Instance**.

{{% notice note %}}
The Community Edition is limited to one user per organization. For multi-user support, please consider our Enterprise Edition.
{{% /notice %}}

## Create your first Instance

1. First you have to set up your device and install the operating system.
  We support <span id="requirements-4"></span>, but we strongly recommend
  using Rocky. You can find a list of the requirements and the image for
  Rocky by clicking on the **REQUIREMENTS** button on the right hand side of the
  Management Console.

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

## What's next?

Once you installed UMH, you can continue with the
[next page](/docs/getstarted/dataacquisitionmanipulation) to learn how to
connect an OPC UA server to your instance.
