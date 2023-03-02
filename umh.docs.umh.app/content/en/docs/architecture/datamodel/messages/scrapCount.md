+++
title = "scrapCount"
description = "ScrapCount messages are sent whenever a product is to be marked as scrap."
+++

## Topic

MQTT: ``ia/<customerID>/<location>/<AssetID>/scrapCount``

{{% notice note %}}
For Kafka just switch the `/` character with a `.`
{{% /notice %}}

## Usage

Here a message is sent every time products should be marked as scrap. It works as follows: A message with scrap and timestamp_ms is sent. It starts with the count that is directly before timestamp_ms. It is now iterated step by step back in time and step by step the existing counts are set to scrap until a total of scrap products have been scraped.

## Content

- ``timestamp_ms`` is the unix timestamp, you want to go back from
- ``scrap`` number of item to be considered as scrap.


{{% notice note %}}
1. You can specify maximum of 24h to be scrapped to avoid accidents
2. (NOT IMPLEMENTED YET) If counts does not equal scrap, e.g. the count is 5 but only 2 more need to be scrapped, it will scrap exactly 2. Currently, it would ignore these 2. see also #125
3. (NOT IMPLEMENTED YET) If no counts are available for this asset, but uniqueProducts are available, they can also be marked as scrap.
{{% /notice %}}

### JSON

#### Examples

Ten items where scrapped:
```json
{
  "timestamp_ms":1589788888888,
  "scrap":10
}
```

#### Schema

```json
{
    "$schema": "http://json-schema.org/draft/2019-09/schema",
    "$id": "https://learn.umh.app/content/docs/datamodel/messages/scrapCount.json",
    "type": "object",
    "default": {},
    "title": "Root Schema",
    "required": [
        "timestamp_ms",
        "scrap"
    ],
    "properties": {
        "timestamp_ms": {
            "type": "integer",
            "default": 0,
            "minimum": 0,
            "title": "The unix timestamp you want to go back from",
            "examples": [
              1589788888888
            ]
        },
        "scrap": {
            "type": "integer",
            "default": 0,
            "minimum": 0,
            "title": "Number of items to be considered as scrap",
            "examples": [
                10
            ]
        }
    },
    "examples": [
        {
            "timestamp_ms": 1589788888888,
            "scrap": 10
        },
        {
            "timestamp_ms": 1589788888888,
            "scrap": 5
        }
    ]
}
```

## Producers

- Typically Node-RED

## Consumers

- [kafka-to-postgresql](/docs/core/kafka-to-postgresql)
