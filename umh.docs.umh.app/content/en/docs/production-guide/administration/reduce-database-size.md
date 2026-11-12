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

{{< include "task-aftinst-prereqs.md" >}}

<!-- steps -->

## Open the database shell

{{< include "open-database-shell.md" >}}

Connect to the corresponding database:

{{< tabs name="connect_db" >}}
  {{< tab name="factoryinsight" codelang="sql" >}}
  \c factoryinsight
  {{< /tab >}}
  {{< tab name="umh_v2" codelang="sql" >}}
  \c umh_v2
  {{< /tab >}}
  {{< /tabs >}}

## Enable data compression

You can find sample SQL commands to enable data compression here.

1. The first step is to turn on data compression on the target table, and set the compression options. Refer to the [TimescaleDB documentation](https://docs.timescale.com/api/latest/compression/alter_table_compression/) for a full list of options.

    {{< tabs name="enable_compression" >}}
    {{< tab name="factoryinsight" codelang="sql" >}}
      -- set "asset_id" as the key for the compressed segments and orders the table by "valuename".
      ALTER TABLE processvaluetable SET (timescaledb.compress, timescaledb.compress_segmentby = 'asset_id', timescaledb.compress_orderby = 'valuename');
    {{< /tab >}}
    {{< tab name="umh_v2" codelang="sql" >}}
      -- set "asset_id" as the key for the compressed segments and orders the table by "name".
      ALTER TABLE tag SET (timescaledb.compress, timescaledb.compress_segmentby = 'asset_id', timescaledb.compress_orderby = 'name');
    {{< /tab >}}
    {{< /tabs >}}

2. Then, you have to create the compression policy. The interval determines the age that the chunks of data need to reach before being compressed. Read the [official documentation](https://docs.timescale.com/api/latest/compression/add_compression_policy/) for more information.

    {{< tabs name="compression_policy" >}}
    {{< tab name="factoryinsight" codelang="sql" >}}
      -- set a compression policy on the "processvaluetable" table, which will compress data older than 7 days.
      SELECT add_compression_policy('processvaluetable', INTERVAL '7 days');
    {{< /tab >}}
    {{< tab name="umh_v2" codelang="sql" >}}
      -- set a compression policy on the "tag" table, which will compress data older than 2 weeks.
      SELECT add_compression_policy('tag', INTERVAL '2 weeks');
    {{< /tab >}}
    {{< /tabs >}}


## Enable data retention

You can find sample SQL commands to enable data retention here.

### Sample command for factoryinsight and umh_v2 databases:

  Enabling data retention consists in only adding the policy with the desired 
  retention interval. Refer to [the official documentation](https://docs.timescale.com/api/latest/data-retention/add_retention_policy/) 
  for more detailed information about these queries.

  {{< tabs name="retention_sample" >}}
  {{< tab name="factoryinsight" codelang="sql" >}}
  -- Set a retention policy on the "processvaluetable" table, which will delete data older than 7 days.
  SELECT add_retention_policy('processvaluetable', INTERVAL '7 days');
  {{< /tab >}}
  {{< tab name="umh_v2" codelang="sql" >}}
  -- set a retention policy on the "tag" table, which will delete data older than 3 months.
  SELECT add_retention_policy('tag', INTERVAL '3 months');
  {{< /tab >}}
  {{< /tabs >}}

### Retention duration syntax in the benthos-umh TimescaleDB Historian output

The sample commands above set retention with SQL `INTERVAL` values, which the
database interprets. The [benthos-umh](/docs/features/connectivity/benthos-umh/)
TimescaleDB Historian (Output) is configured differently: its retention and
other time settings are parsed by benthos-umh as durations, and they follow
the rules below. These rules do not apply to the SQL commands above.

Since benthos-umh version 0.16.2, these time settings accept only whole hours,
minutes, or seconds, written as a number followed by the unit `h`, `m`, or `s`.

| Unit    | Supported | Example |
| ------- | --------- | ------- |
| Hours   | Yes       | `168h`  |
| Minutes | Yes       | `90m`   |
| Seconds | Yes       | `3600s` |
| Days    | No        | `7d`    |

- To keep data for 7 days, write `168h` (7 × 24 hours). Convert other day counts
  to hours the same way.
- A value without a unit, such as `168`, is not accepted. Validation fails with
  the error `must be a duration with a unit`. Add the unit, for example `168h`.
- A value with the day unit, such as `7d`, is not supported. Use hours instead.

{{% notice note %}}
These rules apply to benthos-umh version 0.16.2 and later. Before you update,
check your existing configuration for values without a unit and add the
missing unit.
{{% /notice %}}

<!-- discussion -->

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- Learn how to [delete assets from the database](/docs/production-guide/administration/delete-assets) 
explains how to turn on compression.
- Learn how to [change the language in factoryinsight](/docs/production-guide/administration/change-factoryinsight-language).