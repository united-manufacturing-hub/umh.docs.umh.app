+++
title = "processValueStringTable"
description = "processValueStringTable contains process values."
+++

## Usage

This table stores process values, for example toner level of a printer, flow rate of a pump, etc.
This table, has a closely related table for storing number values, [processValueTable](/docs/architecture/datamodel/database/processvaluetable).

## Structure

| key         | data type     | description                                | example     |
|-------------|---------------|--------------------------------------------|-------------|
| `timestamp` | `timestamptz` | Entry timestamp                            | 0           |
| `asset_id`  | `serial`      | Asset id (see [assetTable](/docs/architecture/datamodel/database/assettable)) | 1           |
| `valueName` | `text`        | Name of the process value                  | toner-level |
| `value`     | `string`      | Value of the process value                 | 100         |


## Relations

![processValueTable](/images/architecture/datamodel/database/processvaluestringtable.png)

## DDL
```sql
CREATE TABLE IF NOT EXISTS processValueStringTable
(
    timestamp               TIMESTAMPTZ                         NOT NULL,
    asset_id                SERIAL                              REFERENCES assetTable (id),
    valueName               TEXT                                NOT NULL,
    value                   TEST                                NULL,
    UNIQUE(timestamp, asset_id, valueName)
);
-- creating hypertable
SELECT create_hypertable('processValueStringTable', 'timestamp');

-- creating an index to increase performance
CREATE INDEX ON processValueStringTable (asset_id, timestamp DESC);

-- creating an index to increase performance
CREATE INDEX ON processValueStringTable (valuename);
```
