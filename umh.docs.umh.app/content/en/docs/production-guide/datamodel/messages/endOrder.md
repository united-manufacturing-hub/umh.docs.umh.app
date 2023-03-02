+++
title = "endOrder"
description = "EndOrder messages are sent whenever a new product is produced."
+++

## Topic

MQTT: ``ia/<customerID>/<location>/<AssetID>/endOrder``

{{% notice note %}}
For Kafka just switch the `/` character with a `.`
{{% /notice %}}

## Usage

A message is sent each time a new product is produced.

## Content

| key            | data type | description                        |
|----------------|-----------|------------------------------------|
| `timestamp_ms` | `int64`   | unix timestamp of message creation |
| `order_id`     | `int64`   | current order name                 |


{{% notice warning %}}
See also notes regarding adding products and orders in [/addOrder](/docs/datamodel/messages/addorder)
{{% /notice %}}

### JSON

#### Examples

The order "test_order" was finished at the shown timestamp.

```json
{
  "order_id":"test_order",
  "timestamp_ms":1589788888888
}
```
#### Schema

TODO

## Producers

- Typically Node-RED

## Consumers

- [kafka-to-postgresql](/docs/core/kafka-to-postgresql)
