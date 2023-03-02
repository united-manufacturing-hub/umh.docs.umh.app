+++
title = "scrapUniqueProduct"
description = "ScrapUniqueProduct messages are sent whenever a unique product should be scrapped."
+++


## Topic

MQTT: ``ia/<customerID>/<location>/<AssetID>/scrapUniqueProduct``

{{% notice note %}}
For Kafka just switch the `/` character with a `.`
{{% /notice %}}

## Usage

A message is sent here everytime a unique product is scrapped.

## Content

| key   | data type | description                      |
|-------|-----------|----------------------------------|
| `UID` | `string`  | unique ID of the current product |



### JSON

#### Example

The product with the unique ID 22 is scrapped.

```json
{
    "UID": 22, 
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

- [kafka-to-postgresql](/docs/core/kafka-to-postgresql)
