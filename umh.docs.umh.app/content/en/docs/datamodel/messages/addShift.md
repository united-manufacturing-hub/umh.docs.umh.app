---
title: "addShift"
description: "AddShift messages are sent to add a shift with start and end timestamp." 
aliases:
  - /docs/architecture/datamodel/messages/addshift/
---

## Topic

{{< tabs name="topic_structure" >}}
{{< tab name="MQTT" codelang="none" >}}
ia/<customerID>/<location>/<AssetID>/addShift
{{< /tab >}}
{{< tab name="Kafka" codelang="none" >}}
ia.<customerID>.<location>.<AssetID>.addShift
{{< /tab >}}
{{< /tabs >}}

## Usage

This message is send to indicate the start and end of a shift.

## Content


| key                | data type | description                                |
|--------------------|-----------|--------------------------------------------|
| `timestamp_ms`     | `int64`   | unix timestamp of the shift start          |
| `timestamp_ms_end` | `int64`   | *optional* unix timestamp of the shift end |

### JSON

#### Examples

A shift with start and end:
```json
{
  "timestamp_ms":1589788888888,
  "timestamp_ms_end":1589788888888
}
```

And shift without end:
```json
{
  "timestamp_ms":1589788888888
}
```

#### Schema

```json
{
    "$schema": "http://json-schema.org/draft/2019-09/schema",
    "$id": "https://learn.umh.app/content/docs/architecture/datamodel/messages/scrapCount.json",
    "type": "object",
    "default": {},
    "title": "Root Schema",
    "required": [
        "timestamp_ms"
    ],
    "properties": {
        "timestamp_ms": {
            "type": "integer",
            "description": "The unix timestamp, of shift start"
        },
        "timestamp_ms_end": {
            "type": "integer",
            "description": "The *optional* unix timestamp, of shift end"
        }
    },
    "examples": [
        {
            "timestamp_ms":1589788888888,
            "timestamp_ms_end":1589788888888
        },
        {
            "timestamp_ms":1589788888888
        }
    ]
}
```

## Producers

## Consumers
