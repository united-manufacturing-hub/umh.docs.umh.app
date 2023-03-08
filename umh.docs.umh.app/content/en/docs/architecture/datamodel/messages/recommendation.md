+++
title = "recommendation"
description = "Recommendation messages are sent whenever rapid actions would quickly improve efficiency on the shop floor."
+++

## Topic

{{< tabs name="topic_structure" >}}
{{< tab name="MQTT" codelang="go" >}}
ia/<customerID>/<location>/<AssetID>/recommendation
{{< /tab >}}
{{< tab name="Kafka" codelang="go" >}}
ia.<customerID>.<location>.<AssetID>.recommendation
{{< /tab >}}
{{< /tabs >}}

## Usage

``recommendation`` are action recommendations, which require concrete and rapid action in order to quickly eliminate efficiency losses on the store floor. 

## Content

| key                    | data type | description                                                 |
|------------------------|-----------|-------------------------------------------------------------|
| `uid`                  | `string`  | UniqueID of the product                                     |
| `timestamp_ms`         | `int64`   | unix timestamp of message creation                          |
| `customer`             | `string`  | the customer ID in the data structure                       |
| `location`             | `string`  | the location in the data structure                          |
| `asset`                | `string`  | the asset ID in the data structure                          |
| `recommendationType`   | `int32`   | Name of the product                                         |
| `enabled`              | `bool`    | -                                                           |
| `recommendationValues` | `map`     | Map of values based on which this recommendation is created |
| `diagnoseTextDE`       | `string`  | Diagnosis of the recommendation in german                   |
| `diagnoseTextEN`       | `string`  | Diagnosis of the recommendation in english                  |
| `recommendationTextDE` | `string`  | Recommendation in german                                    |
| `recommendationTextEN` | `string`  | Recommendation in english                                   |


### JSON

#### Example

A recommendation for the demonstrator at the shown location has not been running for a while, so a recommendation is sent to either start the machine or specify a reason why it is not running. 

```json
{
    "UID": "43298756", 
    "timestamp_ms": 15888796894,
    "customer": "united-manufacturing-hub",
    "location": "dccaachen", 
    "asset": "DCCAachen-Demonstrator",
    "recommendationType": "1", 
    "enabled": true,
    "recommendationValues": { "Treshold": 30, "StoppedForTime": 612685 }, 
    "diagnoseTextDE": "Maschine DCCAachen-Demonstrator steht seit 612685 Sekunden still (Status: 8, Schwellwert: 30)" ,
    "diagnoseTextEN": "Machine DCCAachen-Demonstrator is not running since 612685 seconds (status: 8, threshold: 30)", 
    "recommendationTextDE":"Maschine DCCAachen-Demonstrator einschalten oder Stoppgrund auswählen.",
    "recommendationTextEN": "Start machine DCCAachen-Demonstrator or specify stop reason.", 
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
