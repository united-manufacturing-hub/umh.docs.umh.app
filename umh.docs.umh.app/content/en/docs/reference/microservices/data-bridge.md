---
title: "Data Bridge"
content_type: reference
description: |
    The technical documentation of the data-bridge microservice,
    which transfers data between two Kafka or MQTT brokers, tranforming
    the data following the UNS data model.
weight: 0
---

<!-- overview -->

<!-- body -->

## {{% heading "kuberesources" %}}

- Deployment: `{{< resource type="deployment" name="databridge" >}}`
- Secret: `{{< resource type="secret" name="databridge-mqtt" >}}`

## {{% heading "configuration" %}}

You shouldn't need to configure the environment variables directly, as they are
set by the Helm chart. If you need to change them, you can do so by editing the
values in the Helm chart.

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name        | Description                                                                                                                                                   | Type   | Allowed values          | Default                             |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------ | ----------------------- | ----------------------------------- |
| `BROKER_A`           | The address of the source broker.                                                                                                                             | string | Any                     | ""                                  |
| `BROKER_B`           | The address of the destination broker.                                                                                                                        | string | Any                     | ""                                  |
| `LOGGING_LEVEL`      | The logging level to use.                                                                                                                                     | string | PRODUCTION, DEVELOPMENT | PRODUCTION                          |
| `MESSAGE_LRU_SIZE`   | The size of the LRU cache used to avoid message looping. Only used with MQTT brokers                                                                          | int    | Any                     | 1000000                             |
| `MICROSERVICE_NAME`  | Name of the microservice. Used for tracing.                                                                                                                   | string | Any                     | united-manufacturing-hub-databridge |
| `MQTT_ENABLE_TLS`    | Whether to enable TLS for the MQTT connection.                                                                                                                | bool   | `true`, `false`         | false                               |
| `MQTT_PASSWORD`      | The password to use for the MQTT connection.                                                                                                                  | string | Any                     | ""                                  |
| `PARTITIONS`         | The number of partitions to use for the destination topic. Only used if the destination broker is Kafka.                                                      | int    | Greater than 0          | 6                                   |
| `POD_NAME`           | Name of the pod. Used for tracing.                                                                                                                            | string | Any                     | united-manufacturing-hub-databridge |
| `REPLICATION_FACTOR` | The replication factor to use for the destination topic. Only used if the destination broker is Kafka.                                                        | int    | Odd integer             | 3                                   |
| `SERIAL_NUMBER`      | Serial number of the cluster. Used for tracing.                                                                                                               | string | Any                     | default                             |
| `SPLIT`              | The nth part of the topic to use as the message key. If the topic is `umh/v1/acme/anytown/foo/bar`, and `SPLIT` is 4, then the message key will be `foo.bar`  | int    | Greater than 3          | -1                                  |
| `TOPIC`              | The topic to subscribe to. Can be in either MQTT or Kafka form. Wildcards (`#` for MQTT, `.*` for Kafka) are allowed in order to subscribe to multiple topics | string | Any                     | ""                                  |
{{< /table >}}
