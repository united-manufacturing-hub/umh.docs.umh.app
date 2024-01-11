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

### Sample command for the processvaluetable in the factoryinsight database:

1. The first step is to turn on data compression on the target table, and set the compression options. Refer to the [TimescaleDB documentation](https://docs.timescale.com/api/latest/compression/alter_table_compression/) for a full list of options.

    ```sql
    -- set "asset_id" as the key for the compressed segments and orders the table by "valuename".
    ALTER TABLE processvaluetable SET (timescaledb.compress, timescaledb.compress_segmentby = 'asset_id', timescaledb.compress_orderby = 'valuename');
    ```

2. Then, you have to create the compression policy. The interval determines the age that the chunks of data need to reach before being compressed. Read the [official documentation](https://docs.timescale.com/api/latest/compression/add_compression_policy/) for more information.

    ```sql
    -- set a compression policy on the "processvaluetable" table, which will compress data older than 7 days.
    SELECT add_compression_policy('processvaluetable', INTERVAL '7 days');
    ```

### Sample command for the tag table in the umh_v2 database:

1. The first step is to turn on data compression on the target table, and set the compression options. Refer to the [TimescaleDB documentation](https://docs.timescale.com/api/latest/compression/alter_table_compression/) for a full list of options.

    ```sql
    -- set "asset_id" as the key for the compressed segments and orders the table by "name".
    ALTER TABLE tag SET (timescaledb.compress, timescaledb.compress_segmentby = 'asset_id', timescaledb.compress_orderby = 'name');
    ```

2. Then, you have to create the compression policy. The interval determines 
the age that the chunks of data need to reach before being compressed. 
Read the [official documentation](https://docs.timescale.com/api/latest/compression/add_compression_policy/) for more information.

    ```sql
    -- set a compression policy on the "tag" table, which will compress data older than 2 weeks.
    SELECT add_compression_policy('tag', INTERVAL '2 weeks');
    ```


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

<!-- discussion -->

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- Learn how to [delete assets from the database](/docs/production-guide/administration/delete-assets) 
explains how to turn on compression.
- Learn how to [change the language in factoryinsight](/docs/production-guide/administration/change-factoryinsight-language).