---
title: "Database"
chapter: true
description: "The database stores the messages in different tables."
deprecated: true
aliases:
  - /docs/architecture/datamodel_old/database/
---


## Introduction

We are using the database TimescaleDB, which is based on PostgreSQL and supports standard relational SQL database work,
while also supporting time-series databases.
This allows for usage of regular SQL queries, while also allowing to process and store time-series data.
Postgresql has proven itself reliable over the last 25 years, so we are happy to use it.

If you want to learn more about database paradigms, please refer to the [knowledge article](https://learn.umh.app/lesson/introduction-into-it-ot-databases/) about that topic. 
It also includes a concise video summarizing what you need to know about different paradigms.

Our database model is designed to represent a physical manufacturing process. It keeps track of the following data:
  - The state of the machine
  - The products that are produced
  - The orders for the products
  - The workers' shifts
  - Arbitrary process values (sensor data)
  - The producible products
  - Recommendations for the production

{{% notice note %}}
Please note that our database does not use a retention policy. This means that your database can grow quite fast if you save a lot of process values. Take a look at our [guide on enabling data compression and retention in TimescaleDB](/docs/production-guide/administration/reduce-database-size) to customize the database to your needs.


A good method to check your db size would be to use the following commands inside postgres shell:
```sql
SELECT pg_size_pretty(pg_database_size('factoryinsight'));
```


{{% /notice %}}
