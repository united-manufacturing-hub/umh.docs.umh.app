---
title: "Virtual Machine Installation"
content_type: task
description: |
    Additional requirements and considerations when installing the United Manufacturing Hub on a virtual machine.
weight: 40
---

<!-- overview -->

This guide provides specific requirements and best practices for installing the United Manufacturing Hub on a virtual machine (VM). These guidelines ensure optimal performance and connectivity when running UMH in a virtualized environment.

## {{% heading "prerequisites" %}}

Ensure you have:
- Access to a hypervisor (like VMware, VirtualBox, Proxmox, or Hyper-V)
- Sufficient host resources to allocate to the VM (refer to the [Installtion guide for requirements](/docs/getstarted/installation#requirements) section for more details)
- Network access for both the host and VM

## Storage Configuration

When setting up your virtual machine for UMH:

**Partition Layout**
   - The default Rocky Linux installation typically creates a large `/home` partition
   - During OS installation, you may use custom partitioning to ensure the root partition (`/`) has sufficient space (<span id="storage-requirements"></span>)


## Network Configuration

Proper network configuration is crucial for UMH functionality:

**Network Adapter Type**
   - Use a bridged network adapter
   - NAT or host-only adapters will prevent external connections to your instance
   - The VM must be able to:
     - Access the internet for installation and updates
     - Communicate with other devices on your network
     - Accept incoming connections from clients

## Virtual Hardware Recommendations

For optimal performance:

1. **CPU Configuration**
   - Enable CPU virtualization extensions (VT-x/AMD-V) on the host
   - Allocate physical CPU cores rather than virtual cores when possible
   - For production environments, reserve the CPU resources

2. **Memory Settings**
   - Use static memory allocation rather than dynamic/balloon drivers
   - Reserve the memory in the hypervisor to prevent memory swapping

3. **Other Settings**
   - Disable unnecessary virtual hardware (like sound cards, USB controllers)
   - Use paravirtualized drivers when available for better performance
