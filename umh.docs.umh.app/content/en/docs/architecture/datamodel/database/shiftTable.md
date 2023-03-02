+++
title = "shiftTable"
description = "shiftTable contains shifts with asset, start and finish timestamp"
+++

## Usage

This table stores shifts

## Structure

| key               | data type     | description                                                          | example |
|-------------------|---------------|----------------------------------------------------------------------|---------|
| `id`              | `serial`      | Auto incrementing id                                                 | 0       |
| `type`            | `integer`     | Shift type (1 for shift, 0 for no shift)                             | 1       |
| `begin_timestamp` | `timestamptz` | Begin of the shift                                                   | 3       |
| `end_timestamp`   | `timestamptz` | End of the shift                                                     | 10      |
| `asset_id`        | `text`        | Asset ID the shift is performed on (see [assetTable](/docs/architecture/datamodel/database/assettable)) | 1       |

## Relations

![shiftTable](/images/architecture/datamodel/database/shifttable.png)

## DDL
```sql
-- Using btree_gist to avoid overlapping shifts
-- Source: https://gist.github.com/fphilipe/0a2a3d50a9f3834683bf
CREATE EXTENSION btree_gist;
CREATE TABLE IF NOT EXISTS shiftTable
(
    id              SERIAL      PRIMARY KEY,
    type            INTEGER,
    begin_timestamp TIMESTAMPTZ NOT NULL,
    end_timestamp   TIMESTAMPTZ,
    asset_id        SERIAL      REFERENCES assetTable (id),
    unique (begin_timestamp, asset_id),
    CHECK (begin_timestamp < end_timestamp),
    EXCLUDE USING gist (asset_id WITH =, tstzrange(begin_timestamp, end_timestamp) WITH &&)
);
```
