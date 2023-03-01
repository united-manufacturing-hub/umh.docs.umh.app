---
title: "Reduce database size"
content_type: task
description: |
  This page describes how to reduce the size of the United Manufacturing Hub database.
weight: 50
---

<!-- overview -->

Over time, time-series data can consume a large amount of disk space. To reduce
the amount of disk space used by time-series data, there are three options:

- Enable data compression. This reduces the required disk space by applying
mathematical compression to the data. This compression is lossless, so the data
is not changed in any way. However, it will take more time to compress and
decompress the data. For more information, see how
[TimescaleDB compression works](https://docs.timescale.com/timescaledb/latest/how-to-guides/compression/about-compression/#about-compression).
- Enable data retention. This deletes old data that is no longer needed, by
setting policies that automatically delete data older than a specified time. This
can be beneficial for managing the size of the database, as well as adhering to
data retention regulations. However, by definition, data loss will occur. For
more information, see how
[TimescaleDB data retention works](https://docs.timescale.com/timescaledb/latest/how-to-guides/data-retention/about-data-retention/).
- Downsampling. This is a method of reducing the amount of data stored by
aggregating data points over a period of time. For example, you can aggregate
data points over a 30-minute period, instead of storing each data point. If exact
data is not required, downsampling can be useful to reduce database size.
However, data may be less accurate.

## {{% heading "prerequisites" %}}

{{< include "task-tutorial-prereqs.md" >}}

<!-- steps -->

## Open the database shell

{{< include "open-database-shell.md" >}}

## Enable data compression

To enable data compression, you need to execute the following SQL command from
the database shell:

```sql
SELECT add_retention_policy('processvaluetable', INTERVAL '7 days');
```

This command will set a retention policy on the `processvaluetable` table, which
will delete data older than 7 days.

## Enable data retention

To enable data retention, you need to execute the following SQL command from the
database shell:

```sql
SELECT add_compression_policy('processvaluetable', INTERVAL '7 days');
```

This command will set a compression policy on the `processvaluetable` table,
which will compress data older than 7 days.

<!-- discussion -->

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- See [Execute SQL commands](/docs/administration/execute-sql-in-database)
