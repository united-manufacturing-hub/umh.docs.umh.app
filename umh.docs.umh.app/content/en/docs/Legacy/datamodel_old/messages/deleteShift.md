---
title: "deleteShift"
description: "DeleteShift messages are sent to delete a shift that starts at the designated timestamp."
deprecated: true
aliases:
  - /docs/architecture/datamodel_old/messages/deleteshift/
---

## Topic

{{< tabs name="topic_structure" >}}
{{< tab name="MQTT" codelang="none" >}}
ia/<customerID>/<location>/<AssetID>/deleteShift
{{< /tab >}}
{{< tab name="Kafka" codelang="none" >}}
ia.<customerID>.<location>.<AssetID>.deleteShift
{{< /tab >}}
{{< /tabs >}}

## Usage

`deleteShift` is generated to delete a shift that started at the designated timestamp.

## Content

| key            | data type | description                       |
|----------------|-----------|-----------------------------------|
| `timestamp_ms` | `int32`   | unix timestamp of the shift start |


### JSON

#### Example


The shift that started at the designated timestamp is deleted from the database. 

```json
{
    "begin_time_stamp": 1588879689394
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
