---
title: "_analytics"
description: "Messages for our analytics feature"
weight: 1000
---

# Topic structure

{{<mermaid theme="neutral" >}}
flowchart LR
topicStart["umh.v1..."] --> _analytics


_analytics --> wo[work-order]
wo --> wo-create[create]
wo --> wo-start[start]
wo --> wo-stop[stop]


_analytics --> pt[product-type]
pt --> pt-create[create]

_analytics --> p[product]
p --> p-add[add]
p --> p-set-bad-quantity[setBadQuantity]

_analytics --> s[shift]
s --> s-add[add]
s --> s-delete[delete]

_analytics --> st[state]
st --> st-add[add]
st --> st-overwrite[overwrite]


    classDef mqtt fill:#00dd00,stroke:#333,stroke-width:4px;
    class umh,v1,enterprise,_analytics mqtt;

    classDef type fill:#00ffbb,stroke:#333,stroke-width:4px;
    class wo,pt,p,s,st type;

    classDef func fill:#8899dd,stroke:#333,stroke-width:4px;
    class wo-create,wo-start,wo-stop,pt-create,p-add,p-set-bad-quantity,s-add,s-delete,st-add,st-overwrite func;

    click topicStart href "../"
    click wo href "#work-order"
    click pt href "#product-type"
    click p href "#product"
    click s href "#shift"

    click wo-create href "#create"
    click wo-start href "#start"
    click wo-stop href "#stop"

    click pt-create href "#create-1"

    click p-add href "#add"
    click p-set-bad-quantity href "#set-bad-quantity"

    click s-add href "#add-1"
    click s-delete href "#delete"

    click st-add href "#add-2"
    click st-overwrite href "#overwrite"

{{</ mermaid >}}


## Work Order

### Create

Use this topic to create a new work order.

{{% notice note %}}
This replaces the `addOrder` message from our v0 data model.
{{% /notice %}}

**Fields**

- **`externalWorkOrderId`** (string): The work order ID from your MES or ERP system.
- **`product`** (object): The product being produced.
   - **`externalProductId`** (string): The product ID from your MES or ERP system.
   - **`cycleTime`** (number) *(optional)*: The cycle time for the product in seconds. Only include this if the product has not been previously created.
- **`quantity`** (number): The quantity of the product to be produced.
- **`status`** (number) *(optional)*: The status of the work order. Defaults to `0` (created).
   - `0` - Planned
   - `1` - In progress
   - `2` - Completed
- **`startTime`** (string) *(optional)*: The start time of the work order. Will be set by the corresponding `start` message if not provided.
- **`endTime`** (string) *(optional)*: The end time of the work order. Will be set by the corresponding `stop` message if not provided.


**Example**
```json
{
  "externalWorkOrderId": "1234",
  "product": {
    "externalProductId": "5678"
  },
  "quantity": 100,
  "status": 0
}
```

### Start

Use this topic to start a previously created work order.

{{% notice note %}}
Each work order can only be started once.
Only work orders with status `0` (planned) and no start time can be started.
{{% /notice %}}

**Fields**
- **`externalWorkOrderId`** (string): The work order ID from your MES or ERP system.
- **`startTime`** (string): The start time of the work order.

**Example**
```json
{
  "externalWorkOrderId": "1234",
  "startTime": "2021-01-01T12:00:00Z"
}
```

### Stop

Use this topic to stop a previously started work order.

{{% notice note %}}
Stopping an already stopped work order will have no effect.
Only work orders with status `1` (in progress) and no end time can be stopped.
{{% /notice %}}

**Fields**
- **`externalWorkOrderId`** (string): The work order ID from your MES or ERP system.
- **`endTime`** (string): The end time of the work order.

**Example**
```json
{
  "externalWorkOrderId": "1234",
  "endTime": "2021-01-01T12:00:00Z"
}
```

## Product Type

### Create

Announce a new product type.

{{% notice info %}}
We recommend using the work-order/create message to create products on the fly.
{{% /notice %}}

**Fields**
- **`externalProductTypeId`** (string): The product type ID from your MES or ERP system.
- **`cycleTime`** (number) *(optional)*: The cycle time for the product in seconds.

**Example**
```json
{
  "externalProductTypeId": "5678",
  "cycleTime": 60
}
```

## Product

### Add

Communicates the completion of part of a work order.

**Fields**
- **`externalProductTypeId`** (string): The product type ID from your MES or ERP system.
- **`productID`** (string) *(optional)*: Unique identifier for the product. This could for example be a barcode or serial number.
- **`startTime`** (string): The start time of the product.
- **`endTime`** (string): The end time of the product.
- **`quantity`** (number): The quantity of the product produced.
- **`badQuantity`** (number) *(optional)*: The quantity of bad products produced.

**Example**
```json
{
  "externalProductTypeId": "5678",
  "productID": "1234",
  "startTime": "2021-01-01T12:00:00Z",
  "endTime": "2021-01-01T12:01:00Z",
  "quantity": 100,
  "badQuantity": 5
}
```

### Set Bad Quantity

Modify the quantity of bad products produced.

**Fields**
- **`externalProductTypeId`** (string): The product type ID from your MES or ERP system.
- **`endTime`** (string): The end time of the product, used to identify an existing product.
- **`badQuantity`** (number): The new quantity of bad products produced.

**Example**
```json
{
  "externalProductTypeId": "5678",
  "endTime": "2021-01-01T12:01:00Z",
  "badQuantity": 10
}
```

## Shift

### Add

Announce a new shift.

**Fields**
- **`startTime`** (string): The start time of the shift.
- **`endTime`** (string): The end time of the shift.

**Example**
```json
{
  "startTime": "2021-01-01T06:00:00Z",
  "endTime": "2021-01-01T14:00:00Z"
}
```

### Delete

Delete a previously created shift.

**Fields**
- **`startTime`** (string): The start time of the shift.

**Example**
```json
{
  "startTime": "2021-01-01T06:00:00Z"
}
```

## State

### Add

Announce a state change.

**Fields**
- **`state`** (number): The state of the machine.
- **`startTime`** (string): The start time of the [state](../../states).

**Example**
```json
{
  "state": 10000,
  "startTime": "2021-01-01T12:00:00Z"
}
```

### Overwrite

Overwrite one or more states between two times.

**Fields**
- **`state`** (number): The state of the machine.
- **`startTime`** (string): The start time of the [state](../../states).
- **`endTime`** (string): The end time of the [state](../../states).