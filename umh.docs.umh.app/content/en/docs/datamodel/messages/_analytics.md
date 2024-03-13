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
p --> p-set-bad-quantity[setbad_quantity]

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

- **`external_work_order_id`** (string): The work order ID from your MES or ERP system.
- **`product`** (object): The product being produced.
   - **`external_product_id`** (string): The product ID from your MES or ERP system.
   - **`cycle_time_ms`** (number) *(optional)*: The cycle time for the product in seconds. Only include this if the product has not been previously created.
- **`quantity`** (number): The quantity of the product to be produced.
- **`status`** (number) *(optional)*: The status of the work order. Defaults to `0` (created).
   - `0` - Planned
   - `1` - In progress
   - `2` - Completed
- **`start_time`** (string) *(optional)*: The start time of the work order. Will be set by the corresponding `start` message if not provided.
- **`end_time`** (string) *(optional)*: The end time of the work order. Will be set by the corresponding `stop` message if not provided.


**Example**
```json
{
  "external_work_order_id": "1234",
  "product": {
    "external_product_id": "5678"
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
- **`external_work_order_id`** (string): The work order ID from your MES or ERP system.
- **`start_time`** (string): The start time of the work order.

**Example**
```json
{
  "external_work_order_id": "1234",
  "start_time": "2021-01-01T12:00:00Z"
}
```

### Stop

Use this topic to stop a previously started work order.

{{% notice note %}}
Stopping an already stopped work order will have no effect.
Only work orders with status `1` (in progress) and no end time can be stopped.
{{% /notice %}}

**Fields**
- **`external_work_order_id`** (string): The work order ID from your MES or ERP system.
- **`end_time`** (string): The end time of the work order.

**Example**
```json
{
  "external_work_order_id": "1234",
  "end_time": "2021-01-01T12:00:00Z"
}
```

## Product Type

### Create

Announce a new product type.

{{% notice info %}}
We recommend using the work-order/create message to create products on the fly.
{{% /notice %}}

**Fields**
- **`external_product_type_id`** (string): The product type ID from your MES or ERP system.
- **`cycle_time_ms`** (number) *(optional)*: The cycle time for the product in seconds.

**Example**
```json
{
  "external_product_type_id": "5678",
  "cycle_time_ms": 60
}
```

## Product

### Add

Communicates the completion of part of a work order.

**Fields**
- **`external_product_type_id`** (string): The product type ID from your MES or ERP system.
- **`product_batch_id`** (string) *(optional)*: Unique identifier for the product. This could for example be a barcode or serial number.
- **`start_time`** (string): The start time of the product.
- **`end_time`** (string): The end time of the product.
- **`quantity`** (number): The quantity of the product produced.
- **`bad_quantity`** (number) *(optional)*: The quantity of bad products produced.

**Example**
```json
{
  "external_product_type_id": "5678",
  "product_batch_id": "1234",
  "start_time": "2021-01-01T12:00:00Z",
  "end_time": "2021-01-01T12:01:00Z",
  "quantity": 100,
  "bad_quantity": 5
}
```

### Set Bad Quantity

Modify the quantity of bad products produced.

**Fields**
- **`external_product_type_id`** (string): The product type ID from your MES or ERP system.
- **`end_time`** (string): The end time of the product, used to identify an existing product.
- **`bad_quantity`** (number): The new quantity of bad products produced.

**Example**
```json
{
  "external_product_type_id": "5678",
  "end_time": "2021-01-01T12:01:00Z",
  "bad_quantity": 10
}
```

## Shift

### Add

Announce a new shift.

**Fields**
- **`start_time`** (string): The start time of the shift.
- **`end_time`** (string): The end time of the shift.

**Example**
```json
{
  "start_time": "2021-01-01T06:00:00Z",
  "end_time": "2021-01-01T14:00:00Z"
}
```

### Delete

Delete a previously created shift.

**Fields**
- **`start_time`** (string): The start time of the shift.

**Example**
```json
{
  "start_time": "2021-01-01T06:00:00Z"
}
```

## State

### Add

Announce a state change.

Checkout the [state](../../states) documentation for a list of available states.

**Fields**
- **`state`** (number): The state of the machine.
- **`start_time`** (string): The start time of the [state](../../states).

**Example**
```json
{
  "state": 10000,
  "start_time": "2021-01-01T12:00:00Z"
}
```

### Overwrite

Overwrite one or more states between two times.

**Fields**
- **`state`** (number): The state of the machine.
- **`start_time`** (string): The start time of the [state](../../states).
- **`end_time`** (string): The end time of the [state](../../states).