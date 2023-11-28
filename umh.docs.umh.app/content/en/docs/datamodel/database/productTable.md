---
title: "productTable"
description: "productTable contains products in production."
aliases:
  - /docs/architecture/datamodel/database/producttable/
---

## Usage

This table products to be produced at assets

## Structure

| key                        | data type | description                                                    | example            |
|----------------------------|-----------|----------------------------------------------------------------|--------------------|
| `product_id`               | `serial`  | Auto incrementing id                                           | 0                  |
| `product_name`             | `text`    | Name of the product                                            | Painting-DaVinci-1 |
| `asset_id`                 | `serial`  | Asset producing this product (see [assetTable](/docs/architecture/datamodel/database/assettable)) | 1                  |
| `time_per_unit_in_seconds` | `real`    | Time in seconds to produce this product                        | 600                |


## Relations

![productTable](/images/architecture/datamodel/database/producttable.png)

## DDL
```sql
CREATE TABLE IF NOT EXISTS productTable
(
    product_id                  SERIAL PRIMARY KEY,
    product_name                TEXT NOT NULL,
    asset_id                    SERIAL REFERENCES assetTable (id),
    time_per_unit_in_seconds    REAL NOT NULL,
    UNIQUE(product_name, asset_id),
    CHECK (time_per_unit_in_seconds > 0)
);
```
