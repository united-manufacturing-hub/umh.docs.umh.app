---
title: "Firewall Rules"
menuTitle: "Firewall Rules"
description: |
  This page describes how to setup firewall rules for the UMH instances.
content_type: task
weight: 50
---

<!-- overview -->

For closed enterprise networks with specific permissions, this page outlines firewall rule configuration
to ensure the security and seamless operation of your UMH instances.

## {{% heading "prerequisites" %}}

Before configuring the firewall, let's discuss some key points.

The usage of the components integrated into the UMH require various rules for their proper operation.
Considering the complexity involved in setting up and maintaining these rules, we have hosted as much
as possible under our own domain (management.umh.app), which leads to a simpler and less error-prone
setup.

However, it's important to note that, some components may require occasional communication to external
services. For example, installing plugins for applications like Grafana or Node-RED will likely trigger
requests to their respective domains. In such cases, this page provides a comprehensive list of external
domains and ports that are relevant during the usage of the UMH, helping you to anticipate and configure
the rules accordingly.

## Firewall Configuration

Once you're ready and ensured that you have the necessary permissions to configure the firewall, follow these steps:

### Whitelist Our Domain

The first and most important step simply involves allowing access to our domain (management.umh.app) on the following port:

- TCP port 443: HTTPS traffic

Ignoring this step or even worse, blocking access to our domain and corresponding port, will result in a malfunctioning
UMH instance.

### Whitelist External Domains

This step lists the external domains and ports that are common while working with the UMH. Keep in mind that
this list is not exhaustive, and you may need to add additional rules depending on your specific use case.

- registry.npmjs.org
- storage.googleapis.com
- grafana.com

## DNS Configuration (Optional)

By default, we make use of the following DNS servers:

- 1.1.1.1
- 1.0.0.1 (fallback)

Ensure that these DNS servers are accessible and not blocked by your enterprise network. Additionally, check for any
custom DNS servers configured on your machine. If these are blocked, it may restrict the functionality of your UMH instances.

## {{% heading "troubleshooting" %}}

### I'm having connectivity problems. What should I do?

First of all, double-check that your firewall rules are configured as described in this page, especially the step
involving our domain. As a quick test, you can use the following command from a different machine within the same
network to check if the rules are working:

```bash
curl -vvv https://management.umh.app
```

<!-- Add more troubleshooting steps? -->
