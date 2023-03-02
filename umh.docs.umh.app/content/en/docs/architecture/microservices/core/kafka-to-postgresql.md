---
title: "Kafka to Postgresql"
content_type: microservices
description: |
    The technical documentation of the microservice kafka-to-postgresql, which consumes messages from a Kafka topic and writes them up to a PostgreSQL database.
weight: 10
---

<!-- overview -->

This microservice is responsible for taking kafka messages and inserting the payload into a Postgresql database. It is based on the topic of the kafka message and the data model defined in the [United Manufacturing Hub data model](/docs/datamodel/)
By default, it sets up two Kafka consumers, one for high throughput and one for high integrity.

{{< notice note >}}
This microservices requires that the Kafka Topic `umh.v1.kafka.newTopic` exits. In Version > 0.9.12 this will happen automatically.
{{< /notice >}}}

## {{% heading "howitworks" %}}

The graphic below shows the program flow of the microservice.

![Kafka-to-postgres-flow](/images/kafka-to-postgresql-flow.jpg)

### High throughput

This Kafka listener is usually configured to listen in on the [processValue](/docs/datamodel/messages/processvalue) topics.

### High integrity

This Kafka listener is usually configured to listen in on the other topics.
The graphic below shows the flow for an example High Integrity message

![high-integrity-data-flow](/images/HICountFlow.jpg)

<!-- body -->

## {{% heading "kuberesources" %}}

- Deployment: `{{< resource type="deployment" name="kafkatopostgresql" >}}`
- Secret: `{{< resource type="secret" name="kafkatopostgresql" >}}`

## {{% heading "configuration" %}}

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name | Description | Type | Allowed values | Default |
| ------------- | ----------- | ---- | -------------- | ------- |
| `DRY_RUN`                  | If set to true, the microservice will not write to the database                                                                          | `bool`   | true, false      | true           |
| `KAFKA_BOOTSTRAP_SERVER`   | URL of the Kafka broker used, port is required                                                                                           | `string` | all              | localhost:9092 |
| `KAFKA_SSL_KEY_PASSWORD`   | Key password to decode the SSL private key                                                                                               | `string` | any              | changeme       |
| `LOGGING_LEVEL`            | Defines which logging level is used, mostly relevant for developers. If logging level is not `DEVELOPMENT`, default logging will be used | `string` | any              | `DEVELOPMENT`  |
| `MEMORY_REQUEST`           | Memory request for the message cache                                                                                                     | `string` | any              | 128Mi          |
| `POSTGRES_DATABASE`        | The name of the PostgreSQL database                                                                                                      | `string` | any              | umh            |
| `POSTGRES_HOST`            | Hostname of the PostgreSQL database                                                                                                      | `string` | any              | localhost      |
| `POSTGRES_PASSWORD`        | The password to use for PostgreSQL connections                                                                                           | `string` | any              | changeme       |
| `POSTGRES_SSLMODE`         | If set to true, the PostgreSQL connection will use SSL                                                                                   | `string` | any              | disable        |
| `POSTGRES_USER`            | The username to use for PostgreSQL connections                                                                                           | `string` | any              | postgres       |
| `PVS_CHANNEL_SIZE`         | The size of the channel used to buffer messages for the high throughput Kafka processValueString listener. If full it will write to DB   | `int`    | any              | 1000           |
| `PVS_WRITE_TO_DB_INTERVAL` | The interval in which the high throughput Kafka processValueString listener will write to the database. This prevents high latency       | `int`    | any              | 1000           |
| `PV_CHANNEL_SIZE`          | The size of the channel used to buffer messages for the high throughput Kafka processValue listener. If full it will write to DB         | `int`    | any              | 1000           |
| `PV_WRITE_TO_DB_INTERVAL`  | The interval in which the high throughput Kafka processValue listener will write to the database. This prevents high latency             | `int`    | any              | 1000           |
| `SERIAL_NUMBER`            | Serial number of the cluster (used for tracing)                                                                                          | `string` | all              | development    |
| `MICROSERVICE_NAME`        | Name of the microservice (used for tracing)                                                                                              | `string` | all              | barcodereader  |
| `DEBUG_ENABLE_FGTRACE`     | Enables the use of the [fgtrace](https://github.com/felixge/fgtrace) library, do not enable in production                                | `string` | `true`, `1`, any | `1`            |
{{< /table >}}
