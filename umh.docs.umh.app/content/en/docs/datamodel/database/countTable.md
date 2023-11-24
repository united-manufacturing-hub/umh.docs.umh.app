---
title: "countTable"
description: "countTable contains all reported counts of all assets."
aliases:
  - /docs/architecture/datamodel/database/counttable/
---

## Usage

This table contains all reported counts of the assets.

## Structure

| key         | data type     | description                                | example |
|-------------|---------------|--------------------------------------------|---------|
| `timestamp` | `timestamptz` | Entry timestamp                            | 0       |
| `asset_id`  | `serial`      | Asset id (see [assetTable](/docs/architecture/datamodel/database/assettable)) | 1       |
| `count`     | `integer`     | A count greater 0                          | 1       |


## Relations

![countTable](/images/architecture/datamodel/database/counttable.png)

## DDL
```sql
CREATE TABLE IF NOT EXISTS countTable
(
    timestamp                TIMESTAMPTZ                         NOT NULL,
    asset_id            SERIAL REFERENCES assetTable (id),
    count INTEGER CHECK (count > 0),
    UNIQUE(timestamp, asset_id)
);
-- creating hypertable
SELECT create_hypertable('countTable', 'timestamp');

-- creating an index to increase performance
CREATE INDEX ON countTable (asset_id, timestamp DESC);
```
