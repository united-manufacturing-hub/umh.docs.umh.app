---
title: "processValueTable"
description: "processValueTable contains process values."
aliases:
  - /docs/architecture/datamodel/database/processvaluetable/
---

## Usage

This table stores process values, for example toner level of a printer, flow rate of a pump, etc.
This table, has a closely related table for storing string values, [processValueStringTable](/docs/architecture/datamodel/database/processvaluestringtable).

## Structure

| key         | data type     | description                                | example     |
|-------------|---------------|--------------------------------------------|-------------|
| `timestamp` | `timestamptz` | Entry timestamp                            | 0           |
| `asset_id`  | `serial`      | Asset id (see [assetTable](/docs/architecture/datamodel/database/assettable)) | 1           |
| `valueName` | `text`        | Name of the process value                  | toner-level |
| `value`     | `double`      | Value of the process value                 | 100         |


## Relations

![processValueTable](/images/architecture/datamodel/database/processvaluetable.png)

## DDL
```sql
CREATE TABLE IF NOT EXISTS processValueTable
(
    timestamp               TIMESTAMPTZ                         NOT NULL,
    asset_id                SERIAL                              REFERENCES assetTable (id),
    valueName               TEXT                                NOT NULL,
    value                   DOUBLE PRECISION                    NULL,
    UNIQUE(timestamp, asset_id, valueName)
);
-- creating hypertable
SELECT create_hypertable('processValueTable', 'timestamp');

-- creating an index to increase performance
CREATE INDEX ON processValueTable (asset_id, timestamp DESC);

-- creating an index to increase performance
CREATE INDEX ON processValueTable (valuename);
```
