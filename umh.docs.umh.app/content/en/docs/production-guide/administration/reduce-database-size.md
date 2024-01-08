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

Connect to the `factoryinsight` database:

```bash
\c factoryinsight
```

Or connect to the `umh_v2` database:

```bash
\c umh_v2
```

## Enable data compression

You can find sample SQL commands to enable data compression here:

### Sample command for the processvaluetable in the factoryinsight database:

1. First, turn on compression:

    ```sql
    ALTER TABLE processvaluetable SET (timescaledb.compress, timescaledb.compress_segmentby = 'asset_id', timescaledb.compress_orderby = 'valuename');
    ```
    This command set `asset_id` as the key for the compressed segments 
    and orders the table by `valuename`.

2. Then, create a compression policy:

    ```sql
    SELECT add_compression_policy('processvaluetable', INTERVAL '7 days');
    ```

    This command will set a compression policy on the `processvaluetable` table,
    which will compress data older than 7 days.

### Sample command for the tag table in the umh_v2 database:

1. First, turn on compression:

    ```sql
    ALTER TABLE tag SET (timescaledb.compress, timescaledb.compress_segmentby = 'asset_id', timescaledb.compress_orderby = 'name');
    ```
    This command set `asset_id` as the key for the compressed segments 
    and orders the table by `name`.

2. Then, create a compression policy:

    ```sql
    SELECT add_compression_policy('tag', INTERVAL '2 weeks');
    ```

    This command will set a compression policy on the `tag` table,
    which will compress data older than 2 weeks.


Refer to [the official documentation](https://docs.timescale.com/api/latest/compression/alter_table_compression/)
for more detailed information about these queries.


## Enable data retention

You can find sample SQL commands to enable data retention here:

### Sample command for the processvaluetable in the factoryinsight database:

  ```sql
  SELECT add_retention_policy('processvaluetable', INTERVAL '7 days');
  ```

  This command will set a retention policy on the `processvaluetable` table, which
  will delete data older than 7 days.

### Sample command for the tag table in the umh_v2 database:

  ```sql
  SELECT add_retention_policy('tag', INTERVAL '3 months');
  ```

  This command will set a retention policy on the `tag` table, which
  will delete data older than 3 months.

Refer to [the official documentation](https://docs.timescale.com/api/latest/data-retention/add_retention_policy/)
for more detailed information about these queries.

<!-- discussion -->

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- [Offcial documentation](https://docs.timescale.com/api/latest/compression/alter_table_compression/) 
explains how to turn on compression.
- For more detailed information about creating a compression policy, 
visit [this documentation](https://docs.timescale.com/api/latest/compression/add_compression_policy/).
- [Documentation](https://docs.timescale.com/api/latest/data-retention/add_retention_policy/) 
about data retention.