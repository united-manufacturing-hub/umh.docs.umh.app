---
title: Historian / Data Storage
menuTitle: Historian / Data Storage
description: Learn how the United Manufacturing Hub's Historian feature provides reliable data storage and analysis for your manufacturing data.
weight: 2000
aliases:
  - /docs/features/historian
---

The Historian / Data Storage feature in the United Manufacturing Hub provides reliable data storage and analysis for your manufacturing data. Essentially, a Historian is just another term for a data storage system, designed specifically for time-series data in manufacturing.

## When should I use it?

If you want to reliably store data from your shop floor that is not designed to fulfill any legal purposes, such as GxP, then the United Manufacturing Hub's Historian feature is ideal. Open-Source databases such as TimescaleDB [are superior to traditional historians](https://learn.umh.app/blog/historians-vs-open-source-databases-which-is-better/) in terms of [reliability, scalability and maintainability](https://learn.umh.app/blog/comparing-mqtt-brokers-for-the-industrial-iot/#three-main-requirements-for-your-it-ot-architecture), but can be challenging to use for the OT engineer. The United Manufacturing Hub fills this usability gap, allowing OT engineers to easily ingest, process, and store data permanently in an Open-Source database.

## What can I do with it?

The Historian / Data Storage feature of the United Manufacturing Hub allows you to:

### Store and analyze data

- Store data from the topics with the basic format `.../_historian` or `.../_historian/<tagGroup1>/<tagGroup2>/.../<tagGroupX>/<tagname>` in the Unified Namespace. [Data can be sent to the Unified Namespace from various sources](/docs/features/datainfrastructure/unified-namespace/), allowing you to store tags from your PLC and production lines reliably. Optionally, you can use tag groups to manage a large number of tags and reduce the system load. [This article](https://learn.umh.app/lesson/data-modeling-in-the-unified-namespace-mqtt-kafka/) helps you learn data modeling in the Unified Namespace.
- Conduct basic data analysis, including automatic downsampling, gap filling, and statistical functions such as Min, Max, and Avg.

### Query and visualize data

- Query data in an ISA95 model, from enterprise to site, area, production line, and work cell.
- Visualize your data in Grafana to easily monitor and troubleshoot your production processes.

{{% notice tip %}}
More information about the exact analytics functionalities can be found in the [umh-datasource-v2 documentation](/docs/architecture/data-infrastructure/historian/umh-datasource-v2/). Further below some screenshots of said datasource.
{{% /notice %}}

![](/images/grafana-plugins/grafanaPluginsSelectingWorkCell.png?width=50%)
![](/images/grafana-plugins/grafanaPluginsSelectingValue.png?width=50%)
![](/images/grafana-plugins/grafanaPluginsSelectingOptions.png?width=50%)

### Efficiently manage data

- Compress and retain data to reduce database size using various techniques.

## How can I use it?

Transform your data in the Unified Namespace datamodel with the basic topic format `.../_historian` or `.../_historian/<tagGroup1>/<tagGroup2>/.../<tagGroupX>/<tagname>`, for example, using Node-RED, and the Historian feature will store them. You can then view the data in Grafana. An example can be found in the [Getting Started guide](/docs/getstarted/).

Extensive queries can be done by SQL queries. Hier, you see an example query:

```sql
SELECT name, value, timestamp
FROM tag
WHERE asset_id = get_asset_id(
  'pharma-genix',
  'aachen',
  'packaging',
  'packaging_1',
  'blister'
);
```
`get_asset_id` is a custom plpgsql function that we provide to simplify the process of querying tag data from a specific `asset`. 


Also, you have the option to query data in your custom code by utilizing the API in [factoryinsight](/docs/reference/microservices/factoryinsight/) or processing the data in the [Unified Namespace](/docs/features/datainfrastructure/unified-namespace/).

For more information about what exactly is behind the Historian feature, check out our [our architecture page](/docs/architecture/)

## What are the limitations?

- Transforming data is necessary to store messages. Data in topics like `ia/raw` will be not stored. Therefore, you should define the corresponding topic for formatting data.
- After storing a couple of millions messages, you should consider [compressing the messages or establishing retention policies](/docs/production-guide/administration/reduce-database-size/).

Apart from these limitations, the United Manufacturing Hub's Historian feature is highly performant compared to legacy Historians.

## Where to get more information?

- Learn more about the benefits of using open-source databases in our blog article, [Historians vs Open-Source databases - which is better?](https://learn.umh.app/blog/historians-vs-open-source-databases-which-is-better/)
- Check out the [Getting Started guide](/docs/getstarted/) to start using the Historian feature.
- Learn more about the United Manufacturing Hub's architecture by visiting [our architecture page](/docs/architecture/).
- Learn more about Data Modeling in the Unified Namespace by visiting [our guide](https://learn.umh.app/lesson/data-modeling-in-the-unified-namespace-mqtt-kafka/).
