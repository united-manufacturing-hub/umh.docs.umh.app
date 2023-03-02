+++
title = "Datamodel"
menuTitle = "Datamodel"
description = "This page describes the data model of the UMH stack."
weight = 4000
+++

## Raw Data

If you have raw sensor data that you want to transport using the stack, simply send it to the `raw` topic.
This data will not be processed by the UMH stack, but you can use it to build your own data processing pipeline.

### ProcessValue Data

If you have data that does not fit in the other topics, you can use the `processValue` topic.
It will be saved in the database and can act as a key-value store.

### Production Data

In a production environment, you should first declare products using [addProduct](./messages/addproduct).
This allows you to create an order using [addOrder](./messages/addorder). Once you have created an order, 
send an [activity](./messages/activity) message to tell the database that the machine is working on the order. You can also add shifts using [addShift](./messages/addshift).

When the machine is ordered to produce a product, send a [startOrder](./messages/startorder) message.
When the machine has finished producing the product, send an [endOrder](./messages/endorder) message.

If the state of the machine changes (for example, if it is stopped), send a [state](./messages/state) message. 
Send [count](./messages/count) messages if the machine has produced a product.

### Modifying Data

If you have accidentally sent the wrong state or if you want to modify a value, you can use the [modifyState](./messages/modifyState) message.

### Unique Product Tracking

You can use [uniqueProduct](./messages/uniqueproduct) to tell the database that a new instance of a product has been created.
If the produced product is scrapped, you can use [messages/addproduct/](./messages/addproduct) to change its state to scrapped.

