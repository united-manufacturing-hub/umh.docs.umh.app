---
title: "Kafka to Postgresql v2"
content_type: reference
description: |
    The technical documentation of the kafka-to-postgresql-v2 microservice,
    which consumes messages from a Kafka broker and writes them in a PostgreSQL
    database by following the UMH data model v2.
weight: 0
---

<!-- overview -->

## {{% heading "kuberesources" %}}

- Deployment: `{{< resource type="deployment" name="kafkatopostgresqlv2" >}}`

## {{% heading "configuration" %}}

You shouldn't need to configure kafka-to-postgresql-v2 manually, as it's configured
automatically when the cluster is deployed. However, if you need to change the
configuration, you can do it by editing the `kafkatopostgresqlv2` section of the Helm
chart values file.

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name             | Description                                                                                                                    | Type   | Allowed values          | Default                                                 |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------ | ------ | ----------------------- | ------------------------------------------------------- |
| `KAFKA_BROKERS`           | URLs of the Kafka brokers used, port is required. Kafka protocol only                                                          | string | Any                     | {{< resource type="service" name="kafkabroker" >}}:9092 |
| `KAFKA_HTTP_BROKERS`      | URLs of the Kafka brokers used, port is required. HTTP protocol only                                                           | string | Any                     | {{< resource type="service" name="kafkabroker" >}}:8082 |
| `POSTGRES_DATABASE`       | The name of the PostgreSQL database                                                                                            | string | Any                     | umh_v2                                                  |
| `POSTGRES_HOST`           | Hostname of the PostgreSQL database                                                                                            | string | Any                     | united-manufacturing-hub                                |
| `POSTGRES_LRU_CACHE_SIZE` | Size of the LRU cache used to store the last inserted messages                                                                 | string | Any                     | 1000                                                    |
| `POSTGRES_PASSWORD`       | The password to use for PostgreSQL connections                                                                                 | string | Any                     | changemetoo                                             |
| `POSTGRES_PORT`           | Port of the PostgreSQL database                                                                                                | string | Any                     | 5432                                                    |
| `POSTGRES_SSLMODE`        | If set to true, the PostgreSQL connection will use SSL                                                                         | string | Any                     | require                                                 |
| `POSTGRES_USER`           | The username to use for PostgreSQL connections                                                                                 | string | Any                     | kafkatopostgresqlv2                                     |
| `VALUE_CHANNEL_SIZE`      | Size of the channel used to store the messages to insert                                                                       | string | Any                     | 10000                                                   |
| `WORKER_MULTIPLIER`       | The multiplier of the number of goroutines. The total number of goroutines is determined by the CPU count times the multiplier | string | Any                     | 16                                                      |
| `LOGGING_LEVEL`           | Defines which logging level is used, mostly relevant for developers                                                            | string | PRODUCTION, DEVELOPMENT | PRODUCTION                                              |
{{< /table >}}
