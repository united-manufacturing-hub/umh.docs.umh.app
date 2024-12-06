---
title: "orderTable"
description: "orderTable contains orders for production."
deprecated: true
aliases:
  - /docs/architecture/datamodel_old/database/ordertable/
---

## Usage

This table stores orders for product production

## Structure

| key               | data type     | description                                                 | example                        |
|-------------------|---------------|-------------------------------------------------------------|--------------------------------|
| `order_id`        | `serial`      | Auto incrementing id                                        | 0                              |
| `order_name`      | `text`        | Name of the order                                           | Scarjit-500-DaVinci-1-24062022 |
| `product_id`      | `serial`      | Product id to produce                                       | 1                              |
| `begin_timestamp` | `timestamptz` | Begin timestamp of the order                                | 0                              |
| `end_timestamp`   | `timestamptz` | End timestamp of the order                                  | 10000                          |
| `target_units`    | `integer`     | How many product to produce                                 | 500                            |
| `asset_id`        | `serial`      | Which asset to produce on (see [assetTable](/docs/architecture/datamodel/database/assettable)) | 1                              |


## Relations

![orderTable](/images/architecture/datamodel/database/ordertable.png)

## DDL
```sql
CREATE TABLE IF NOT EXISTS orderTable
(
    order_id        SERIAL          PRIMARY KEY,
    order_name      TEXT            NOT NULL,
    product_id      SERIAL          REFERENCES productTable (product_id),
    begin_timestamp TIMESTAMPTZ,
    end_timestamp   TIMESTAMPTZ,
    target_units    INTEGER,
    asset_id        SERIAL          REFERENCES assetTable (id),
    unique (asset_id, order_name),
    CHECK (begin_timestamp < end_timestamp),
    CHECK (target_units > 0),
    EXCLUDE USING gist (asset_id WITH =, tstzrange(begin_timestamp, end_timestamp) WITH &&) WHERE (begin_timestamp IS NOT NULL AND end_timestamp IS NOT NULL)
);
```
