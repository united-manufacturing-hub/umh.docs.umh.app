---
title: "Kafka Bridge"
content_type: microservices
description: |
    The technical documentation of the microservice kafka-bridge, which acts as a communication bridge between two Kafka brokers.
weight: 10
---

<!-- overview -->

Kafka-bridge is a microservice that connects two Kafka brokers and forwards
messages between them. If is used when having one or multiple edge devices and a
central server.

## {{% heading "howitworks" %}}

This microservice provides at-least-once guarantees, by manually committing the
offset of the message that was processed.

<!-- body -->

## {{% heading "kuberesources" %}}

- Deployment: `{{< resource type="deployment" name="kafkabridge" >}}`
- Service:
  - Internal ClusterIP: `{{< resource type="service" name="" >}}` at
    port 80
  - External LoadBalancer: `{{< resource type="service" name="" >}}` at
    port 80
- ConfigMap: `{{< resource type="configmap" name="" >}}`
- Secret:
  - Local broker: `{{< resource type="secret" name="kafkabridge-local" >}}`
  - Remote broker: `{{< resource type="secret" name="kafkabridge-remote" >}}}}`

## {{% heading "configuration" %}}

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name                   | Description                                                                                               | Type   | Allowed values                 | Default                                           |
| ------------------------------- | --------------------------------------------------------------------------------------------------------- | ------ | ------------------------------ | ------------------------------------------------- |
| `DEBUG_ENABLE_FGTRACE`          | Enables the use of the [fgtrace](https://github.com/felixge/fgtrace) library, do not enable in production | string | `true`, `false`                | `false`                                           |
| `KAFKA_GROUP_ID_SUFFIX`         | Identifier appended to the kafka group ID, usually a serial number                                        | string | Any                            | defalut                                           |
| `KAFKA_SSL_KEY_PASSWORD_LOCAL`  | Password for the SSL key pf the local broker                                                              | string | Any                            | ""                                                |
| `KAFKA_SSL_KEY_PASSWORD_REMOTE` | Password for the SSL key of the remote broker                                                             | string | Any                            | ""                                                |
| `KAFKA_TOPIC_MAP`               | A json map of the kafka topics should be forwarded                                                        | JSON   | [See below](#topic-map-schema) | {}                                                |
| `KAKFA_USE_SSL`                 | Enables the use of SSL for the kafka connection                                                           | string | `true`, `false`                | `false`                                           |
| `LOCAL_KAFKA_BOOTSTRAP_SERVER`  | URL of the local kafka broker, port is required                                                           | string | Any valid URL                  | {{< resource type="service" name="kafka" >}}:9092 |
| `LOGGING_LEVEL`                 | Defines which logging level is used, mostly relevant for developers.                                      | string | PRODUCTION, DEVELOPMENT        | PRODUCTION                                        |
| `MICROSERVICE_NAME`             | Name of the microservice (used for tracing)                                                               | string | Any                            | united-manufacturing-hub-kafka-bridge             |
| `REMOTE_KAFKA_BOOTSTRAP_SERVER` | URL of the remote kafka broker                                                                            | string | Any valid URL                  | ""                                                |
| `SERIAL_NUMBER`                 | Serial number of the cluster (used for tracing)                                                           | string | Any                            | defalut                                           |

{{< /table >}}

### Topic Map Schema

The example map would sync every non processValue topic from both brokers, and
also send the processValue messages to the remote broker.

```json
{
    "$schema": "http://json-schema.org/draft-07/schema",
    "type": "array",
    "title": "Kafka Topic Map",
    "description": "This schema validates valid Kafka topic maps.",
    "default": [],
    "examples": [
      [
        {
          "name":"HighIntegrity",
          "topic":"^ia\\..+\\..+\\..+\\.(?!processValue).+$",
          "bidirectional":false,
          "send_direction":"to_remote"
        }
      ],
      [
        {
          "name":"HighIntegrity",
          "topic":"^ia\\..+\\..+\\..+\\.(?!processValue).+$",
          "bidirectional":true
        },
        {
          "name":"HighThroughput",
          "topic":"^ia\\..+\\..+\\..+\\.(processValue).*$",
          "bidirectional":false,
          "send_direction":"to_remote"
        }
      ]
    ],
    "additionalItems": true,
    "items": {
        "$id": "#/items",
        "anyOf": [
            {
                "$id": "#/items/anyOf/0",
                "type": "object",
                "title": "Unidirectional Kafka Topic Map with send direction",
                "description": "This schema validates entries, that are unidirectional and have a send direction.",
                "default": {},
                "examples": [
                    {
                        "name": "HighIntegrity",
                        "topic": "^ia\\..+\\..+\\..+\\.(?!processValue).+$",
                        "bidirectional": false,
                        "send_direction": "to_remote"
                    }
                ],
                "required": [
                    "name",
                    "topic",
                    "bidirectional",
                    "send_direction"
                ],
                "properties": {
                    "name": {
                        "$id": "#/items/anyOf/0/properties/name",
                        "type": "string",
                        "title": "Entry Name",
                        "description": "Name of the map entry, only used for logging & tracing.",
                        "default": "",
                        "examples": [
                            "HighIntegrity"
                        ]
                    },
                    "topic": {
                        "$id": "#/items/anyOf/0/properties/topic",
                        "type": "string",
                        "title": "The topic to listen on",
                        "description": "The topic to listen on, this can be a regular expression.",
                        "default": "",
                        "examples": [
                            "^ia\\..+\\..+\\..+\\.(?!processValue).+$"
                        ]
                    },
                    "bidirectional": {
                        "$id": "#/items/anyOf/0/properties/bidirectional",
                        "type": "boolean",
                        "title": "Is the transfer bidirectional?",
                        "description": "When set to true, the bridge will consume and produce from both brokers",
                        "default": false,
                        "examples": [
                            false
                        ]
                    },
                    "send_direction": {
                        "$id": "#/items/anyOf/0/properties/send_direction",
                        "type": "string",
                        "title": "Send direction",
                        "description": "Can be either 'to_remote' or 'to_local'",
                        "default": "",
                        "examples": [
                            "to_remote",
                            "to_local"
                        ]
                    }
                },
                "additionalProperties": true
            },
            {
                "$id": "#/items/anyOf/1",
                "type": "object",
                "title": "Bi-directional Kafka Topic Map with send direction",
                "description": "This schema validates entries, that are bi-directional.",
                "default": {},
                "examples": [
                    {
                        "name": "HighIntegrity",
                        "topic": "^ia\\..+\\..+\\..+\\.(?!processValue).+$",
                        "bidirectional": true
                    }
                ],
                "required": [
                    "name",
                    "topic",
                    "bidirectional"
                ],
                "properties": {
                    "name": {
                        "$id": "#/items/anyOf/1/properties/name",
                        "type": "string",
                        "title": "Entry Name",
                        "description": "Name of the map entry, only used for logging & tracing.",
                        "default": "",
                        "examples": [
                            "HighIntegrity"
                        ]
                    },
                    "topic": {
                        "$id": "#/items/anyOf/1/properties/topic",
                        "type": "string",
                        "title": "The topic to listen on",
                        "description": "The topic to listen on, this can be a regular expression.",
                        "default": "",
                        "examples": [
                            "^ia\\..+\\..+\\..+\\.(?!processValue).+$"
                        ]
                    },
                    "bidirectional": {
                        "$id": "#/items/anyOf/1/properties/bidirectional",
                        "type": "boolean",
                        "title": "Is the transfer bidirectional?",
                        "description": "When set to true, the bridge will consume and produce from both brokers",
                        "default": false,
                        "examples": [
                            true
                        ]
                    }
                },
                "additionalProperties": true
            }
        ]
    },
    "examples": [
   {
      "name":"HighIntegrity",
      "topic":"^ia\\..+\\..+\\..+\\.(?!processValue).+$",
      "bidirectional":true
   },
   {
      "name":"HighThroughput",
      "topic":"^ia\\..+\\..+\\..+\\.(processValue).*$",
      "bidirectional":false,
      "send_direction":"to_remote"
   }
]
}
```

Inside kubernetes values.yaml you can a normal yaml map to do the configuration.

```yaml
  kafkaBridge:
    enabled: true
    remotebootstrapServer: ""
    topicmap:
      - bidirectional: false
        name: HighIntegrity
        send_direction: to_remote
        topic: ^ia\..+\..+\..+\.((addMaintenanceActivity)|(addOrder)|(addParentToChild)|(addProduct)|(addShift)|(count)|(deleteShiftByAssetIdAndBeginTimestamp)|(deleteShiftById)|(endOrder)|(modifyProducedPieces)|(modifyState)|(productTag)|(productTagString)|(recommendation)|(scrapCount)|(startOrder)|(state)|(uniqueProduct)|(scrapUniqueProduct))$
      - bidirectional: false
        name: HighThroughput
        send_direction: to_remote
        topic: ^ia\..+\..+\..+\.(processValue).*$
```
