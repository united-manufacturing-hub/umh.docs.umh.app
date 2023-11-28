---
title: "endOrder"
description: "EndOrder messages are sent whenever a new product is produced."
aliases:
  - /docs/architecture/datamodel/messages/endorder/
---

## Topic

{{< tabs name="topic_structure" >}}
{{< tab name="MQTT" codelang="none" >}}
ia/<customerID>/<location>/<AssetID>/endOrder
{{< /tab >}}
{{< tab name="Kafka" codelang="none" >}}
ia.<customerID>.<location>.<AssetID>.endOrder
{{< /tab >}}
{{< /tabs >}}


## Usage

A message is sent each time a new product is produced.

## Content

| key            | data type | description                        |
|----------------|-----------|------------------------------------|
| `timestamp_ms` | `int64`   | unix timestamp of message creation |
| `order_id`     | `int64`   | current order name                 |


{{% notice warning %}}
See also notes regarding adding products and orders in [/addOrder](/docs/architecture/datamodel/messages/addorder)
{{% /notice %}}

### JSON

#### Examples

The order "test_order" was finished at the shown timestamp.

```json
{
  "order_id":"test_order",
  "timestamp_ms":1589788888888
}
```
#### Schema

```json
{
    "$schema": "http://json-schema.org/draft/2019-09/schema",
    "$id": "https://learn.umh.app/content/docs/architecture/datamodel/messages/endOrder.json",
    "type": "object",
    "default": {},
    "title": "Root Schema",
    "required": [
        "order_id",
        "timestamp_ms"
    ],
    "properties": {
        "timestamp_ms": {
          "type": "integer",
          "description": "The unix timestamp, of shift start"
        },
        "order_id": {
            "type": "string",
            "default": "",
            "title": "The order id of the order",
            "examples": [
                "test_order",
                "HA16/4889"
            ]
        }
    },
    "examples": [{
      "order_id": "HA16/4889",
      "timestamp_ms":1589788888888
    },{
      "product_id":"test",
      "timestamp_ms":1589788888888
    }]
}
```

## Producers

- Typically Node-RED

## Consumers

- [kafka-to-postgresql](/docs/architecture/microservices/core/kafka-to-postgresql)
