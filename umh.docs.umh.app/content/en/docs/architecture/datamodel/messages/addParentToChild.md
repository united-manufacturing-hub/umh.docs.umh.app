+++
title = "addParentToChild"
description = "AddParentToChild messages are sent when child products are added to a parent product."
+++

## Topic

{{< tabs name="topic_structure" >}}
{{< tab name="MQTT" codelang="go" >}}
ia/<customerID>/<location>/<AssetID>/addParentToChild
{{< /tab >}}
{{< tab name="Kafka" codelang="go" >}}
ia.<customerID>.<location>.<AssetID>.addParentToChild
{{< /tab >}}
{{< /tabs >}}

## Usage

This message can be emitted to add a child product to a parent product.
It can be sent multiple times, if a parent product is split up into multiple child's or multiple parents are combined into one child. One example for this if multiple parts are assembled to a single product. 

## Content

| key            | data type | description                             |
|----------------|-----------|-----------------------------------------|
| `timestamp_ms` | `int64`   | unix timestamp you want to go back from |
| `childAID`     | `string`  | the AID of the child product            |
| `parentAID`    | `string`  | the AID of the parent product           |


### JSON

#### Examples

A parent is added to a child:
```json
{
  "timestamp_ms":1589788888888,
  "childAID":"23948723489",
  "parentAID":"4329875"
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
        "timestamp_ms",
        "childAID",
        "parentAID"
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
        "childAID": {
            "type": "string",
            "default": "",
            "title": "The AID of the child product",
            "examples": [
              "23948723489"
            ]
        },
        "parentAID": {
            "type": "string",
            "default": "",
            "title": "The AID of the parent product",
            "examples": [
              "4329875"
            ]
        }
    },
    "examples": [
        {
            "timestamp_ms":1589788888888,
            "childAID":"23948723489",
            "parentAID":"4329875"
        },
        {
            "timestamp_ms":1589788888888,
            "childAID":"TestChild",
            "parentAID":"TestParent"
        }
    ]
}
```

## Producers

- Typically Node-RED

## Consumers

- [kafka-to-postgresql](/docs/architecture/microservices/core/kafka-to-postgresql)
