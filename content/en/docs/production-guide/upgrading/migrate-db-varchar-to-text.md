---
title: "Migrate DB from varchar to text"
description: "This migration optimizes the database, by changing the data type of some columns from varchar to text"
maximum_version: 0.9.5
---

## Instructions

1. Open OpenLens
2. Open a Shell inside the timescale pod

![Untitled](/images/production-guide/upgrading/migrate-db-varchar-to-text/timescaleShell.png)

1. Execute 

```bash
psql
```

![Untitled](/images/production-guide/upgrading/migrate-db-varchar-to-text/psql.png)

1. Execute these SQL statements

```sql
\c factoryinsight
ALTER TABLE assettable ALTER COLUMN assetid TYPE text;
ALTER TABLE assettable ALTER COLUMN location TYPE text;
ALTER TABLE assettable ALTER COLUMN customer TYPE text;
ALTER TABLE producttable ALTER COLUMN product_name TYPE text;
ALTER TABLE ordertable ALTER COLUMN order_name TYPE text;
ALTER TABLE configurationtable ALTER COLUMN customer TYPE text;
ALTER TABLE componenttable ALTER COLUMN componentname TYPE text;
```

![Untitled](/images/production-guide/upgrading/migrate-db-varchar-to-text/alter_table.png)

1. Confirm the changes by using

```sql
SELECT COLUMN_NAME, DATA_TYPE FROM information_schema.columns WHERE TABLE_NAME = 'assettable';
SELECT COLUMN_NAME, DATA_TYPE FROM information_schema.columns WHERE TABLE_NAME = 'producttable';
SELECT COLUMN_NAME, DATA_TYPE FROM information_schema.columns WHERE TABLE_NAME = 'ordertable';
SELECT COLUMN_NAME, DATA_TYPE FROM information_schema.columns WHERE TABLE_NAME = 'configurationtable';
SELECT COLUMN_NAME, DATA_TYPE FROM information_schema.columns WHERE TABLE_NAME = 'componenttable';
```

![Untitled](/images/production-guide/upgrading/migrate-db-varchar-to-text/select.png)
