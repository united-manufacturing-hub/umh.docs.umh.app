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
| Variable name             | Description                                                                                                                             | Type   | Allowed values          | Default                                                 |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- | ------ | ----------------------- | ------------------------------------------------------- |
| `KAFKA_BROKERS`           | Specifies the URLs and required ports of Kafka brokers using the Kafka protocol.                                                        | string | Any                     | {{< resource type="service" name="kafkabroker" >}}:9092 |
| `KAFKA_HTTP_BROKERS`      | Specifies the URLs and required ports of Kafka brokers using the HTTP protocol.                                                         | string | Any                     | {{< resource type="service" name="kafkabroker" >}}:8082 |
| `LOGGING_LEVEL`           | Determines the verbosity of the logging output, primarily used for development purposes.                                                | string | PRODUCTION, DEVELOPMENT | PRODUCTION                                              |
| `POSTGRES_DATABASE`       | Designates the name of the target PostgreSQL database.                                                                                  | string | Any                     | umh_v2                                                  |
| `POSTGRES_HOST`           | Identifies the hostname for the PostgreSQL database server.                                                                             | string | Any                     | united-manufacturing-hub                                |
| `POSTGRES_LRU_CACHE_SIZE` | Determines the size of the Least Recently Used (LRU) cache for asset ID storage. This cache is optimized for minimal memory usage.      | string | Any                     | 1000                                                    |
| `POSTGRES_PASSWORD`       | Sets the password for accessing the PostgreSQL database                                                                                 | string | Any                     | changemetoo                                             |
| `POSTGRES_PORT`           | Specifies the network port for the PostgreSQL database server.                                                                          | string | Any                     | 5432                                                    |
| `POSTGRES_SSL_MODE`       | Configures the PostgreSQL connection to use SSL if set to 'true'.                                                                       | string | Any                     | require                                                 |
| `POSTGRES_USER`           | Defines the username for PostgreSQL database access.                                                                                    | string | Any                     | kafkatopostgresqlv2                                     |
| `VALUE_CHANNEL_SIZE`      | Sets the size of the channel for message storage prior to insertion. This parameter is significant for memory consumption               | string | Any                     | 10000                                                   |
| `WORKER_MULTIPLIER`       | This multiplier affects the number of workers converting Kafka messages into the PostgreSQL schema. Total workers = cores * multiplier. | string | Any                     | 16                                                      |
{{< /table >}}
