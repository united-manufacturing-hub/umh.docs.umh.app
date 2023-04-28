---
title: "Umh Datasource V2"
content_type: grafana-plugin
description: |
    This page contains the technical documentation of the  Grafana umh-datasource-v2 plugin,
    which allows for easy data extraction from factoryinsight.
weight: 1000
---

<!-- overview -->

The plugin, **umh-datasource-v2**, is a Grafana data source plugin that allows you to fetch
resources from a database and build queries for your dashboard.

<!-- body -->

## {{% heading "howitworks" %}}

1. When creating a new panel, select umh-datasource-v2 from the Data source drop-down menu. It will then fetch the 
   resources
   from the database. The loading time may depend on your internet speed.

   ![selectingDatasource](/images/grafana-plugins/grafanaPluginsSelectingV2.png?width=80%)

2. Select the resources in the cascade menu to build your query. **DefaultArea** and **DefaultProductionLine** are 
   placeholders
   for the future implementation of the new data model.

   ![selectingDatasource](/images/grafana-plugins/grafanaPluginsSelectingWorkCell.png?width=80%)

3. Only the available values for the specified work cell will be fetched from the database. You can then select which 
   data value you want to query.

   ![selectingDatasource](/images/grafana-plugins/grafanaPluginsSelectingValue.png?width=80%)

4. Next you can specify how to transform the data, depending on what value you selected.

   For *processValue*:

      - Time bucket: allows you to aggregate data into buckets of time. Read more on the [timescale documentation](https://docs.timescale.com/api/latest/hyperfunctions/time_bucket/)
      - Aggregates: allows you to choose between different aggregate functions like Average, Maximum, Minimum, Sum and 
        Count. Read more on the [timescale documentation](https://docs.timescale.com/api/latest/hyperfunctions/statistical-and-regression-analysis/stats_agg-one-variable/)
      - Handling missing values: allows you to configure how to handle missing values. Read more on the [timescale documentation](https://docs.timescale.com/api/latest/hyperfunctions/gapfilling/time_bucket_gapfill/)
      - Include last datapoint before time interval
      - Include next datapoint after time interval
   
   For *state*:

      - Keep state integer: if enabled, instead of showing the string representation of the state, it shows its 
        integer value. e.g. instead of "No shifts", returns 160000.

   For *tables*:

      - Include running processes
      - Keep states works the same way as Keep state integer, but only for availability tables, like 
        availabilityHistogram and availabilityTotal.


   ![selectingDatasource](/images/grafana-plugins/grafanaPluginsSelectingOptions.png?width=80%)

## {{% heading "configuration" %}}

1. In Grafana, navigate to the Data sources configuration panel.

   ![selectingConfiguration](/images/grafana-plugins/grafanaPluginsConfigurationPanel.png?width=15%)

2. Select **umh-v2-datasource** to configure it.

   ![selectingConfiguration](/images/grafana-plugins/grafanaPluginsSelectingConfiguration.png?width=80%)

3. Configurations:
    - Base URL: the URL for the factoryinsight backend. Defaults to `http://{{< resource type="service" name="factoryinsight" >}}/`.
    - Enterprise name: previously **customerID** for the old datasource plugin. Defaults to **factoryinsight**.
    - API Key: authenticates the API calls to factoryinsight.
      Can be found with UMHLens by going to Secrets → {{< resource type="secret" name="factoryinsight" >}} → apiKey. 
      It should follow the format `Basic xxxxxxxx`.

   ![selectingConfiguration](/images/grafana-plugins/grafanaPluginsConfuguringDatasourceV2.png?width=80%)
