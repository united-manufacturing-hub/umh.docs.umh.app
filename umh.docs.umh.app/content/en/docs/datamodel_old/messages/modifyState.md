---
title: "modifyState"
description: "ModifyState messages are generated when a state of an asset during a certain timeframe needs to be modified."
deprecated: true
aliases:
  - /docs/architecture/datamodel_old/messages/modifystate/
---

## Topic

{{< tabs name="topic_structure" >}}
{{< tab name="MQTT" codelang="none" >}}
ia/<customerID>/<location>/<AssetID>/modifyState
{{< /tab >}}
{{< tab name="Kafka" codelang="none" >}}
ia.<customerID>.<location>.<AssetID>.modifyState
{{< /tab >}}
{{< /tabs >}}

## Usage

`modifyState` is generated to modify the state from the starting timestamp to the end timestamp. You can find a list of all supported states [here](/docs/architecture/datamodel/states).

## Content

| key                | data type | description                                                          |
|--------------------|-----------|----------------------------------------------------------------------|
| `timestamp_ms`     | `int32`   | unix timestamp of the starting point of the timeframe to be modified |
| `timestamp_ms_end` | `int32`   | unix timestamp of the end point of the timeframe to be modified      |
| `new_state`        | `int32`   | new state code                                                       |
<!--- timestamp modify ---->

### JSON

#### Example

The state of the timeframe between the timestamp is modified to be 150000: OperatorBreakState

```json
{
    "timestamp_ms": 1588879689394,
    "timestamp_ms_end": 1588891381023,
    "new_state": 150000
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
