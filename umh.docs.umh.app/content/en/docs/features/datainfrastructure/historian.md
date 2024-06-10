---
title: Historian / Data Storage
menuTitle: Historian / Data Storage
description: Learn how the United Manufacturing Hub's Historian feature provides reliable data storage and analysis for your manufacturing data.
weight: 2000
edition: community
aliases:
  - /docs/features/historian
---

The Historian / Data Storage feature in the United Manufacturing Hub provides
reliable data storage and analysis for your manufacturing data. Essentially, a
Historian is just another term for a data storage system, designed specifically
for time-series data in manufacturing.

## When should I use it?

If you want to reliably store data from your shop floor that is not designed to
fulfill any legal purposes, such as GxP, we recommend you to use the United Manufacturing Hub's
Historian feature. In our opinion, open-source databases such as TimescaleDB are
[superior to traditional historians](https://learn.umh.app/blog/historians-vs-open-source-databases-which-is-better/)
in terms of [reliability, scalability and maintainability](https://learn.umh.app/blog/comparing-mqtt-brokers-for-the-industrial-iot/#three-main-requirements-for-your-it-ot-architecture),
but can be challenging to use for the OT engineer. The United Manufacturing Hub
fills this usability gap, allowing OT engineers to easily ingest, process, and
store data permanently in an open-source database.

## What can I do with it?

The Historian / Data Storage feature of the United Manufacturing Hub allows you
to:

### Store and analyze data

- Store data in TimescaleDB by using either the
  [`_historian`](https://umh.docs.umh.app/docs/datamodel/messages/_historian/)
  or `_analytics` [`_schemas`](https://umh.docs.umh.app/docs/datamodel/messages/#_schema)
  in the topics within the Unified Namespace.
- Data can be sent to the [Unified Namespace](/docs/features/datainfrastructure/unified-namespace/)
  from various [sources](https://umh.docs.umh.app/docs/features/connectivity/),
  allowing you to store tags from your PLC and production lines reliably.
  Optionally, you can use tag groups to manage a large number of
  tags and reduce the system load.
  [Our Data Model page](https://1313-unitedmanuf-umhdocsumha-x5cxrqwuhgf.ws-eu107.gitpod.io/docs/datamodel/)
  assists you in learning data modeling in the Unified Namespace.
- Conduct basic data analysis, including automatic downsampling, gap filling,
  and statistical functions such as Min, Max, and Avg.

### Query and visualize data

- Query data in an ISA95 compliant model,
  from enterprise to site, area, production line, and work cell.
- Visualize your data in Grafana to easily monitor and troubleshoot your
  production processes.

{{% notice tip %}}
More information about the exact analytics functionalities can be found in the
[umh-datasource-v2 documentation](/docs/architecture/data-infrastructure/historian/umh-datasource-v2/).
{{% /notice %}}

### Efficiently manage data

- Compress and retain data to reduce database size using various techniques.

## How can I use it?

To store your data in TimescaleDB, simply use the `_historian` or `_analytics`
`_schemas` in your [Data Model v1](https://umh.docs.umh.app/docs/datamodel/messages/)
compliant topic. This can be directly done in the OPC UA data source
when the data is first inserted into the stack. Alternatively, it can be handled
in Node-RED, which is useful if you're still utilizing the old data model,
or if you're gathering data from non-OPC UA sources via Node-RED or
sensorconnect.

Data sent with a different `_schema` will not be stored in
TimescaleDB.

Data stored in TimescaleDB can be viewed in Grafana. An example can be found in
the [Get Started guide](/docs/getstarted/).

In Grafana you can select tags by using SQL queries. Here, you see an example:

```sql
SELECT name, value, timestamp
FROM tag
WHERE asset_id = get_asset_id_immutable(
  'pharma-genix',
  'aachen',
  'packaging',
  'packaging_1',
  'blister'
);
```

`get_asset_id_immutable` is a custom plpgsql function that we provide to simplify the
process of querying tag data from a specific `asset`. To learn more about our
database, visit [this page](/docs/datamodel/database/).

Also, you have the option to query data in your custom code by utilizing the
API in [factoryinsight](/docs/reference/microservices/factoryinsight/) or
processing the data in the
[Unified Namespace](/docs/features/datainfrastructure/unified-namespace/).

For more information about what exactly is behind the Historian feature, check
out our [our architecture page](/docs/architecture/).

## What are the limitations?

- In order to store messages, you should transform data and use our topic
  structure. The payload must be in JSON using
  [a specific format](/docs/datamodel/messages/_historian/#message-structure),
and the message must be tagged with `_historian`.
- After storing a couple of millions messages, you should consider
  [compressing the messages or establishing retention policies](/docs/production-guide/administration/reduce-database-size/).

Apart from these limitations, the United Manufacturing Hub's Historian feature
is highly performant compared to legacy Historians.

## Where to get more information?

- Learn more about the benefits of using open-source databases in our blog
article, [Historians vs Open-Source databases - which is better?](https://learn.umh.app/blog/historians-vs-open-source-databases-which-is-better/)
- Check out the [Getting Started guide](/docs/getstarted/) to start using the
Historian feature.
- Learn more about the United Manufacturing Hub's architecture by visiting
[our architecture page](/docs/architecture/).
- Learn more about our Data Model by visiting [this page](/docs/datamodel/).
- Learn more about our database for `_historian` schema by visiting
[our documentation](/docs/datamodel/database/).
