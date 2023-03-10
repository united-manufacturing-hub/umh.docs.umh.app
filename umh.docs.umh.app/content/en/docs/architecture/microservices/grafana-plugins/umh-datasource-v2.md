---
title: "Umh Datasource V2"
content_type: grafana-plugin
description: |
    This page contains the technical documentation of the umh-datasource-v2 plugin,
    which allows for easy data extraction from factoryinsight.
weight: 1000
---

<!-- overview -->

The plugin, **umh-datasource-v2**, is a Grafana data source plugin that allows you to fetch
resources from a database and build queries for your dashboard.

<!-- body -->

## {{% heading "howitworks" %}}

1. When creating a new panel, select **umh-datasource-v2** from the Data source drop-down menu. It will then fetch the resources
   from the database. The loading time may depend on your internet speed.

   ![selectingDatasource](/images/grafana-plugins/grafanaPluginsSelectingV2.png/?width=85%)

2. Select the resources in the cascade menu to build your query. **DefaultArea** and **DefaultProductionLine** are placeholders
   for the future implementation of the new data model.

   ![selectingDatasource](/images/grafana-plugins/grafanaPluginsSelectingWorkCell.png/?width=85%)

3. Only the available values for the specified work cell will be fetched from the database. You can then select which data value you want to query.

   ![selectingDatasource](/images/grafana-plugins/grafanaPluginsSelectingValue.png/?width=85%)

4. Next you can specify how to transform the data, depending on what value you selected.
   For example, all the custom tags will have the aggregation options available. For example if you query a **processValue**:
   - **Time bucket**: lets you group data in a time bucket
   - **Aggregates**: common statistical aggregations (maximum, minimum, sum or count)
   - **Handling missing values**: lets you choose how missing data should be handled

   ![selectingDatasource](/images/grafana-plugins/grafanaPluginsSelectingOptions.png/?width=85%)

## {{% heading "configuration" %}}

1. In Grafana, navigate to the Data sources configuration panel.

   ![selectingConfiguration](/images/grafana-plugins/grafanaPluginsConfigurationPanel.png/?width=15%)

2. Select **umh-v2-datasource** to configure it.

   ![selectingConfiguration](/images/grafana-plugins/grafanaPluginsSelectingConfiguration.png/?width=85%)

3. Configurations:
    - Base URL: the URL for the factoryinsight backend. Defaults to `http://united-manufacturing-hub-factoryinsight-service/`.
    - Enterprise name: previously **customerID** for the old datasource plugin. Defaults to **factoryinsight**.
    - API Key: authenticates the API calls to factoryinsight.
      Can be found with UMHLens by going to Secrets → factoryinsight-secret → apiKey. It should follow the format `Basic xxxxxxxx`.

   ![selectingConfiguration](/images/grafana-plugins/grafanaPluginsConfuguringDatasourceV2.png/?width=85%)

   {{</* resource type="grafanaplugin" name="baseurlfactoryinsight" */>}}