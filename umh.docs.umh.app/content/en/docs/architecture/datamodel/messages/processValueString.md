+++
title = "processValueString"
description = "ProcessValueString messages are sent whenever a custom process value is prepared. The value is a string."
+++

{{% notice warning %}}

This message type is not functional as of 0.9.5!

{{% /notice %}}
## Topic

MQTT: ``ia/<customerID>/<location>/<AssetID>/processValueString``

{{% notice note %}}
For Kafka just switch the `/` character with a `.`
{{% /notice %}}

## Usage

A message is sent each time a process value has been prepared. The key has a unique name. This message is used when the datatype of the process value is a string instead of a number.

## Content

| key            | data type | description                                  |
|----------------|-----------|----------------------------------------------|
| `timestamp_ms` | `int64`   | unix timestamp of message creation           | 
| `<valuename>`  | `string`  | Represents a process value, e.g. temperature |

### JSON

#### Example

At the shown timestamp the custom process value "customer" had a readout of "miller".

```json
{
    "timestamp_ms": 1588879689394, 
    "customer": "miller"
}
```
<!---
#### Schema

```json
{
    "$schema": "http://json-schema.org/draft/2019-09/schema",
    "$id": "https://learn.umh.app/content/docs/datamodel/messages/scrapCount.json",
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

- [kafka-to-postgresql](/docs/core/kafka-to-postgresql)
