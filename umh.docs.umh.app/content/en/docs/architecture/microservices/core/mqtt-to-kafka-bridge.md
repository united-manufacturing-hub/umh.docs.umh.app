+++
title = "mqtt-kafka-bridge"
menuTitle = "mqtt-kafka-bridge"
chapter = false
weight = 5
draft = false
description = "The technical documentation of the microservice mqtt-to-kafka-bridge, which transfers messages from MQTT brokers to Kafka Brokers and vice versa."
+++

mqtt-kafka-bridge is a microservice that acts as a bridge between an MQTT broker and a Kafka broker. It listens to a specified MQTT topic and forwards the messages to a specified Kafka topic.
 
## Environment variables

The table below explains the environment variables used by mqtt-kafka-bridge:

| Variable name            | Description                                                                                                                              | Type     | Possible values  | Example value                                       |
|--------------------------|------------------------------------------------------------------------------------------------------------------------------------------|----------|------------------|-----------------------------------------------------|
| `INSECURE_SKIP_VERIFY`   | Skip TLS certificate verification                                                                                                        | `bool`   | true, false      | false                                               |
| `KAFKA_ACCEPT_NO_ORIGIN` | Allow access to the Kafka broker without a valid x-trace                                                                                 | `bool`   | true, false      | false                                               |
| `KAFKA_BASE_TOPIC`       | Kafka base topic                                                                                                                         | `string` | any              | ia                                                  |
| `KAFKA_BOOTSTRAP_SERVER` | URL of the Kafka broker used, port is required                                                                                           | `string` | all              | localhost:9092                                      |
| `KAFKA_LISTEN_TOPIC`     | Kafka topic to listen in on                                                                                                              | `string` | any              | ia.+                                                |
| `KAFKA_SENDER_THREADS`   | Number of threads used to send messages to Kafka                                                                                         | `int`    | any              | 1                                                   |
| `KAFKA_SSL_KEY_PASSWORD` | Key password to decode the SSL private key                                                                                               | `string` | any              | changeme                                            |
| `LOGGING_LEVEL`          | Defines which logging level is used, mostly relevant for developers. If logging level is not `DEVELOPMENT`, default logging will be used | `string` | any              | `DEVELOPMENT`                                       |
| `MESSAGE_LRU_SIZE`       | Size of the LRU cache used to store messages. This is used to prevent duplicate messages from being sent to Kafka.                       | `int`    | any              | 1000                                                |
| `MQTT_BROKER_URL`        | The MQTT broker URL                                                                                                                      | `string` | IP, DNA name     | united-manufacturing-hub-vernemq-local-service:1883 |
| `MQTT_CERTIFICATE_NAME`  | Set to NO_CERT to allow non-encrypted MQTT access                                                                                        | `string` | any, NO_CERT     | NO_CERT                                             |
| `MQTT_PASSWORD`          | Password for the MQTT broker                                                                                                             | `string` | any              | changeme                                            |
| ``MQTT_SENDER_THREADS``  | Number of threads used to send messages to MQTT                                                                                          | `int`    | any              | 1                                                   |
| `MQTT_TOPIC`             | MQTT topic to listen in on                                                                                                               | `string` | any              | ia/#                                                |
| `MY_POD_NAME`            | Name of the docker pod, used for identification at the MQTT broker                                                                       | `string` | any              | MQTT-Kafka-Bridge                                   |
| `RAW_MESSSAGE_LRU_SIZE`  | Size of the LRU cache used to store raw messages. This is used to prevent duplicate messages from being sent to Kafka.                   | `int`    | any              | 1000                                                |
| `SERIAL_NUMBER`          | Serial number of the cluster (used for tracing)                                                                                          | `string` | all              | development                                         |
| `MICROSERVICE_NAME`      | Name of the microservice (used for tracing)                                                                                              | `string` | all              | barcodereader                                       |
| `DEBUG_ENABLE_FGTRACE`   | Enables the use of the [fgtrace](https://github.com/felixge/fgtrace) library, do not enable in production                                | `string` | `true`, `1`, any | `1`                                                 |

 ## Notes

💡This microservices requires that the Kafka Topic `umh.v1.kafka.newTopic` exits. In Version > 0.9.12 this happens automatically.

 - Starting with 0.9.10 this bridge will allow all raw messages, even if their content is not valid JSON format.
 - 0.10.0 also introduces stricter checks for topic names (They *must* now follow the datamodel).
