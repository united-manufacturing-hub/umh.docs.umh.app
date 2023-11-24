---
title: "Factoryinput Panel"
content_type: task
description: |
    This page contains the technical documentation of the plugin factoryinput-panel, which allows for easy execution of MQTT messages inside the UMH stack from a Grafana panel.
weight: 3000
aliases:
  - /docs/architecture/microservices/grafana-plugins/factoryinput-panel/
---

{{% notice warning %}}
This plugin is still in development and is not considered stable for production use
{{% /notice %}}


## Requirements

- A United Manufacturing Hub stack
- External IP or URL to the [grafana-proxy](/docs/architecture/microservices/community/grafana-proxy)
    - In most cases it is the same IP address as your Grafana dashboard.

## Getting started

For development, the steps to build the plugin from source are described here.

1. Go to `united-manufacturing-hub/grafana-plugins/umh-factoryinput-panel`
2. Install dependencies.
```bash
yarn install
```
3. Build plugin in development mode or run in watch mode.
```bash
yarn dev
```
4. Build plugin in production mode (not recommended due to [Issue 32336](https://github.com/grafana/grafana/issues/32336)).
```bash
yarn build
```
5. Move the resulting dis folder in your Grafana plugins directory.

- Windows: `C:\Program Files\GrafanaLabs\grafana\data\plugins`
- Linux: `/var/lib/grafana/plugins`

6. Rename the folder to umh-factoryinput-panel.

7. Enable the [enable development mode](https://grafana.com/docs/grafana/latest/administration/configuration/) to load unsigned plugins.

8. restart your Grafana service.

## Technical Information

Below you will find a schematic of this flow, through our stack.

