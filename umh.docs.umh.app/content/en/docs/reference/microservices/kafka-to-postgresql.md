---
title: "Kafka to Postgresql"
content_type: microservices
description: |
    The technical documentation of the kafka-to-postgresql microservice,
    which consumes messages from a Kafka broker and writes them in a PostgreSQL database.
weight: 0
---

<!-- overview -->

<!-- body -->

## {{% heading "kuberesources" %}}

- Deployment: `{{< resource type="deployment" name="kafkatopostgresql" >}}`
- Secret: `{{< resource type="secret" name="kafkatopostgresql" >}}`

## {{% heading "configuration" %}}

You shouldn't need to configure kafka-to-postgresql manually, as it's configured
automatically when the cluster is deployed. However, if you need to change the
configuration, you can do it by editing the `kafkatopostgresql` section of the Helm
chart values file.

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name            | Description                                                                                                  | Type   | Allowed values          | Default                                                 |
| ------------------------ | ------------------------------------------------------------------------------------------------------------ | ------ | ----------------------- | ------------------------------------------------------- |
| `DEBUG_ENABLE_FGTRACE`   | Enables the use of the [fgtrace](https://github.com/felixge/fgtrace) library. Not recommended for production | string | `true`, `false`         | `false`                                                 |
| `DRY_RUN`                | If set to true, the microservice will not write to the database                                              | `bool` | `true`, `false`         | `false`                                                 |
| `KAFKA_BOOTSTRAP_SERVER` | URL of the Kafka broker used, port is required                                                               | string | Any                     | {{< resource type="service" name="kafkabroker" >}}:9092 |
| `KAFKA_SSL_KEY_PASSWORD` | Key password to decode the SSL private key                                                                   | string | Any                     | ""                                                      |
| `LOGGING_LEVEL`          | Defines which logging level is used, mostly relevant for developers                                          | string | PRODUCTION, DEVELOPMENT | PRODUCTION                                              |
| `MEMORY_REQUEST`         | Memory request for the message cache                                                                         | string | Any                     | 50Mi                                                    |
| `MICROSERVICE_NAME`      | Name of the microservice (used for tracing)                                                                  | string | Any                     | united-manufacturing-hub-kafkatopostgresql              |
| `POSTGRES_DATABASE`      | The name of the PostgreSQL database                                                                          | string | Any                     | factoryinsight                                          |
| `POSTGRES_HOST`          | Hostname of the PostgreSQL database                                                                          | string | Any                     | united-manufacturing-hub                                |
| `POSTGRES_PASSWORD`      | The password to use for PostgreSQL connections                                                               | string | Any                     | changeme                                                |
| `POSTGRES_SSLMODE`       | If set to true, the PostgreSQL connection will use SSL                                                       | string | Any                     | require                                                 |
| `POSTGRES_USER`          | The username to use for PostgreSQL connections                                                               | string | Any                     | factoryinsight                                          |
{{< /table >}}
