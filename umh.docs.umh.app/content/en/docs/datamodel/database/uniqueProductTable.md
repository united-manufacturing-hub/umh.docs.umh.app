---
title: "uniqueProductTable"
description: "uniqueProductTable contains unique products and their IDs." 
aliases:
  - /docs/architecture/datamodel/database/uniqueproducttable/
---

## Usage

This table stores unique products.

## Structure

| key                  | data type     | description                                             | example          |
|----------------------|---------------|---------------------------------------------------------|------------------|
| `uid`                | `text`        | ID of a unique product                                  | 0                |
| `asset_id`           | `serial`      | Asset id (see [assetTable](/docs/architecture/datamodel/database/assettable))              | 1                |
| `begin_timestamp_ms` | `timestamptz` | Time when product was inputted in asset                 | 0                |
| `end_timestamp_ms`   | `timestamptz` | Time when product was output of asset                   | 100              |
| `product_id`         | `text`        | ID of the product (see [productTable](/docs/architecture/datamodel/database/producttable)) | 1                |
| `is_scrap`           | `boolean`     | True if product is scrap                                | true             |
| `quality_class`      | `text`        | Quality class of the product                            | A                |
| `station_id`         | `text`        | ID of the station where the product was processed       | Soldering Iron-1 |


## Relations

![uniqueProductTable](/images/architecture/datamodel/database/uniqueproducttable.png)

## DDL
```sql
CREATE TABLE IF NOT EXISTS uniqueProductTable
(
    uid                 TEXT        NOT NULL,
    asset_id            SERIAL      REFERENCES assetTable (id),
    begin_timestamp_ms  TIMESTAMPTZ NOT NULL,
    end_timestamp_ms    TIMESTAMPTZ NOT NULL,
    product_id          TEXT        NOT NULL,
    is_scrap            BOOLEAN     NOT NULL,
    quality_class       TEXT        NOT NULL,
    station_id          TEXT        NOT NULL,
    UNIQUE(uid, asset_id, station_id),
    CHECK (begin_timestamp_ms < end_timestamp_ms)
);

-- creating an index to increase performance
CREATE INDEX ON uniqueProductTable (asset_id, uid, station_id);
```
