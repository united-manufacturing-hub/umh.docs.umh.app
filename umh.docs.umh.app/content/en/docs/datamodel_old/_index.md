---
title: "Data Model (v1)"
menuTitle: "Data Model (v2)"
description: "This page describes the data model of the UMH stack - from the message payloads up to database tables."
weight: 1750
deprecated: true
aliases:
  - /docs/architecture/datamodel_old/
---

## Raw Data

If you have events that you just want to send to the message broker / Unified Namespace without the need for it to be stored, simply send it to the `raw` topic.
This data will not be processed by the UMH stack, but you can use it to build your own data processing pipeline.

### ProcessValue Data

If you have data that does not fit in the other topics (such as your PLC tags or sensor data), you can use the `processValue` topic. It will be saved in the database in the [processValue](/docs/architecture/datamodel/database/processvaluetable/) or [processValueString](/docs/architecture/datamodel/database/processvaluestringtable/) and can be queried using [factorysinsight](/docs/architecture/microservices/core/factoryinsight/) or the [umh-datasource](/docs/architecture/microservices/grafana-plugins/umh-datasource/) Grafana plugin.

### Production Data

In a production environment, you should first declare products using [addProduct](/docs/architecture/datamodel/messages/addproduct).
This allows you to create an order using [addOrder](/docs/architecture/datamodel/messages/addorder). Once you have created an order, 
send an [state](/docs/architecture/datamodel/messages/state) message to tell the database that the machine is working (or not working) on the order. 

When the machine is ordered to produce a product, send a [startOrder](/docs/architecture/datamodel/messages/startorder) message.
When the machine has finished producing the product, send an [endOrder](/docs/architecture/datamodel/messages/endorder) message.

Send [count](/docs/architecture/datamodel/messages/count) messages if the machine has produced a product, but it does not make sense to give the product its ID. Especially useful for bottling or any other use case with a large amount of products, where not each product is traced. 

You can also add shifts using [addShift](/docs/architecture/datamodel/messages/addshift).

All messages land up in different tables in the [database](/docs/architecture/datamodel/database/) and will be accessible from [factorysinsight](/docs/architecture/microservices/core/factoryinsight/) or the [umh-datasource](/docs/architecture/microservices/grafana-plugins/umh-datasource/) Grafana plugin.

{{% notice tip %}}
**Recommendation:** Start with *addShift* and *state* and continue from there on
{{% /notice %}}

### Modifying Data

If you have accidentally sent the wrong state or if you want to modify a value, you can use the [modifyState](/docs/architecture/datamodel/messages/modifystate) message.

### Unique Product Tracking

You can use [uniqueProduct](/docs/architecture/datamodel/messages/uniqueproduct) to tell the database that a new instance of a product has been created.
If the produced product is scrapped, you can use [scrapUniqueProduct](/docs/architecture/datamodel/messages/scrapuniqueproduct/) to change its state to scrapped.
