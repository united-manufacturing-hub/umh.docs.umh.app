---
title: Provisioning
menuTitle: Provisioning
description: Learn the different ways to provision the the Data and the Device & Container Infrastructures.
weight: 1000
edition: community
draft: true
---

Using the UMH's Management Console, you can provision the UMH in a simple process.


## When should I use it?
There are multiple ways to provision the United Manufacturing Hub. The choice depends on the use case and the available resources.

- **Install UMH + Operating System**: This option is currently not implemented. You will get a .iso image that installs the corresponding operating system and the UMH. It also configures the Management Companion for you automatically. 
- **Install UMH Only**: If you want to install the UMH on your server, this option is the best choice. This option requires that a supported operating system is installed on your server. The user will receive a single command that must be executed via SSH on an existing Linux system. You find the software and hardware requirements on the [Installation](/docs/getstarted/installation/) page.
- **Test the UMH**: This option is currently not implemented. You will get a local installation guide on Linux OS and Windows.


## What can I do with it?
The Management Console lets you deploy the [Data Infrastructure](https://www.umh.app/umh-integrated-platform-data-infrastructure) on any existing system, and also guides you through the provisioning of the [Device & Container Infrastructure](https://www.umh.app/umh-integrated-platform-device-container-infrastructure).

## How can I use it?
After logging in to the Management Console, you can click on the **+ ADD INSTANCE** button in the top right corner. This will open a dialog where you can choose between the different provisioning options.

![](/images/getstarted/installation/dashboard.png?width=80%)

The next page will ask you to select a install type. After selecting, follow the installation guide.

![](/images/features/provisioning/provision.png?width=80%)

## What are the limitations?
- **Install UMH Only** option is suitable for use with RHEL and Flatcar Linux. While other Linux OS versions may work, they are not officially supported.
- Installation requiremetns should be fulfilled. You can find them on the Management Console or on the [Installation](/docs/getstarted/installation/) page.

## Where to get more information?
- The [Get Started!](/docs/getstarted) guide assists you to set up the United Manufacturing Hub.
- To get an overview of the Data Infrastructure, visit [this page](https://www.umh.app/umh-integrated-platform-data-infrastructure).
- To get an overview of the Device & Container Infrastructure, visit [this page](https://www.umh.app/umh-integrated-platform-device-container-infrastructure).