---
title: "MQTT Kafka Bridge"
content_type: microservices
description: |
    The technical documentation of the mqtt-kafka-bridge microservice,
    which transfers messages from MQTT brokers to Kafka Brokers and vice versa.
weight: 0
---

<!-- overview -->

Mqtt-kafka-bridge is a microservice that acts as a bridge between MQTT brokers
and Kafka brokers, transfering messages from one to the other and vice versa.

{{% notice note %}}
This microservice requires that the Kafka Topic `umh.v1.kafka.newTopic` exits.
This will happen automatically from version 0.9.12.
{{% /notice %}}

{{% notice tip %}}
Since version 0.9.10, it allows all raw messages, even if their content is not
in a valid JSON format.
{{% /notice %}}

## {{% heading "howitworks" %}}

Mqtt-kafka-bridge consumes topics from a message broker, translates them to
the proper format and publishes them to the other message broker.

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
| Variable name            | Description                                                                                                            | Type   | Allowed values          | Default                                           |
| ------------------------ | ---------------------------------------------------------------------------------------------------------------------- | ------ | ----------------------- | ------------------------------------------------- |
| `DEBUG_ENABLE_FGTRACE`   | Enables the use of the [fgtrace](https://github.com/felixge/fgtrace) library. Not reccomended for production           | string | `true`, `false`         | `false`                                           |
| `INSECURE_SKIP_VERIFY`   | Skip TLS certificate verification                                                                                      | `bool` | `true`, `false`         | `true`                                            |
| `KAFKA_ACCEPT_NO_ORIGIN` | Allow access to the Kafka broker without a valid x-trace                                                               | `bool` | `true`, `false`         | `false`                                           |
| `KAFKA_BASE_TOPIC`       | The Kafka base topic                                                                                                   | string | Any                     | ia                                                |
| `KAFKA_BOOTSTRAP_SERVER` | URL of the Kafka broker used, port is required                                                                         | string | Any                     | {{< resource type="service" name="kafka" >}}:9092 |
| `KAFKA_LISTEN_TOPIC`     | Kafka topic to subscribe to. Accept regex values                                                                       | string | Any                     | ^ia.+                                             |
| `KAFKA_SENDER_THREADS`   | Number of threads used to send messages to Kafka                                                                       | int    | Any                     | 1                                                 |
| `KAFKA_SSL_KEY_PASSWORD` | Key password to decode the SSL private key                                                                             | string | Any                     | ""                                                |
| `LOGGING_LEVEL`          | Defines which logging level is used, mostly relevant for developers                                                    | string | PRODUCTION, DEVELOPMENT | PRODUCTION                                        |
| `MESSAGE_LRU_SIZE`       | Size of the LRU cache used to store messages. This is used to prevent duplicate messages from being sent to Kafka.     | int    | Any                     | 100000                                            |
| `MICROSERVICE_NAME`      | Name of the microservice (used for tracing)                                                                            | string | Any                     | united-manufacturing-hub-mqttkafkabridge          |
| `MQTT_BROKER_URL`        | The MQTT broker URL                                                                                                    | string | Any                     | {{< resource type="service" name="mqtt" >}}:1883  |
| `MQTT_CERTIFICATE_NAME`  | Set to NO_CERT to allow non-encrypted MQTT access, or to USE_TLS to use TLS encryption                                 | string | USE_TLS, NO_CERT        | USE_TLS                                           |
| `MQTT_PASSWORD`          | Password for the MQTT broker                                                                                           | string | Any                     | INSECURE_INSECURE_INSECURE                        |
| `MQTT_SENDER_THREADS`    | Number of threads used to send messages to MQTT                                                                        | int    | Any                     | 1                                                 |
| `MQTT_TOPIC`             | MQTT topic to subscribe to. Accept regex values                                                                        | string | Any                     | ia/#                                              |
| `RAW_MESSSAGE_LRU_SIZE`  | Size of the LRU cache used to store raw messages. This is used to prevent duplicate messages from being sent to Kafka. | int    | Any                     | 100000                                            |
| `SERIAL_NUMBER`          | Serial number of the cluster (used for tracing)                                                                        | string | Any                     | default                                           |
{{< /table >}}
