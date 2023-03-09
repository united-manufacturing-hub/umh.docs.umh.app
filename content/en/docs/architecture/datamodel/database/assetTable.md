+++
title = "assetTable"
description = "assetTable is contains all assets and their location."
+++

## Usage

Primary table for our data structure, it contains all the assets and their location.


## Structure

| key        | data type | description                                   | example        |
|------------|-----------|-----------------------------------------------|----------------|
| `id`       | `int`     | Auto incrementing id of the asset             | 0              |
| `assetID`  | `text`    | Asset name                                    | Printer-03     |
| `location` | `text`    | Physical location of the asset                | DCCAachen      |
| `customer` | `text`    | Customer name, in most cases "factoryinsight" | factoryinsight |


## Relations

![assetTable](/images/architecture/datamodel/database/assettable.png)

## DDL
```sql
 CREATE TABLE IF NOT EXISTS assetTable
 (
     id         SERIAL  PRIMARY KEY,
     assetID    TEXT    NOT NULL,
     location   TEXT    NOT NULL,
     customer   TEXT    NOT NULL,
     unique (assetID, location, customer)
 );
```
