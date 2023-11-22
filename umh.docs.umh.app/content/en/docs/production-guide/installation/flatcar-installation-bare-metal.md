---
title: "Flatcar Installation"
content_type: task
description: |
    This page describes how to deploy the United Manufacturing Hub on Flatcar
    Linux.
weight: 50
aliases:
   - /docs/production-guide/installation/installation-guide-flatcar/
---

<!-- overview -->

Here is a step-by-step guide on how to deploy the United Manufacturing Hub on
[Flatcar Linux](https://www.flatcar.org/), a Linux distribution designed for
container workloads with high security and low maintenance. This will leverage
the UMH Device and Container Infrastructure.

The system can be installed either bare metal or in a virtual machine.

## Prerequisites

Ensure your system meets these minimum requirements:

- 4-core CPU
- 8 GB system RAM
- 32 GB available disk space
- Internet access

You will also need the latest version of the iPXE boot image, suitable for your
system:

- [ipxe-x86_64-efi](https://github.com/united-manufacturing-hub/ipxe/releases/latest/download/ipxe-x86_64-efi.usb):
  For modern systems, recommended for virtual machines.
- [ipxe-x86_64-bios](https://github.com/united-manufacturing-hub/ipxe/releases/latest/download/ipxe-x86_64-bios.usb):
  For legacy systems.
- [ipxe-arm64-efi](https://github.com/united-manufacturing-hub/ipxe/releases/latest/download/ipxe-arm64-efi.usb):
  For ARM architectures (**Note**: Raspberry Pi 4 is currently not supported).

For bare metal installations, flash the image to a USB stick with at least 4 GB
of storage. Our guide on
[flashing an operating system to a USB stick](https://learn.umh.app/course/flashing-an-operating-system-onto-a-usb-stick/)
can assist you.

For virtual machines, ensure UEFI boot is enabled when creating the VM.

Lastly, ensure you are on the same network as the device for SSH access post-installation.

<!-- steps -->

## System Preparation and Booting from iPXE

Identify the drive for Flatcar Linux installation. For virtual machines, this is
typically sda. For bare metal, the drive depends on your physical storage. The
[troubleshooting section](#drive) can help identify the correct drive.

Boot your device from the iPXE image. Consult your device or hypervisor
documentation for booting instructions.

## Installation

At the first prompt, read and accept the license to proceed.

![Read and Accept the License](/images/production-guide/flatcar-installation/flatcar1.png)

Next, configure your network settings. Select DHCP if uncertain.

![Network Settings](/images/production-guide/flatcar-installation/flatcar2.png)

The connection will be tested next. If it fails, revisit the network settings.

Ensure your device has internet access and no firewalls are blocking the connection.

Then, select the drive for Flatcar Linux installation.

![Select the Drive](/images/production-guide/flatcar-installation/flatcar5.png)

A summary of the installation will appear. Check that everything is correct and
confirm to start the process.

![Summary](/images/production-guide/flatcar-installation/flatcar6.png)

Shortly after, you'll see a green command line `core@flatcar-0-install`. Remove
the USB stick or the CD drive from the VM. The system will continue processing.

![Flatcar Install Step 0](/images/production-guide/flatcar-installation/flatcar9.png)

The installation will complete after a few minutes, and the system will reboot.

When you see the green core@flatcar-1-umh login prompt, the installation is
complete, and the device's IP address will be displayed.

{{% notice note %}}
Installation time varies based on network speed and system performance.
{{% /notice %}}

## Connect to the Device

With the system installed, access it via SSH.

For Windows 11 users, the default
[Windows Terminal](https://learn.microsoft.com/en-us/windows/terminal/install)
is recommended. For other OS users, try [MobaXTerm](https://mobaxterm.mobatek.net/).

To do so, open you terminal of choice. We recommend the default
[Windows Terminal](https://learn.microsoft.com/en-us/windows/terminal/install),
or [MobaXTerm](https://mobaxterm.mobatek.net/) if you are not on Windows 11.

Connect to the device using this command, substituting `<ip-address>` with your
device's IP address:

```bash
ssh core@<ip-address>
```

When prompted, enter the default password for the `core` user: `umh`.

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

### I don't know which drive to select {#drive}

You can check the drive type from the manual of your device.

- For SATA drives (spinning hard disk or SSD), the drive type is `SDA`.
- For NVMe drives, the drive type is `NVMe`.

If you are unsure, you can boot into the edge device with any Linux distribution
and run the following command:

```bash
lsblk
```

The output should look similar to this:

```bash
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda      8:0    0 223.6G  0 disk
├─sda1   8:1    0   512M  0 part /boot
└─sda2   8:2    0 223.1G  0 part /
sdb      8:0    0  31.8G  0 disk
└─sdb1   8:1    0  31.8G  0 part /mnt/usb
```

In this case, the drive type is `SDA`. Generally, the drive type is the name of
the first drive in the list, or at least the drive that doesn't match the
size of the USB stick.

### I can access the cluster, but there are no resources

First, completely shut down {{< resource type="lens" name="name" >}} (from the
system tray). Then start it again and try to access the cluster.

If that doesn't work, access the edge device via SSH and run the following
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

If any of the commands return some errors, it is probably easier to reinstall the system.

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
