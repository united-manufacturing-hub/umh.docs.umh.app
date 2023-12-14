---
title: "Database"
content_type: concept
# description: |
#     Add a description of the concept here.
weight: 10
aliases:
  - /docs/architecture/microservices/core/database/
---

<!-- overview -->

The database microservice is the central component of the United Manufacturing
Hub and is based on TimescaleDB, an open-source relational database built for
handling time-series data. TimescaleDB is designed to provide scalable and
efficient storage, processing, and analysis of time-series data.

You can find more information on the datamodel of the database in the
[Data Model](/docs/architecture/datamodel/) section, and read
about the choice to use TimescaleDB in the
[blog article](https://learn.umh.app/blog/why-we-chose-timescaledb-over-influxdb/).

<!-- body -->

## {{% heading "howitworks" %}}

When deployed, the database microservice will create two databases, with the
related usernames and passwords:

- `grafana`: This database is used by Grafana to store the dashboards and
  other data.
- `factoryinsight`: This database is the main database of the United Manufacturing
  Hub. It contains all the data that is collected by the microservices.

Then, it creates the tables based on the [database schema](/docs/architecture/datamodel/database/).

If you want to learn more about how TimescaleDB works, you can read the
[TimescaleDB documentation](https://docs.timescale.com/latest/introduction).

<!-- Optional section; add links to information related to this topic. -->

## {{% heading "whatsnext" %}}

- Read the [Database](/docs/reference/microservices/database/) reference documentation
  to learn more about the technical details of the database microservice.
