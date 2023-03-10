---
title: "umh-datasource"
content_type: task
description: |
   The technical documentation of the microservice umh-datasource, which allows for easy data extraction from factoryinsight.
weight: 2000
---

UMH Datasource provides a Grafana 8.X compatible plugin, allowing easy data extraction from the UMH factoryinsight microservice.

{{% notice note %}}
We are no longer maintaining this microservice. Use instead our new microservice datasource-v2 for data extraction from factoryinsight.
{{% /notice %}}


## Get started

The **UMH Datasource** comes preinstalled with the United Manufacturing Hub.

## Usage

1. When creating a new panel, select **umh-datasource** from the Data source drop-down menu. It will then fetch the resources
   from the database. The loading time may depend on your internet speed.

   ![selectingDatasource](/images/grafana-plugins/grafanaPluginsSelectingV1.png/?width=85%)

2. Select your query parameters **Location**, **Asset** and **Value** to build your query.

   ![selectingDatasource](/images/grafana-plugins/grafanaPluginsSelectingValuesV1.png/?width=85%)


## Configuration

1. In Grafana, navigate to the Data sources configuration panel.

   ![selectingConfiguration](/images/grafana-plugins/grafanaPluginsConfigurationPanel.png/?width=15%)

2. Select **umh-datasource** to configure it.

   ![selectingConfiguration](/images/grafana-plugins/grafanaPluginsSelectingConfiguration.png/?width=85%)
3. Configurations: 
   - Base URL: the URL for the factoryinsight backend. Defaults to `http://united-manufacturing-hub-factoryinsight-service/`.
   - Enterprise name: previously **customerID** for the old datasource plugin. Defaults to **factoryinsight**.
   - API Key: authenticates the API calls to factoryinsight.
   Can be found with UMHLens by going to Secrets → factoryinsight-secret → apiKey. It should follow the format `Basic xxxxxxxx`.

   ![selectingConfiguration](/images/grafana-plugins/grafanaPluginsConfiguringDatasourceV1.png/?width=85%)
