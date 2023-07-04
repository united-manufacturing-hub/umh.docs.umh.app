+++
title = "1. Installation"
menuTitle = "1. Installation"
description = "Installing the united manufacturing hub using the Management Console"
weight = 1000
+++


The United Manufacturing Hub can be installed locally or on an external device, 
as an edge device or a VM, depending on your needs.
For simple tinkering and development, we recommend installing it locally using
our Management Console.
{{% notice note %}}
If you prefer an open-source approach, we also provide instructions for
using [k3d](/docs/production-guide/installation/local-k3d-installation/).
{{% /notice %}}


## Local installation using the Management Console (recommended)

**The Management Console itself ist currently only running on Windows, the 
UMH instances created by it can be deployed on any platform.**
We've put together a comprehensive guide on how to install the UMH locally on
your computer using our **Management Console**. The Management Console is a
desktop application allowing you to setup, configure and maintain your IT / OT 
infrastructure - independent whether it is deployed as a test instance on the 
same device as the Management Console, or on an edge-device, on-premise server 
or in the cloud.

To access the documentation, simply click on the button below.

<a class="btn btn-primary" href="https://mgmt.docs.umh.app/docs/getstarted/download/" target="_blank" role="button" aria-label="Management Console">Management Console</a>


{{% notice note %}}
Please note that the Management Console is currently available 
**under Windows only**. **If you want to use the Management Console on 
Linux or Mac**, please look into the
[production guides for OS specific installation tutorials](/docs/production-guide/installation/).

External Instances are running on Flatcar, a Linux version, by default.
{{% /notice %}}

## Do you need more technical background information?

  Here are some links to get you started:
  1. General information about IT and OT:

      - [Introduction IT](https://learn.umh.app/course/introduction-into-it-ot-information-technology/)
      - [Introduction OT](https://learn.umh.app/course/introduction-into-it-ot-operational-technology-ot/)
      - [Introduction IIoT](https://learn.umh.app/course/introduction-into-it-ot-industrial-internet-of-things-iiot/)


## What's next?

Once you've completed the installation process, we'll guide you through 
accessing the microservices using UMHLens. To learn more click 
[here](/docs/getstarted/managingthesystem).
