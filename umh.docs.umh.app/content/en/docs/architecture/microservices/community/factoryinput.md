---
title: "Factoryinput"
content_type: microservices
description: |
    The technical documentation of the factoryinput microservice,
    which provides REST endpoints for MQTT messages via HTTP requests.
weight: 0
---

<!-- overview -->

{{% notice warning %}}
This microservice is still in development and is not considered stable for production use
{{% /notice %}}

Factoryinput provides REST endpoints for MQTT messages via HTTP requests.

This microservice is typically accessed via [grafana-proxy](/docs/architecture/microservices/community/grafana-proxy)

## {{% heading "howitworks" %}}

The factoryinput microservice provides REST endpoints for MQTT messages via HTTP requests.

The main endpoint is `/api/v1/{customer}/{location}/{asset}/{value}`, with a POST
request method. The customer, location, asset and value are all strings. And are
used to build the MQTT topic. The body of the HTTP request is used as the MQTT
payload.

<!-- body -->

## {{% heading "kuberesources" %}}

- StatefulSet: `{{< resource type="statefulset" name="factoryinput" >}}`
- Service:
  - Internal ClusterIP: `{{< resource type="service" name="factoryinput" >}}` at
    port 80
- Secret: `{{< resource type="secret" name="factoryinput" >}}`

## {{% heading "configuration" %}}

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name                | Description                                                                                                  | Type   | Allowed values          | Default                                                |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------ | ------ | ----------------------- | ------------------------------------------------------ |
| `BROKER_URL`                 | URL to the broker                                                                                            | string | all                     | ssl://{{< resource type="service" name="mqtt" >}}:8883 |
| `CERTIFICATE_NAME`           | Set to NO_CERT to allow non-encrypted MQTT access, or to USE_TLS to use TLS encryption                       | string | USE_TLS, NO_CERT        | USE_TLS                                                |
| `CUSTOMER_NAME_{NUMBER}`     | Specifies a user for the REST API. Multiple users can be set                                                 | string | Any                     | ""                                                     |
| `CUSTOMER_PASSWORD_{NUMBER}` | Specifies the password of the user for the REST API                                                          | string | Any                     | ""                                                     |
| `DEBUG_ENABLE_FGTRACE`       | Enables the use of the [fgtrace](https://github.com/felixge/fgtrace) library. Not reccomended for production | string | `true`, `false`         | `false`                                                |
| `FACTORYINPUT_PASSWORD`      | Specifies the admin user for the REST API                                                                    | string | Any                     | factoryinsight                                         |
| `FACTORYINPUT_USER`          | Specifies the password for the admin user for the REST API                                                   | string | Any                     | _Random UUID_                                          |
| `LOGGING_LEVEL`              | Defines which logging level is used, mostly relevant for developers                                          | string | PRODUCTION, DEVELOPMENT | PRODUCTION                                             |
| `MQTT_QUEUE_HANDLER`         | Number of queue workers to spawn                                                                             | int    | 0-65535                 | 10                                                     |
| `MQTT_PASSWORD`              | Password for the MQTT broker                                                                                 | string | Any                     | INSECURE_INSECURE_INSECURE                             |
| `SERIAL_NUMBER`              | Serial number of the cluster. Used for tracing                                                               | string | Any                     | defalut                                            |
| `VERSION`                    | The version of the API used. Each version also enables all the previous ones                                 | int    | Any                     | 1                                                      |
{{< /table >}}
