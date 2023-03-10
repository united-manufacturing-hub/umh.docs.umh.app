+++
title = "Historian / Data Storage"
menuTitle = "Historian / Data Storage"
description = "Learn how the United Manufacturing Hub's Historian feature provides reliable data storage and analysis for your manufacturing data."
weight = 2
+++

The Historian / Data Storage feature in the United Manufacturing Hub provides reliable data storage and analysis for your manufacturing data. Essentially, a Historian is just another term for a data storage system, designed specifically for time-series data in manufacturing.

## When should I use it?

If you want to reliably store data from your shop floor that is not designed to fulfill any legal purposes, such as GxP, then the United Manufacturing Hub's Historian feature is ideal. Open-Source databases such as TimescaleDB [are superior to traditional historians](https://learn.umh.app/blog/historians-vs-open-source-databases-which-is-better/) in terms of [reliability, scalability and maintainability](https://learn.umh.app/blog/comparing-mqtt-brokers-for-the-industrial-iot/#three-main-requirements-for-your-it-ot-architecture), but can be challenging to use for the OT engineer. The United Manufacturing Hub fills this usability gap, allowing OT engineers to easily ingest, process, and store data permanently in an Open-Source database.

## What can I do with it?

The Historian / Data Storage feature of the United Manufacturing Hub allows you to:

### Store and analyze data
- Automatically store data from the `processValue` topics in the Unified Namespace. [Data can be sent to the Unified Namespace from various sources](/docs/features/unified-namespace/), allowing you to store tags from your PLC and production lines reliably.
- Conduct basic data analysis, including automatic downsampling, gap filling, and statistical functions such as Min, Max, and Avg

### Query and visualize data
- Query data in an ISA95 model, from enterprise to site, area, production line, and work cell.
- Visualize your data in Grafana to easily monitor and troubleshoot your production processes.


{{% notice tip %}}
More information about the exact analytics functionalities can be found in the [umh-datasource-v2 documentation](/docs/architecture/microservices/grafana-plugins/umh-datasource-v2/). Further below some screenshots of said datasource.
{{% /notice %}}

![](/images/grafana-plugins/grafanaPluginsSelectingWorkCell.png?width=50%)
![](/images/grafana-plugins/grafanaPluginsSelectingValue.png?width=50%)
![](/images/grafana-plugins/grafanaPluginsSelectingOptions.png?width=50%)
### Efficiently manage data
- Compress and retain data to reduce database size using various techniques.

## How can I use it?

Convert your data in your Unified Namespace to [processValue](/docs/architecture/datamodel/messages/processvalue/) messages, and the Historian feature will store them automatically. You can then view the data in Grafana. An example can be found in the [Getting Started guide](/docs/getstarted/).

For more information about what exactly is behind the Historian feature, check out our [our architecture page](/docs/architecture/)

## What are the limitations?

- Only data in `processValue` topics are saved automatically. Data in topics like `ia/raw` are not. Data send to other messages in the [UMH datamodel](/docs/architecture/datamodel/) are stored slightly different and can be retrieved via Grafana as well. See also [Analytics feature](/docs/features/analytics/).
- After storing a couple of millions messages, you should consider [compressing the messages or establishing retention policies](/docs/production-guide/administration/reduce-database-size/).
- At the moment, extensive queries can only be done in your own code by leveraging the API in [factoryinsight](/docs/architecture/microservices/core/factoryinsight/), or processing the data in the [Unified Namespace](/docs/features/unified-namespace/).

Apart from these limitations, the United Manufacturing Hub's Historian feature is highly performant compared to legacy Historians.

## Where to get more information?
- Learn more about the benefits of using open-source databases in our blog article, [Historians vs Open-Source databases - which is better?](https://learn.umh.app/blog/historians-vs-open-source-databases-which-is-better/)
- Check out the [Getting Started guide](/docs/getstarted/) to start using the Historian feature.
- Learn more about the United Manufacturing Hub's architecture by visiting [our architecture page](/docs/architecture/).
