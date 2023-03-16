---
title: "Optimize Database Datatypes"
content_type: task
description: |
    This page describes how to change the datatype of some columns in the database
    in order to optimize the performance.
weight: 110
maximum_version: 0.9.5
---

<!-- overview -->

In version 0.9.5 and prior, some tables in the database were created with the
`varchar` data type. This data type is not optimal for storing large amounts of
data. In version 0.9.6, the data type of some columns was changed from `varchar`
to `text`. This migration optimizes the database, by changing the data type of
some columns from varchar to text.

## {{% heading "prerequisites" %}}

{{< include "task-aftinst-prereqs.md" >}}

<!-- steps -->

{{< include "open-database-shell" >}}

## Alter the tables

Execute the following SQL statements:

```sql
ALTER TABLE assettable ALTER COLUMN assetid TYPE text;
ALTER TABLE assettable ALTER COLUMN location TYPE text;
ALTER TABLE assettable ALTER COLUMN customer TYPE text;
ALTER TABLE producttable ALTER COLUMN product_name TYPE text;
ALTER TABLE ordertable ALTER COLUMN order_name TYPE text;
ALTER TABLE configurationtable ALTER COLUMN customer TYPE text;
ALTER TABLE componenttable ALTER COLUMN componentname TYPE text;
```

Then confirm the changes by using the following SQL statements:

```sql
SELECT COLUMN_NAME, DATA_TYPE FROM information_schema.columns WHERE TABLE_NAME = 'assettable';
SELECT COLUMN_NAME, DATA_TYPE FROM information_schema.columns WHERE TABLE_NAME = 'producttable';
SELECT COLUMN_NAME, DATA_TYPE FROM information_schema.columns WHERE TABLE_NAME = 'ordertable';
SELECT COLUMN_NAME, DATA_TYPE FROM information_schema.columns WHERE TABLE_NAME = 'configurationtable';
SELECT COLUMN_NAME, DATA_TYPE FROM information_schema.columns WHERE TABLE_NAME = 'componenttable';
```
