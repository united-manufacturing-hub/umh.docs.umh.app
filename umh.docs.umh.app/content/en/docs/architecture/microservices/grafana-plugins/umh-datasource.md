---
title: "Umh Datasource"
content_type: grafana-plugin
description: |
    This page contains the technical documentation of the plugin umh-datasource, which allows for easy data extraction from factoryinsight.
weight: 2000
---

<!-- overview -->

{{% notice warning %}}
We are no longer maintaining this plugin. Instead, use our new plugin datasource-v2 for data extraction from factoryinsight.
{{% /notice %}}

The **umh datasource** is a Grafana 8.X compatible plugin, that allows you to fetch resources from a database
and build queries for your dashboard.

<!-- body -->

## {{% heading "howitworks" %}}

1. When creating a new panel, select **umh-datasource** from the Data source drop-down menu. It will then fetch the resources
   from the database. The loading time may depend on your internet speed.

   ![selectingDatasource](/images/grafana-plugins/grafanaPluginsSelectingV1.png/?width=85%)

2. Select your query parameters **Location**, **Asset** and **Value** to build your query.

   ![selectingDatasource](/images/grafana-plugins/grafanaPluginsSelectingValuesV1.png/?width=85%)

## {{% heading "configuration" %}}

1. In Grafana, navigate to the Data sources configuration panel.

   ![selectingConfiguration](/images/grafana-plugins/grafanaPluginsConfigurationPanel.png/?width=15%)

2. Select **umh-datasource** to configure it.

   ![selectingConfiguration](/images/grafana-plugins/grafanaPluginsSelectingConfiguration.png/?width=85%)
3. Configurations:
    - Base URL: the URL for the factoryinsight backend. Defaults to `http://{{< resource type="service" name="factoryinsight" >}}/`.
    - Enterprise name: previously **customerID** for the old datasource plugin. Defaults to **factoryinsight**.
    - API Key: authenticates the API calls to factoryinsight.
      Can be found with UMHLens by going to Secrets → {{< resource type="secret" name="factoryinsight" >}} → apiKey. It should follow the format `Basic xxxxxxxx`.

   ![selectingConfiguration](/images/grafana-plugins/grafanaPluginsConfiguringDatasourceV1.png/?width=85%)
