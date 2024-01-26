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

By default, we are using your DHCP configured DNS servers. If you are using static ip or want to use a different DNS server,
contact us for a custom configuration file.

## Bring your own containers

Our system tries to fetch all containers from our own registry (management.umh.app) first.
If this fails, it will try to fetch docker.io from `https://registry-1.docker.io`, ghcr.io from `https://ghcr.io` and quay.io from `https://quay.io` (and any other from `management.umh.app`)
If you need to use a different registry, edit the `/var/lib/rancher/k3s/agent/etc/containerd/config.toml.tmpl` to set your own mirror configuration.

## {{% heading "troubleshooting" %}}

### I'm having connectivity problems. What should I do?

First of all, double-check that your firewall rules are configured as described in this page, especially the step
involving our domain. As a quick test, you can use the following command from a different machine within the same
network to check if the rules are working:

```bash
curl -vvv https://management.umh.app
```

<!-- Add more troubleshooting steps? -->
