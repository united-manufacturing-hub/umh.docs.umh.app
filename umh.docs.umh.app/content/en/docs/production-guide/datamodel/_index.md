+++
title = "Datamodel"
menuTitle = "Datamodel"
description = "TODO"
weight = 4000
+++

## Raw data

If you have raw sensor data, and you want to transport it using the stack, just send it to the `raw` topic.
It will not be processed by the UMH stack, but you can use it to build your own data processing pipeline.

### ProcessValue data

If you have data, which does not fit in the other topics, you can use the `processValue` topic.
It will be saved in the database, and can akt as a key-value store.

### Production data

In a production environment, you should first declare products using [addProduct](messages/addproduct).
This allows you to create an order using [addOrder](messages/addorder).
Once you have created an order, send an [activity](messages/activity) message, to tell the database, that the machine is working on the order.
You can also add Shifts using [addShift](messages/addshift).

When the machine is ordered to produce a product, you should send a [startOrder](messages/startorder) message.
When the machine has finished producing the product, you should send a [endOrder](messages/endorder) message.

If the state of the machine changes (for example, if it is stopped), you should send a [state](messages/state) message.
Send [count](messages/count) messages, if the machine has produced a product.

### Modifying data

If you have accidentally sent the wrong state, or if you want to modify a value, you can use the [modifyState](messages/modifyState) message.


### Unique product tracking

You can use [uniqueProduct](messages/uniqueproduct) to tell the database, that a new instance of a product has been created.
If the produced product is scrapped, you can use [messages/addproduct/](messages/addproduct/) to change its state to scrapped.

