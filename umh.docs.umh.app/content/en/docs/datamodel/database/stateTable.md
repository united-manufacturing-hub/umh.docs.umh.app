---
title: "stateTable"
description: "stateTable contains the states of all assets."
aliases:
  - /docs/architecture/datamodel/database/statetable/
---

## Usage

This table contains all state changes of the assets.

## Structure

| key         | data type     | description                                      | example |
|-------------|---------------|--------------------------------------------------|---------|
| `timestamp` | `timestamptz` | Entry timestamp                                  | 0       |
| `asset_id`  | `serial`      | Asset ID (see [assetTable](/docs/architecture/datamodel/database/assettable))       | 1       |
| `state`     | `integer`     | State ID (see [states](/docs/architecture/datamodel/states/)) | 40000   |


## Relations

![stateTable](/images/architecture/datamodel/database/statetable.png)

## DDL
```sql
CREATE TABLE IF NOT EXISTS stateTable
(
    timestamp   TIMESTAMPTZ NOT NULL,
    asset_id    SERIAL      REFERENCES assetTable (id),
    state       INTEGER     CHECK (state >= 0),
    UNIQUE(timestamp, asset_id)
);
-- creating hypertable
SELECT create_hypertable('stateTable', 'timestamp');

-- creating an index to increase performance
CREATE INDEX ON stateTable (asset_id, timestamp DESC);
```
