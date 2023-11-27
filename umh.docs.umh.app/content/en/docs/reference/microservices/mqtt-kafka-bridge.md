---
title: "MQTT Kafka Bridge"
content_type: reference
description: |
    The technical documentation of the mqtt-kafka-bridge microservice,
    which transfers messages from MQTT brokers to Kafka Brokers and vice versa.
weight: 0
---

<!-- overview -->

<!-- body -->

## {{% heading "kuberesources" %}}

- Deployment: `{{< resource type="deployment" name="mqttkafkabridge" >}}`
- Secret:
  - Kafka: `{{< resource type="secret" name="mqttkafkabridge-kafka" >}}`
  - MQTT: `{{< resource type="secret" name="mqttkafkabridge-mqtt" >}}`

## {{% heading "configuration" %}}

You shouldn't need to configure mqtt-kafka-bridge manually, as it's configured
automatically when the cluster is deployed. However, if you need to change the
configuration, you can do it by editing the `mqttkafkabridge` section of the Helm
chart values file.

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name            | Description                                                                                                            | Type   | Allowed values          | Default                                                               |
| ------------------------ | ---------------------------------------------------------------------------------------------------------------------- | ------ | ----------------------- | --------------------------------------------------------------------- |
| `DEBUG_ENABLE_FGTRACE`   | Enables the use of the [fgtrace](https://github.com/felixge/fgtrace) library. Not recommended for production           | string | `true`, `false`         | `false`                                                               |
| `INSECURE_SKIP_VERIFY`   | Skip TLS certificate verification                                                                                      | `bool` | `true`, `false`         | `true`                                                                |
| `KAFKA_BASE_TOPIC`       | The Kafka base topic                                                                                                   | string | Any                     | ia                                                                    |
| `KAFKA_BOOTSTRAP_SERVER` | URL of the Kafka broker used, port is required                                                                         | string | Any                     | {{< resource type="service" name="kafkabroker" >}}:9092               |
| `KAFKA_LISTEN_TOPIC`     | Kafka topic to subscribe to. Accept regex values                                                                       | string | Any                     | ^ia.+                                                                 |
| `KAFKA_SENDER_THREADS`   | Number of threads used to send messages to Kafka                                                                       | int    | Any                     | 1                                                                     |
| `LOGGING_LEVEL`          | Defines which logging level is used, mostly relevant for developers                                                    | string | PRODUCTION, DEVELOPMENT | PRODUCTION                                                            |
| `MESSAGE_LRU_SIZE`       | Size of the LRU cache used to store messages. This is used to prevent duplicate messages from being sent to Kafka.     | int    | Any                     | 100000                                                                |
| `MICROSERVICE_NAME`      | Name of the microservice (used for tracing)                                                                            | string | Any                     | united-manufacturing-hub-mqttkafkabridge                              |
| `MQTT_BROKER_URL`        | The MQTT broker URL                                                                                                    | string | Any                     | {{< resource type="service" name="mqttbroker" >}}:1883                |
| `MQTT_CERTIFICATE_NAME`  | Set to NO_CERT to allow non-encrypted MQTT access, or to USE_TLS to use TLS encryption                                 | string | USE_TLS, NO_CERT        | USE_TLS                                                               |
| `MQTT_PASSWORD`          | Password for the MQTT broker                                                                                           | string | Any                     | INSECURE_INSECURE_INSECURE                                            |
| `MQTT_SENDER_THREADS`    | Number of threads used to send messages to MQTT                                                                        | int    | Any                     | 1                                                                     |
| `MQTT_TOPIC`             | MQTT topic to subscribe to. Accept regex values                                                                        | string | Any                     | ia/#                                                                  |
| `POD_NAME`               | Name of the pod. Used for tracing                                                                                      | string | Any                     | {{< resource type="deployment" name="mqttkafkabridge" >}}-_Random-ID_ |
| `RAW_MESSSAGE_LRU_SIZE`  | Size of the LRU cache used to store raw messages. This is used to prevent duplicate messages from being sent to Kafka. | int    | Any                     | 100000                                                                |
| `SERIAL_NUMBER`          | Serial number of the cluster (used for tracing)                                                                        | string | Any                     | default                                                               |
{{< /table >}}
