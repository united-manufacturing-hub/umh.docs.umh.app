+++
title = "startOrder"
description = "StartOrder messages are sent whenever a new order is started."
+++

## Topic

{{< tabs name="topic_structure" >}}
{{< tab name="MQTT" codelang="go" >}}
ia/<customerID>/<location>/<AssetID>/startOrder
{{< /tab >}}
{{< tab name="Kafka" codelang="go" >}}
ia.<customerID>.<location>.<AssetID>.startOrder
{{< /tab >}}
{{< /tabs >}}


## Usage

A message is sent here everytime a new order is started.

## Content

| key            | data type | description                        |
|----------------|-----------|------------------------------------|
| `order_id`     | `string`  | name of the order                  |
| `timestamp_ms` | `int64`   | unix timestamp of message creation |

{{% notice warning %}}
1. See also notes regarding adding products and orders in /addOrder
2. When startOrder is executed multiple times for an order, the last used timestamp is used.
{{% /notice %}}


### JSON

#### Example

The order "test_order" is started at the shown timestamp.

```json
{
  "order_id":"test_order",
  "timestamp_ms":1589788888888
}
```
<!---
#### Schema

```json
{
    "$schema": "http://json-schema.org/draft/2019-09/schema",
    "$id": "https://learn.umh.app/content/docs/architecture/datamodel/messages/scrapCount.json",
    "type": "object",
    "default": {},
    "title": "Root Schema",
    "required": [
        "product_id",
        "time_per_unit_in_seconds"
    ],
    "properties": {
        "product_id": {
          "type": "string",
          "default": "",
          "title": "The product id to be produced"
        },
        "time_per_unit_in_seconds": {
          "type": "number",
          "default": 0.0,
          "minimum": 0,
          "title": "The time it takes to produce one unit of the product"
        }
    },
    "examples": [
        {
            "product_id": "Beilinger 30x15",
            "time_per_unit_in_seconds": "0.2"
        },
        {
            "product_id": "Test product",
            "time_per_unit_in_seconds": "10"
        }
    ]
}
```
-->

## Producers

- Typically Node-RED

## Consumers

- [kafka-to-postgresql](/docs/architecture/microservices/core/kafka-to-postgresql)
