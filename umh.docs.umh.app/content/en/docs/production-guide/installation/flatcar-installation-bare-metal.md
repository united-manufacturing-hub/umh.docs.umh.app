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

## {{% heading "prerequisites" %}}

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

![Flatcar Install Step 0](/images/production-guide/flatcar-installation/flatcar9.png?width=75%)

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

### The Installation Stops at the First Green Login Prompt

If the installation halts at the first green login prompt, check the installation
status with:

```bash
systemctl status installer
```

A typical response for an ongoing installation will look like this:

```bash
● installer.service - Flatcar Linux Installer
     Loaded: loaded (/usr/lib/systemd/system/installer.service; static; vendor preset: enabled)
     Active: active (running) since Wed 2021-05-12 14:00:00 UTC; 1min 30s ago
```

If the status differs, the installation may have failed. Review the logs to
identify the issue.

### Unsure Which Drive to Select {#drive}

To determine the correct drive, refer to your device's manual:

- SATA drives (HDD or SSD): Typically labeled as `sda`.
- NVMe drives: Usually labeled as `nvm0n1`.

For further verification, boot any Linux distribution on your device and execute:

```bash
lsblk
```

The output, resembling the following, will help identify the drive:

```bash
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda      8:0    0 223.6G  0 disk
├─sda1   8:1    0   512M  0 part /boot
└─sda2   8:2    0 223.1G  0 part /
sdb      8:0    0  31.8G  0 disk
└─sdb1   8:1    0  31.8G  0 part /mnt/usb
```

In most cases, the correct drive is the first listed or the one not matching the
USB stick size.

### No Resources in the Cluster

If you can access the cluster but see no resources, SSH into the edge device and
check the cluster status:

```bash
systemctl status k3s
```

If the status is not `active (running)`, the cluster isn't operational. Restart it with:

```bash
sudo systemctl restart k3s
```

If the cluster is active or restarting doesn't resolve the issue, inspect the
installation logs:

```bash
systemctl status umh-install
systemctl status helm-install
```

Persistent errors may necessitate a system reinstallation.

### I can't SSH into the virtual machine

Ensure that your computer is on the same network as the virtual machine, with no
firewalls or VPNs blocking the connection.

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- You can follow the [Getting Started](https://learn.umh.app/getstarted) guide
  to get familiar with the UMH stack.
- If you already know your way around the United Manufacturing Hub, you can
  follow the [Administration guides](/docs/production-guide/administration/) to
  configure the stack for production.
