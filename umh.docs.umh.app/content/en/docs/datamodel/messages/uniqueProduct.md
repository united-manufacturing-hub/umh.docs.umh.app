---
title: "uniqueProduct"
description: "UniqueProduct messages are sent whenever a unique product was produced or modified."
aliases:
  - /docs/architecture/datamodel/messages/uniqueproduct/
---

## Topic

{{< tabs name="topic_structure" >}}
{{< tab name="MQTT" codelang="none" >}}
ia/<customerID>/<location>/<AssetID>/uniqueProduct
{{< /tab >}}
{{< tab name="Kafka" codelang="none" >}}
ia.<customerID>.<location>.<AssetID>.uniqueProduct
{{< /tab >}}
{{< /tabs >}}

## Usage

A message is sent here each time a product has been produced or modified. A modification can take place, for example, due to a downstream quality control.

There are two cases of when to send a message under the uniqueProduct topic:

* The exact product doesn't already have a UID (-> This is the case, if it has not been produced at an asset incorporated in the digital shadow). Specify a space holder asset = “storage” in the MQTT message for the uniqueProduct topic.
* The product was produced at the current asset (it is now different from before, e.g. after machining or after something was screwed in). The newly produced product is always the “child” of the process. Products it was made out of are called the “parents”.

## Content

| key  | data type  | description  |
|---|---|---|
| `begin_timestamp_ms` | `int64` | unix timestamp of start time|
| `end_timestamp_ms` | `int64` |unix timestamp of completion time|
| `product_id` | `string` | product ID of the currently produced product |
| `isScrap` | `bool` |*optional* information whether the current product is  of poor quality and will be sorted out. Is considered `false` if not specified.|
| `uniqueProductAlternativeID` | `string` | alternative ID of the product |


### JSON

#### Example

The processing of product "Beilinger 30x15" with the AID 216381 started and ended at the designated timestamps. It is of low quality and due to be scrapped. 

```json
{
  "begin_timestamp_ms":1589788888888,
  "end_timestamp_ms":1589788893729,
  "product_id":"Beilinger 30x15",
  "isScrap":true,
  "uniqueProductAlternativeID":"216381"
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
