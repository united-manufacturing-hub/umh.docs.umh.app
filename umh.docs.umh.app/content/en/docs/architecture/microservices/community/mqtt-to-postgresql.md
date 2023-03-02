---
title: "Mqtt-to-Postgresql"
content_type: task
description: |
    This page has the technical documentation of the microservice mqtt-to-postgresql, which subscribes to an MQTT broker and stores messages in a PostgreSQL or timescaleDB database.
weight: 4000
---

{{% notice tip %}}
If you landed here from Google, you probably might want to check out either the [architecture of the United Manufacturing Hub](/docs/architecture/) (to understand how we store messages efficiently from MQTT / Kafka in our PostgreSQL / TimescaleDB), or our knowledge section for more information on the general topics of IT, OT and IIoT.
{{% /notice %}}

{{% notice warning %}}
This microservice is deprecated and should not be used anymore in production. Please use kafka-to-postgresql instead.
{{% /notice %}}

## How it works

mqtt-to-postgresql is a microservice that subscribes to the MQTT broker (in the stack this is HiveMQ), parses incoming messages on the topic "ia/#" and stores them in the PostgreSQL / TimescaleDB databases (if they are in the correct data model).

The diagram below illustrates the abstract flow of an incoming MQTT message:



## Configuration

The table below explains the environment variables used by mqtt-to-postgresql:

| Variable name       | Description                                                                                                                              | Type     | Possible values                                                      | Example value                                                                       |
|---------------------|------------------------------------------------------------------------------------------------------------------------------------------|----------|----------------------------------------------------------------------|-------------------------------------------------------------------------------------|
| `LOGGING_LEVEL`     | Defines which logging level is used, mostly relevant for developers. If logging level is not `DEVELOPMENT`, default logging will be used | `string` | any                                                                  | `DEVELOPMENT`                                                                       |
| `CERTIFICATE_NAME`  | Set to NO_CERT to allow non-encrypted MQTT access                                                                                        | `string` | any, NO_CERT                                                         | NO_CERT                                                                             |
| `BROKER_URL`        | The MQTT broker URL                                                                                                                      | `string` | IP, DNA name                                                         | united-manufacturing-hub-vernemq-local-service:1883                                 |
| `POSTGRES_HOST`     | Database DNS name or IP address of the PostgreSQL database                                                                               | `string` | all DNS names or IP addresses                                        | united-manufacturing-hub                                                            |
| `POSTGRES_USER`     | The username to use for PostgreSQL connections                                                                                           | `string` | an existing user with access to the specified database in postgresql | factoryinsight                                                                      |
| `POSTGRES_PASSWORD` | The password to use for PostgreSQL connections                                                                                           | `string` | all                                                                  | changeme                                                                            |
| `POSTGRES_DATABASE` | The name of the PostgreSQL database                                                                                                      | `string` | an existing database name                                            | factoryinsight                                                                      |
| `DRY_RUN`           | If set to true, the microservice will not write to the database                                                                          | `bool`   | true, false                                                          | true                                                                                |
| `REDIS_URI`         | URI for accessing redis sentinel                                                                                                         | `string` | all valid URIs                                                       | united-manufacturing-hub-redis-node-0.united-manufacturing-hub-redis-headless:26379 |
| `REDIS_URI2`        | Backup URI for accessing redis sentinel                                                                                                  | `string` | all valid URIs                                                       | united-manufacturing-hub-redis-node-0.united-manufacturing-hub-redis-headless:26379 |
| `REDIS_URI3`        | Backup URI for accessing redis sentinel                                                                                                  | `string` | all valid URIs                                                       | united-manufacturing-hub-redis-node-0.united-manufacturing-hub-redis-headless:26379 |
| `REDIS_PASSWORD`    | Password for accessing redis sentinel                                                                                                    | `string` | all                                                                  | changeme                                                                            |
| `MY_POD_NAME`       | The pod name. Used for tracing, logging and MQTT client ID                                                                               | `string` | all                                                                  | app-factoryinput-0                                                                  |  
| `MQTT_TOPIC`        | MQTT topic to listen in on                                                                                                               | `string` | any                                                                  | ia/#                                                                                |
