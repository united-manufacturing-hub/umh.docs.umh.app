+++
title = "state"
description = "State messages are sent every time an asset changes status."
+++

## Topic

{{< tabs name="topic_structure" >}}
{{< tab name="MQTT" codelang="go" >}}
ia/<customerID>/<location>/<AssetID>/state
{{< /tab >}}
{{< tab name="Kafka" codelang="go" >}}
ia.<customerID>.<location>.<AssetID>.state
{{< /tab >}}
{{< /tabs >}}

## Usage

A message is sent here each time the asset changes status. Subsequent changes are not possible. Different statuses can also be process steps, such as “setup”, “post-processing”, etc. You can find a list of all supported states [here](/docs/architecture/datamodel/states).

## Content

| key            | data type | description                                    |
|----------------|-----------|------------------------------------------------|
| `state`        | `uint32`  | value of the state according to the link above |
| `timestamp_ms` | `uint64`  | unix timestamp of message creation             |



### JSON

#### Example

The asset has a state of 10000, which means it is actively producing.

```json
{
  "timestamp_ms":1589788888888,
  "state":10000
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
