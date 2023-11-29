---
title: "Device & Container Infrastructure"
menuTitle: "Device & Container Infrastructure"
description: |
  Understand the automated deployment and setup process in UMH's Device &
  Container Infrastructure.
weight: 2000
---
The Device & Container Infrastructure in the United Manufacturing Hub automates
the deployment and setup of the data infrastructure in various environments. It
is tailored for Edge deployments, particularly in Demilitarized Zones, to minimize
latency on-premise, and also extends into the Cloud to harness its functionalities.
It consists of several interconnected components:

- **Provisioning Server**: Manages the initial bootstrapping of devices,
  including iPXE configuration and ignition file distribution.
- **[Flatcar Image Server](https://www.flatcar.org/)**: A central repository hosting various versions of
  Flatcar Container Linux images, ensuring easy access and version control.
- **[Customized iPXE](https://ipxe.org/)**: A specialized bootloader configured to streamline the
  initial boot process by fetching UMH-specific settings and configurations.
- **First and Second Stage Flatcar OS**: A two-stage operating system setup where
  the first stage is a temporary OS used for installing the second stage, which
  is the final operating system equipped with specific configurations and tools.
- **Installation Script**: An automated script hosted at management.umh.app,
  responsible for setting up and configuring the Kubernetes environment.
- **Kubernetes ([k3s](https://k3s.io/))**: A lightweight Kubernetes setup that forms the backbone
  of the container orchestration system.

This infrastructure ensures a streamlined, automated installation process, laying
a robust foundation for the United Manufacturing Hub's operation.

{{< mermaid theme="neutral" >}}
graph LR
  16["`**Management Console**
  Configures, manages, and monitors Data and Device & Container Infrastructures in the UMH Integrated Platform`"]
  style 16 fill:#aaaaaa,stroke:#47a0b5,color:#000000
  29["`**Provisioning Server**
  Handles device bootstrapping, including iPXE configuration and ignition file distribution.`"]
  style 29 fill:#aaaaaa,stroke:#47a0b5,color:#000000
  30["`**Flatcar Image Server**
  Hosts Flatcar Container Linux images, providing a central repository for version management.`"]
  style 30 fill:#aaaaaa,stroke:#47a0b5,color:#000000

  subgraph 27 [Device & Container Infrastructure]
    style 27 fill:#ffffff,stroke:#47a0b5,color:#47a0b5

    28["`**Installation Script**
    This script automates the Kubernetes environment setup and configuration.`"]
    style 28 fill:#aaaaaa,stroke:#47a0b5,color:#000000
    31["`**Kubernetes**
    Core of the container orchestration system, featuring a lightweight Kubernetes setup.`"]
    style 31 fill:#aaaaaa,stroke:#47a0b5,color:#000000
    32["`**Customized iPXE**
    Configured bootloader for fetching UMH-specific settings, optimizing the initial boot process.`"]
    style 32 fill:#aaaaaa,stroke:#47a0b5,color:#000000
    33["`**First Stage Flatcar OS**
    Transitional OS used during the installation of the permanent Flatcar OS.`"]
    style 33 fill:#aaaaaa,stroke:#47a0b5,color:#000000
    34["`**Second Stage Flatcar OS**
    Final operating system, equipped with specific configurations and essential tools.`"]
    style 34 fill:#aaaaaa,stroke:#47a0b5,color:#000000
  end

  32-. "Downloads specified
  Flatcar version for
  initial boot." .->30
  33-. "Retrieves image for
  second-stage Flatcar OS." .->30
  34-. "Regularly checks for
  OS updates." .->30
  32-. "Initiates boot-up of
  first-stage OS." .->33
  32-. "Requests configuration and
  retrieves iPXE config." .->29
  33-. "Installs second-stage
  Flatcar OS." .->34
  33-. "Fetches ignition config with
  installation script." .->29
  34-. "Executes installation script." .->28
  34-. "Acquires token-specific
  ignition config." .->29
  28-. "Installs Kubernetes (k3s) and
  required tools, then deploys
  the Data Infrastructure." .->31
  28-. "Deploys Management
  Companion into Kubernetes." .->16
{{< /mermaid >}}
