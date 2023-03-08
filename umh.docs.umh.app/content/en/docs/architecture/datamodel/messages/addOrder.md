+++
title = "addOrder"
description = "AddOrder messages are sent when a new order is added."
+++

## Topic

{{< tabs name="topic_structure" >}}
{{< tab name="MQTT" codelang="go" >}}
ia/<customerID>/<location>/<AssetID>/addOrder
{{< /tab >}}
{{< tab name="Kafka" codelang="go" >}}
ia.<customerID>.<location>.<AssetID>.addOrder
{{< /tab >}}
{{< /tabs >}}

## Usage

A message is sent here each time a new order is added.

## Content

| key            | data type | description                    |
|----------------|-----------|--------------------------------|
| `product_id`   | `string`  | current product name           |
| `order_id`     | `string`  | current order name             |
| `target_units` | `int64`   | amount of units to be produced |



{{% notice warning %}}
1. The product needs to be added before adding the order. Otherwise, this message will be discarded
2. One order is always specific to that asset and can, by definition, not be used across machines. For this case one would need to create one order and product for each asset (reason: one product might go through multiple machines, but might have different target durations or even target units, e.g. one big 100m batch get split up into multiple pieces)
{{% /notice %}}



### JSON

#### Examples

One order was started for 100 units of product "test":
```json
{
  "product_id":"test",
  "order_id":"test_order",
  "target_units":100
}
```



#### Schema

```json
{
    "$schema": "http://json-schema.org/draft/2019-09/schema",
    "$id": "https://learn.umh.app/content/docs/architecture/datamodel/messages/addOrder.json",
    "type": "object",
    "default": {},
    "title": "Root Schema",
    "required": [
        "product_id",
        "order_id",
        "target_units"
    ],
    "properties": {
        "product_id": {
            "type": "string",
            "default": "",
            "title": "The product id to be produced",
            "examples": [
                "test",
                "Beierlinger 30x15"
            ]
        },
        "order_id": {
            "type": "string",
            "default": "",
            "title": "The order id of the order",
            "examples": [
                "test_order",
                "HA16/4889"
            ]
        },
        "target_units": {
            "type": "integer",
            "default": 0,
            "minimum": 0,
            "title": "The amount of units to be produced",
            "examples": [
                1,
                100
            ]
        }
    },
    "examples": [{
      "product_id": "Beierlinger 30x15",
      "order_id": "HA16/4889",
      "target_units": 1
    },{
      "product_id":"test",
      "order_id":"test_order",
      "target_units":100
    }]
}
```

## Producers

- Typically Node-RED

## Consumers

- [kafka-to-postgresql](/docs/architecture/microservices/core/kafka-to-postgresql)
