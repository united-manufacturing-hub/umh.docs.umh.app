---
title: "Kafka Init"
content_type: microservices
description: |
    The technical documentation of the microservice kafka-init, which is called before certain message consumers are allowed to access some topics.
weight: 10
---

<!-- overview -->

## {{% heading "howitworks" %}}

TODO

<!-- body -->

## {{% heading "kuberesources" %}}

This is the init container of all the resources related to kafka.

## {{% heading "configuration" %}}

### {{% heading "envvars" %}}

Since this is an init container, the defalut values differ from one microservice
to another.

{{< table caption="Environment variables" >}}
| Variable name            | Description                                                                                               | Type   | Allowed values          |
| ------------------------ | --------------------------------------------------------------------------------------------------------- | ------ | ----------------------- |
| `KAFKA_BOOTSTRAP_SERVER` | URL of the kafka broker, port is required                                                                 | string | valid URLs              |
| `KAFKA_SSL_KEY_PASSWORD` | Password for the SSL key                                                                                  | string | Any                     |
| `KAFKA_TOPICS`           | A semicolon separated list of topics to create                                                            | string | Any                     |
| `LOGGING_LEVEL`          | Defines which logging level is used, mostly relevant for developers.                                      | string | PRODUCTION, DEVELOPMENT |
| `SERIAL_NUMBER`          | Serial number of the cluster (used for tracing)                                                           | string | Any                     |
| `MICROSERVICE_NAME`      | Name of the microservice (used for tracing)                                                               | string | Any                     |
| `DEBUG_ENABLE_FGTRACE`   | Enables the use of the [fgtrace](https://github.com/felixge/fgtrace) library, do not enable in production | string | `true`, `false`         |
{{< /table >}}
