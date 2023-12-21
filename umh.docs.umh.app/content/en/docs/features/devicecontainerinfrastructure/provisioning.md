---
title: Provisioning
menuTitle: Provisioning
description: |
  Discover how to provision both the Data and the Device & Container
  Infrastructures using the Management Console.
weight: 1000
edition: community
draft: false
---

The Management Console simplifies the deployment of the
[Data Infrastructure](/docs/architecture/data-infrastructure/) on any existing
system, and also guides you through the provisioning of the
[Device & Container Infrastructure](/docs/architecture/device--container-infrastructure/).

## When should I use it?

Utilize the Management Console for initial deployment of the United
Manufacturing Hub. It supports provisioning on both centralized servers and
edge devices, offering flexibility in deployment options.

## What can I do with it?

Provision the United Manufacturing Hub on any existing system, and link it to
the Management Console. The Management Console will then be able to manage the
system and its resources.

## How can I use it?

To start, add a new instance in the Management Console. The Console provides a
command that you execute on your target system, automating the installation of
the United Manufacturing Hub. For detailed system requirements and
compatibility, consult the [Installation](/docs/getstarted/installation/) guide.

## What are the limitations?

- A beforehand installed operating system is necessary for installation and 
linking to the Management Console. As of now, the Console does not support 
provisioning new systems directly.
- Automated tests running on flatcar and RHEL are available, and it should work 
on other OS as well, but they are not officially supported.

## Where to get more information?

- The [Get Started!](/docs/getstarted/) guide assists you to set up
  the United Manufacturing Hub.
- Learn more about the [Data Infrastructure](/docs/architecture/data-infrastructure/).
- Take a look at the [Device & Container Infrastructure](/docs/architecture/device--container-infrastructure/).
