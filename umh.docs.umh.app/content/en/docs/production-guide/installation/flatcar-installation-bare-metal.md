---
title: "Flatcar Installation (Bare Metal)"
content_type: task
description: |
    This page describes how to deploy the United Manufacturing Hub on Flatcar
    Linux on bare metal.
weight: 50
aliases:
   - /docs/production-guide/installation/installation-guide-flatcar/
---

<!-- overview -->

Here is a step-by-step guide on how to deploy the UMH stack on
[Flatcar Linux](https://www.flatcar.org/), a Linux distribution designed for
container workloads, with high security and low maintenance.

This is a good option if you want to deploy the UMH stack on edge devices or IPCs.

## {{% heading "prerequisites" %}}

{{< include "task-befinst-prereqs.md" >}}

You need the latest version of our iPXE boot image:

- [ipxe-x86_64-efi](https://github.com/united-manufacturing-hub/ipxe/releases/latest/download/ipxe-x86_64-efi.usb):
  for reasonably modern systems.
- [ipxe-x86_64-bios](https://github.com/united-manufacturing-hub/ipxe/releases/latest/download/ipxe-x86_64-bios.usb):
  for older systems.
- [ipxe-arm64-efi](https://github.com/united-manufacturing-hub/ipxe/releases/latest/download/ipxe-arm64-efi.usb):
  for ARM systems. Currently, Raspberry Pi 4 is **not** supported.

The image needs to be written to a USB stick. If you want to know how to do this,
follow our
[guide on how to flash an operating system onto a USB-stick](https://learn.umh.app/course/flashing-an-operating-system-onto-a-usb-stick/).

You also need a computer with an SSH client (most modern operating systems
already have it) and either [UMHLens](https://github.com/united-manufacturing-hub/UMHLens)
or [OpenLens](https://github.com/MuhammedKalkan/OpenLens) installed.

Additionally, this guide assumes a configuration similar to the following:

{{< mermaid theme="neutral" >}}
%%{ init: { 'flowchart': { 'curve': 'bumpY' } } }%%
flowchart LR
    A(Internet) -. WAN .- B[Router]
    subgraph Internal network
        B -- LAN --- C[Edge device]
        B -- LAN --- D[Your computer]
    end
{{< /mermaid >}}

{{< notice info >}}
For optimal functionality, we recommend assigning a static IP address to your
edge device. This can be accomplished through a static lease in the DHCP server
or by setting the IP address during installation. Changing the IP address of the
edge device after installation may result in certificate issues, so we strongly
advise against doing so. By assigning a static IP address, you can ensure a more
stable and reliable connection for your edge device.
{{< /notice >}}

<!-- steps -->

## Install Flatcar Linux on the edge device

1. Connect the USB stick to the edge device and boot it. Each device has a
   different way of booting from USB, so you need to consult the documentation
   of your device.
2. Accept the License.
3. Select the correct network settings. If you are unsure, select DHCP, but
   keep in mind that a static IP address is strongly recommended.
4. Select the correct drive to install Flatcar Linux on. If you are unsure, check
   the [troubleshooting section](#drive).
5. Check that the installation settings are correct and press `Confirm` to start
   the installation.

Now the installation will start. You should see a green command line soon after,
that says `core@flatcar-0-install ~$~`. Now remove the USB stick from the
device. At this point the system is still installing. After a few minutes,
depending on the speed of your network, the installation will finish and the
system will reboot. Now you should see a grey login prompt that says
`flatcar-1-umh login:`, as well as the IP address of the device.

{{% notice note %}}
Please note that the installation may take some time. This largely depends on the available resources
including network speed and system performance.
{{% /notice %}}

## Connect to the edge device

Now you can leave the edge device and connect to it from your computer via SSH.

If you are on Windows 11, we recommend using the default [Windows terminal](https://learn.microsoft.com/en-us/windows/terminal/install),
that you can find by typing terminal in the Windows search bar or Start menu. Next,
connect to the edge device via SSH, using the IP address you saw on the login prompt:

```bash
ssh core@<ip-address>
```

If you are not on Windows 11, you can use [MobaXTerm](https://mobaxterm.mobatek.net/)
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

### I can access the cluster but there are no resources

First completely shut down {{< resource type="lens" name="name" >}} (from the
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

If any of the commands returns some errors, is probably easier to reinstall the
system.

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- You can follow the [Getting Started](https://learn.umh.app/getstarted) guide
  to get familiar with the UMH stack.
- If you already know your way around the United Manufacturing Hub, you can
  follow the [Administration guides](/docs/production-guide/administration/) to
  configure the stack for production.
