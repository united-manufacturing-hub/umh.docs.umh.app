---
title: Provisioning
menuTitle: Provisioning
description: |
  Discover how to provision both the Data and the Device & Container
  Infrastructures.
weight: 1000
edition: community
draft: false
---

The Management Console simplifies the deployment of the
[Data Infrastructure](/docs/architecture/data-infrastructure/) on any existing
system. You can also provision the entire
[Device & Container Infrastructure](/docs/architecture/device--container-infrastructure/),
with a little manual interaction.

## When should I use it?

Whether you have a bare metal server, and edge device, or a virtual machine,
you can easily provision the whole United Manufacturing Hub.
Choose to deploy only the Data Infrastructure on an existing OS, or provision
the entire Device & Container Infrastructure, OS included.

## What can I do with it?

You can leverage our custom iPXE bootstrapping process to install the flatcar
operating system, along with the Device & Container Infrastructure and the
Data Infrastructure.

If you already have an operating system installed, you can use the Management
Console to provision the Data Infrastructure on top of it. You can also choose
to use an existing UMH installation and only connect it to the Management
Console.

![Provisioning from the Management Console](/images/features/provisioning/management-console-provisioning.png?width=80%)

## How can I use it?

If you need to install the operating system from scratch, you can follow the
[Flatcar Installation guide](/docs/production-guide/installation/flatcar-installation/),
which will help you to deploy the default version of the United Manufacturing
Hub.

{{% notice tip %}}
Contact our [Sales Team](https://www.umh.app/contact-us?cta=umh2) to get help on
customizing the installation process in order to fit your enterprise needs.
{{% /notice %}}

If you already have an operating system installed, you can follow the
[Getting Started](/docs/getstarted/installation) guide to provision the Data
Infrastructure and setup the Management Companion agent on your system.

## What are the limitations?

- Provisioning the Device & Container Infrastructure requires manual interaction
  and is not yet available from the Management Console.
- ARM systems are not supported.

## Where to get more information?

- The [Get Started!](/docs/getstarted/) guide assists you to set up
  the United Manufacturing Hub.
- Learn more about the [Data Infrastructure](/docs/architecture/data-infrastructure/).
- Take a look at the [Device & Container Infrastructure](/docs/architecture/device--container-infrastructure/).
