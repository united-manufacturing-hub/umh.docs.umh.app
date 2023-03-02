+++
title = "processValue"
description = "ProcessValue messages are sent whenever a custom process value with unique name has been prepared. The value is numerical."
+++

## Topic

MQTT: ``ia/<customerID>/<location>/<AssetID>/processValue``

or alternatively: ``ia/<customerID>/<location>/<AssetID>/processValue/<tagName>``

{{% notice note %}}
For Kafka just switch the `/` character with a `.`.

If you have a lot of processValues, we'd recommend not using the `/processValue` as topic, but to append the tag name as well, e.g., `/processValue/energyConsumption`. This will structure it better for usage in MQTT Explorer or for data processing only certain processValues. 

For automatic data storage in [kafka-to-postgresql](/docs/architecture/microservices/core/kafka-to-postgresql/) both will work fine as long as the payload is correct.
{{% /notice %}}

{{% notice warning %}}

Please be aware that the values may only be int or float, other character are not valid, so make sure there is no quotation marks or anything
sneaking in there. Also be cautious of using the JavaScript ToFixed() function, as it is converting a float into a string.

{{% /notice %}}

## Usage

A message is sent each time a process value has been prepared. The key has a unique name.

## Content

| key            | data type            | description                                  |
|----------------|----------------------|----------------------------------------------|
| `timestamp_ms` | `int64`              | unix timestamp of message creation           | 
| `<valuename>`  | `int64` or `float64` | Represents a process value, e.g. temperature |



{{% notice note %}}
Pre 0.10.0:
As `<valuename>` is either of type ´int64´ or ´float64´, you cannot use booleans. Convert to integers as needed; e.g., true = "1", false = "0"

Post 0.10.0:
`<valuename>` will be converted, even if it is a boolean value.
Check [integer literals](https://go.dev/ref/spec#Integer_literals) and [floating-point literals](https://go.dev/ref/spec#Floating-point_literals) for other valid values.
{{% /notice %}}

### JSON

#### Example

At the shown timestamp the custom process value "energyConsumption" had a readout of 123456.

```json
{
    "timestamp_ms": 1588879689394, 
    "energyConsumption": 123456
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
