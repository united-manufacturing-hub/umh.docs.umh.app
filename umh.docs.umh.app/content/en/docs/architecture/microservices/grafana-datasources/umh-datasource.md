+++
title = "umh-datasource"
menuTitle = "umh-datasource"
chapter = false
weight = 5
draft = false
description = "The technical documentation of the microservice umh-datasource, which allows for easy data extraction from factoryinsight."
+++

UMH Datasource provides a Grafana 8.X compatible plugin, allowing easy data extraction from the UMH factoryinsight microservice.

## Get started

For development, the steps to build the plugin from source are described here. 

1. Clone the datasource repository `git@github.com:united-manufacturing-hub/united-manufacturing-hub-datasource.git`

2. Install dependencies

```bash
yarn install
```

3. Build plugin in development mode or run in watch mode

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

6. Rename the folder to umh-datasource.

7. Enable the [enable development mode](https://grafana.com/docs/grafana/latest/administration/configuration/) to load unsigned plugins.

8. restart your Grafana service.

