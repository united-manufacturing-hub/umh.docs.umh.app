---
title: "Flatcar Installation (Virtual Machine)"
content_type: task
description: |
    This page describes how to deploy the United Manufacturing Hub on Flatcar
    Linux in a virtual machine.
weight: 50
aliases:
   - /docs/production-guide/installation/installation-guide-flatcar/
---

<!-- overview -->

Here is a step-by-step guide on how to deploy the UMH stack on
[Flatcar Linux](https://www.flatcar.org/), a Linux distribution designed for
container workloads, with high security and low maintenance, in a virtual machine.

This is a good option if you want to deploy the UMH stack on a virtual machine
to try out the installation process or to test the UMH stack.

## {{% heading "prerequisites" %}}

You need the latest version of our
[iPXE boot image](https://github.com/united-manufacturing-hub/ipxe/releases/latest/download/ipxe-x86_64-bios.iso).

The image needs to be written to a USB stick. If you want to know how to do this,
follow our
[guide on how to flash an operating system onto a USB-stick](https://learn.umh.app/course/flashing-an-operating-system-onto-a-usb-stick/).

You also need to have a virtual machine software installed on your computer. We
recommend [VirtualBox](https://www.virtualbox.org/), which is free and open
source, but other solutions are also possible.

Additionally, you need to have either [UMHLens](https://github.com/united-manufacturing-hub/UMHLens)
or [OpenLens](https://github.com/MuhammedKalkan/OpenLens) installed.

<!-- steps -->

## Create a virtual machine

Create a new virtual machine in your virtual machine software. Make sure to
use the following settings:

- **Operating System**: Linux
- **Version**: Other Linux (64-bit)
- **CPU cores**: 2
- **Memory size**: 4 GB
- **Hard disk size**: 10 GB

Also, the network settings of the virtual machine must allow communication with
the internet and the host machine. If you are using VirtualBox, you can check
the network settings by clicking on the virtual machine in the VirtualBox
manager and then on **Settings**. In the **Network** tab, make sure that the
**Adapter 1** is set to **Bridged Adapter**.

## Install Flatcar Linux

1. Start the virtual machine.
2. Accept the License.
3. Set a static IP address.
4. Select `sda` as the disk.
5. Select Confirm.

Now the installation will start. You should see a green login prompt soon after,
that says `core@flatcar-0-install-0`. At this point the system is still
installing. After a few minutes, depending on the speed of your network, the
installation will finish and the system will reboot.

By default, it will reboot into the installation environment. Just shut down the
virtual machine and remove the ISO image from the CD drive, then boot the
virtual machine again. This way, the installation process will continue, at the
end of which you will a login prompt that says `flatcar-1-umh-0`, as well as
the IP address of the device.

{{% notice note %}}
Please note that the installation may take some time. This largely depends on the available resources
including network speed and system performance.
{{% /notice %}}

## Connect to the virtual machine

You can leave the virtual machine running and connect to it using SSH, so that
is easier to work with it.

Open a terminal on your computer and connect to the edge device via SSH, using
the IP address you saw on the login prompt:

```bash
ssh core@<ip-address>
```

If you are on Windows, you can use [MobaXTerm](https://mobaxterm.mobatek.net/)
to connect to the edge device via SSH. Open MobaXTerm and click on **Session**
in the top left corner. Then click on **SSH** and enter the IP address of the
edge device in the **Remote host** field. Click on **Advanced SSH settings** and
enter `core` in the Username field. Click on **Save** and then on **Open**.

The default password for the `core` user is `umh`.

## Import the cluster configuration

{{< include "import-cluster-config" >}}

## Access the UMH stack

{{< include "access-umh-via-lens" >}}

<!-- Optional section, but recommended; write the problem/question in H3 -->
## {{% heading "troubleshooting" %}}

### The installation stops at the green login prompt

To check the status of the installation, run the following command:

```bash
systemctl status installer
```

If the installation is still running, you should see something like this:

```bash
● installer.service - Flatcar Linux Installer
     Loaded: loaded (/usr/lib/systemd/system/installer.service; static; vendor preset: enabled)
     Active: active (running) since Wed 2021-05-12 14:00:00 UTC; 1min 30s ago
```

Otherwise, the installation failed. You can check the logs to see what went wrong.

### I can access the cluster but there are no resources

First completely shut down {{< resource type="lens" name="name" >}} (from the
system tray). Then start it again and try to access the cluster.

If that doesn't work, access the virtual machine via SSH and run the following
command:

```bash
systemctl status k3s
```

If the output contains a status different from `active (running)`, the cluster
is not running. Otherwise, the UMH installation failed. You can check the logs
with the following commands:

```bash
systemctl status umh-install
systemctl status helm-install
```

If any of the commands returns some errors, is probably easier to reinstall the
system.

### I can't SSH into the virtual machine

If you can't SSH into the virtual machine, make sure that the network settings
for the virtual machine are correct. If you are using VirtualBox, you can check
the network settings by clicking on the virtual machine in the VirtualBox
manager and then on **Settings**. In the **Network** tab, make sure that the
**Adapter 1** is set to **NAT**.

Disable any VPNs that you might be using.

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- You can follow the [Getting Started](https://learn.umh.app/getstarted) guide
  to get familiar with the UMH stack.
- If you already know your way around the United Manufacturing Hub, you can
  follow the [Administration guides](/docs/production-guide/administration/) to
  configure the stack for production.
