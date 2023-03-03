---
title: "Kafka to Postgresql"
content_type: microservices
description: |
    The technical documentation of the kafka-to-postgresql microservice,
    which consumes messages from a Kafka broker and writes them in a PostgreSQL database.
weight: 0
---

<!-- overview -->

Kafka-to-postgresql is a microservice responsible for consuming kafka messages
and inserting the payload into a Postgresql database. Take a look at the
[Datamodel](/docs/architecture/datamodel/) to see how the data is structured.

{{% notice note %}}
This microservice requires that the Kafka Topic `umh.v1.kafka.newTopic` exits. This will happen automatically from version 0.9.12.
{{% /notice %}}

## {{% heading "howitworks" %}}

By default, kafka-to-postgresql sets up two Kafka consumers, one for the
[High Integrity](#high-integrity) topics and one for the
[High Throughput](#high-throughput) topics.

The graphic below shows the program flow of the microservice.

![Kafka-to-postgres-flow](/images/kafka-to-postgresql-flow.jpg)

### High integrity

The High integrity topics are forwarded to the database in a synchronous way.
This means that the microservice will wait for the database to respond with a
non error message before committing the message to the Kafka broker.
This way, the message is garanteed to be inserted into the database, even though
it might take a while.

Most of the topics are forwarded in this mode.

The picture below shows the program flow of the high integrity mode.

![high-integrity-data-flow](/images/HICountFlow.jpg)

### High throughput

The High throughput topics are forwarded to the database in an asynchronous way.
This means that the microservice will not wait for the database to respond with
a non error message before committing the message to the Kafka broker.
This way, the message is not garanteed to be inserted into the database, but
the microservice will try to insert the message into the database as soon as
possible. This mode is used for the topics that are expected to have a high
throughput.

The topics that are forwarded in this mode are [processValue](/docs/architecture/datamodel/messages/processvalue/),
[processValueString](/docs/architecture/datamodel/messages/processvaluestring/)
and all the raw topics.

<!-- body -->

## {{% heading "kuberesources" %}}

- Deployment: `{{< resource type="deployment" name="kafkatopostgresql" >}}`
- Secret: `{{< resource type="secret" name="kafkatopostgresql" >}}`

## {{% heading "configuration" %}}

You shouldn't need to configure kafka-to-postgresql manually, as it's configured
automatically when the cluster is deployed. However, if you need to change the
configuration, you can do it by editing the `kafkatopostgresql` section in the
`values.yaml` file.

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name            | Description                                                                                                  | Type   | Allowed values          | Default                                           |
| ------------------------ | ------------------------------------------------------------------------------------------------------------ | ------ | ----------------------- | ------------------------------------------------- |
| `DEBUG_ENABLE_FGTRACE`   | Enables the use of the [fgtrace](https://github.com/felixge/fgtrace) library. Not reccomended for production | string | `true`, `false`         | `false`                                           |
| `DRY_RUN`                | If set to true, the microservice will not write to the database                                              | `bool` | `true`, `false`         | `false`                                           |
| `KAFKA_BOOTSTRAP_SERVER` | URL of the Kafka broker used, port is required                                                               | string | Any                     | {{< resource type="service" name="kafka" >}}:9092 |
| `KAFKA_SSL_KEY_PASSWORD` | Key password to decode the SSL private key                                                                   | string | Any                     | ""                                                |
| `LOGGING_LEVEL`          | Defines which logging level is used, mostly relevant for developers                                          | string | PRODUCTION, DEVELOPMENT | PRODUCTION                                        |
| `MEMORY_REQUEST`         | Memory request for the message cache                                                                         | string | Any                     | 50Mi                                              |
| `MICROSERVICE_NAME`      | Name of the microservice (used for tracing)                                                                  | string | Any                     | united-manufacturing-hub-kafkatopostgresql        |
| `POSTGRES_DATABASE`      | The name of the PostgreSQL database                                                                          | string | Any                     | factoryinsight                                    |
| `POSTGRES_HOST`          | Hostname of the PostgreSQL database                                                                          | string | Any                     | united-manufacturing-hub                          |
| `POSTGRES_PASSWORD`      | The password to use for PostgreSQL connections                                                               | string | Any                     | changeme                                          |
| `POSTGRES_SSLMODE`       | If set to true, the PostgreSQL connection will use SSL                                                       | string | Any                     | require                                           |
| `POSTGRES_USER`          | The username to use for PostgreSQL connections                                                               | string | Any                     | factoryinsight                                    |
{{< /table >}}
