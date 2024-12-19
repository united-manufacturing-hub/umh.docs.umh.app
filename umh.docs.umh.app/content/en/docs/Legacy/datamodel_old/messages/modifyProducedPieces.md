---
title: "modifyProducedPieces"
description: "ModifyProducesPieces messages are sent whenever the count of produced and scrapped items need to be modified."
deprecated: true
aliases:
  - /docs/architecture/datamodel_old/messages/modifyproducedpieces/
---

## Topic

{{< tabs name="topic_structure" >}}
{{< tab name="MQTT" codelang="none" >}}
ia/<customerID>/<location>/<AssetID>/modifyProducedPieces
{{< /tab >}}
{{< tab name="Kafka" codelang="none" >}}
ia.<customerID>.<location>.<AssetID>.modifyProducedPieces
{{< /tab >}}
{{< /tabs >}}

## Usage

`modifyProducedPieces` is generated to change the count of produced items and scrapped items at the named timestamp.

## Content

| key            | data type | description                                                    |
|----------------|-----------|----------------------------------------------------------------|
| `timestamp_ms` | `int64`   | unix timestamp of the time point whose count is to be modified |
| `count`        | `int32`   | number of produced items                                       |
| `scrap`        | `int32`   | number of scrapped items                                       |


### JSON

#### Example


The count and scrap are overwritten to be to each at the timestamp.

```json
{
    "timestamp_ms": 1588879689394,
    "count": 10,
    "scrap": 10
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
            "product_id": "Beierlinger 30x15",
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
