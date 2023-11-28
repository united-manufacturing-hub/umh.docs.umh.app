---
title: "detectedAnomaly"
description: "detectedAnomaly messages are sent when an asset has stopped and the reason is identified."
aliases:
  - /docs/architecture/datamodel/messages/detectedanomaly/
---

{{% notice warning %}}
This is part of our recommended workflow to create machine states. The data sent here will not be stored in the database automatically, as it will be required to be converted into a [state](/docs/architecture/datamodel/states). In the future, there will be a microservice, which converts these automatically.
{{% /notice %}}

## Topic

{{< tabs name="topic_structure" >}}
{{< tab name="MQTT" codelang="none" >}}
ia/<customerID>/<location>/<AssetID>/detectedAnomaly
{{< /tab >}}
{{< tab name="Kafka" codelang="none" >}}
ia.<customerID>.<location>.<AssetID>.detectedAnomaly
{{< /tab >}}
{{< /tabs >}}

## Usage

A message is sent here each time a stop reason has been identified automatically or by input from the machine operator.

## Content

| key               | data type | description                                 |
|-------------------|-----------|---------------------------------------------|
| `timestamp_ms`    | `int`     | Unix timestamp of message creation          |
| `detectedAnomaly` | `string`  | reason for the production stop of the asset |


### JSON

#### Examples

The anomaly of the asset has been identified as maintenance:
```json
{
  "timestamp_ms":1588879689394,
  "detectedAnomaly":"maintenance",
}
```


<!---
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
--->
## Producers

- Typically Node-RED

## Consumers

- Typically Node-RED
