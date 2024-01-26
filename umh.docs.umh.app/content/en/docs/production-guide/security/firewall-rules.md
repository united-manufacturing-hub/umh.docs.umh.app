---
title: "Firewall Rules"
menuTitle: "Firewall Rules"
description: |
  This page describes how to setup firewall rules for the UMH instances.
content_type: task
weight: 50
---

<!-- overview -->

Some enterprise networks operate in a whitelist manner, where all outgoing and incoming communication
is blocked by default. However, the installation and maintenance of UMH requires internet access for
tasks such as downloading the operating system, Docker containers, monitoring via the Management Console,
and loading third-party plugins. As dependencies are hosted on various servers and may change based on
vendors' decisions, we've simplified the user experience by consolidating all mandatory services under a
single domain. Nevertheless, if you wish to install third-party components like Node-RED or Grafana plugins,
you'll need to whitelist additional domains.

## {{% heading "prerequisites" %}}

The only prerequisite is having a firewall that allows modification of rules. If you're unsure about this,
consider contacting your network administrator.

## Firewall Configuration

Once you're ready and ensured that you have the necessary permissions to configure the firewall, follow these steps:

### Whitelist management.umh.app

This mandatory step requires whitelisting `management.umh.app` on TCP port 443 (HTTPS traffic). Not doing so will
disrupt UMH functionality; installations, updates, and monitoring won't work as expected.

### Optional: Whitelist domains for common 3rd party plugins

Include these common external domains and ports in your firewall rules to allow installing Node-RED and Grafana plugins:

- registry.npmjs.org (required for installing Node-RED plugins)
- storage.googleapis.com (required for installing Grafana plugins)
- grafana.com (required for displaying Grafana plugins)
- catalogue.nodered.org (required for displaying Node-RED plugins, only relevant for the client that is using Node-RED, not
  the server where it's installed on).

Depending on your setup, additional domains may need to be whitelisted.

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
