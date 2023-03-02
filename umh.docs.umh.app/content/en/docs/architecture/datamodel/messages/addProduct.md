+++
title = "addProduct"
description = "AddProduct messages are sent when a new product is produced."
+++

## Topic

MQTT: ``ia/<customerID>/<location>/<AssetID>/addProduct``

{{% notice note %}}
For Kafka just switch the `/` character with a `.`
{{% /notice %}}

## Usage

A message is sent each time a new product is produced.

## Content

| key                        | data type | description                                          |
|----------------------------|-----------|------------------------------------------------------|
| `product_id`               | `string`  | current product name                                 |
| `time_per_unit_in_seconds` | `float64` | the time it takes to produce one unit of the product |


{{% notice warning %}}
See also notes regarding adding products and orders in [/addOrder](/docs/architecture/datamodel/messages/addorder)
{{% /notice %}}

### JSON

#### Examples

A new product "Beilinger 30x15" with a cycle time of 200ms is added to the asset.
```json
{
  "product_id": "Beilinger 30x15",
  "time_per_unit_in_seconds": "0.2"
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

## Producers

- Typically Node-RED

## Consumers

- [kafka-to-postgresql](/docs/architecture/microservices/core/kafka-to-postgresql)
