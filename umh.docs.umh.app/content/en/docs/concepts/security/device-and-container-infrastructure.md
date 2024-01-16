---
title: "Device & Container Infrastructure"
content_type: concept
description: |
    Concepts related to the security of the Device & Container Infrastructure.
weight: 10
draft: true
---

<!-- overview -->
The Device & Container Infrastructure security has two scopes: internet-facing
and internal. The internet-facing scope refers to all the communications between
the device and the public internet. The internal scope refers to all the
communications between the containers themselves and the device network.

<!-- body -->
## Internet-Facing

Everything that the instance needs to be installed, configured and managed is
downloaded from the internet. This can be a security risk, as the various binaries
and packages can be tampered with. To mitigate this risk, we host all the
components ourselves, so that they can all be accessed from a single domain.

This includes:

- Docker images
- Helm charts
- iPXE boot scripts
- Flatcar configuration
- Helm, kubectl and other binaries

## Internal

Since the container infrastructure leverages Kubernetes, the security of the
containers is handled by Kubernetes. You deep dive into it from the
[official documentation](https://kubernetes.io/docs/concepts/security/overview/),
but for a quick overview, you just need to know that all the containers are
isolated from the host system, and only some of them can be accessed from the
device network.
