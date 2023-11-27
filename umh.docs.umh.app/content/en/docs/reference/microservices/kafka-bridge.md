---
title: "Kafka Bridge"
content_type: microservices
description: |
    The technical documentation of the kafka-bridge microservice,
    which acts as a communication bridge between two Kafka brokers.
weight: 0
---

<!-- overview -->

<!-- body -->

## {{% heading "kuberesources" %}}

- Deployment: `{{< resource type="deployment" name="kafkabridge" >}}`
- Secret:
  - Local broker: `{{< resource type="secret" name="kafkabridge-local" >}}`
  - Remote broker: `{{< resource type="secret" name="kafkabridge-remote" >}}`

## {{% heading "configuration" %}}

You can configure the kafka-bridge microservice by setting the following values
in the [`_000_commonConfig.kafkaBridge`](/docs/architecture/helm-chart/#kafka-bridge)
section of the Helm chart values file.

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

### Topic Map schema

The topic map is a list of objects, each object represents a topic (or a set of
topics) that should be forwarded. The following JSON schema describes the
structure of the topic map:

{{< codenew file="topic-map-schema.json" >}}

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name                   | Description                                                                                               | Type   | Allowed values                 | Default                                                 |
| ------------------------------- | --------------------------------------------------------------------------------------------------------- | ------ | ------------------------------ | ------------------------------------------------------- |
| `DEBUG_ENABLE_FGTRACE`          | Enables the use of the [fgtrace](https://github.com/felixge/fgtrace) library, do not enable in production | string | `true`, `false`                | `false`                                                 |
| `KAFKA_GROUP_ID_SUFFIX`         | Identifier appended to the kafka group ID, usually a serial number                                        | string | Any                            | defalut                                                 |
| `KAFKA_SSL_KEY_PASSWORD_LOCAL`  | Password for the SSL key pf the local broker                                                              | string | Any                            | ""                                                      |
| `KAFKA_SSL_KEY_PASSWORD_REMOTE` | Password for the SSL key of the remote broker                                                             | string | Any                            | ""                                                      |
| `KAFKA_TOPIC_MAP`               | A json map of the kafka topics should be forwarded                                                        | JSON   | [See below](#topic-map-schema) | {}                                                      |
| `KAKFA_USE_SSL`                 | Enables the use of SSL for the kafka connection                                                           | string | `true`, `false`                | `false`                                                 |
| `LOCAL_KAFKA_BOOTSTRAP_SERVER`  | URL of the local kafka broker, port is required                                                           | string | Any valid URL                  | {{< resource type="service" name="kafkabroker" >}}:9092 |
| `LOGGING_LEVEL`                 | Defines which logging level is used, mostly relevant for developers.                                      | string | PRODUCTION, DEVELOPMENT        | PRODUCTION                                              |
| `MICROSERVICE_NAME`             | Name of the microservice (used for tracing)                                                               | string | Any                            | united-manufacturing-hub-kafka-bridge                   |
| `REMOTE_KAFKA_BOOTSTRAP_SERVER` | URL of the remote kafka broker                                                                            | string | Any valid URL                  | ""                                                      |
| `SERIAL_NUMBER`                 | Serial number of the cluster (used for tracing)                                                           | string | Any                            | defalut                                                 |

{{< /table >}}
