---
title: "Firewall Rules"
menuTitle: "Firewall Rules"
description: |
  This page describes how to setup firewall rules for the UMH instances.
content_type: task
weight: 50
---

<!-- overview -->

To guarantee the security and seamless operation of your UMH instances, proper firewall rules must be configured.

## {{% heading "prerequisites" %}}

Before proceeding with the firewall setup, it's worth discussing why they matter in the first place.

As you may or may not know, the UMH consists of several open-source components, and the usage of these might require
various rules for their proper operation. Considering the complexity involved in setting up and maintaining these
rules, we have hosted as much as possible under our own domain (management.umh.app). This way, the setup is much
simpler and less error-prone on your end.

However, it's important to note that, despite our efforts to minimize external requests, some of the components may
require occasional communication to their respective services. For example, installing plugins for applications like
Grafana or Node-RED will likely involve requests to their respective domains. In such cases, this page provides a
comprehensive list of external domains and ports that are relevant during the usage of the UMH, helping you to
anticipate and configure the rules accordingly.

## Firewall Configuration

Once you're ready and ensured that you have the necessary permissions to configure the firewall, follow these steps:

### Whitelist Our Domain

The first and most important step simply involves allowing access to our domain (management.umh.app) on the following ports:

- TCP port 80: HTTP traffic
- TCP port 443: HTTPS traffic

Ignoring this step or even worse, blocking access to our domain and corresponding ports, will result in a malfunctioning
UMH instance.

### Whitelist External Domains

This step lists the external domains and ports that are common while working with the UMH. Keep in mind that
this list is not exhaustive, and you may need to add additional rules depending on your specific use case.

- TODO: Add list of external domains and ports

## {{% heading "troubleshooting" %}}

### I'm having connectivity problems. What should I do?

First of all, double-check that your firewall rules are configured as described in this page, especially the step
involving our domain. As a quick test, you can use the following command from a different machine within the same
network to check if the rules are working:

```bash
curl -vvv https://management.umh.app
```

<!-- Add more troubleshooting steps? -->
