---
title: "Factoryinput"
content_type: reference
description: |
    The technical documentation of the factoryinput microservice,
    which provides REST endpoints for MQTT messages via HTTP requests.
weight: 0
---

<!-- overview -->

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
| Variable name                | Description                                                                                                  | Type   | Allowed values          | Default                                                      |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------ | ------ | ----------------------- | ------------------------------------------------------------ |
| `BROKER_URL`                 | URL to the broker                                                                                            | string | all                     | ssl://{{< resource type="service" name="mqttbroker" >}}:8883 |
| `CERTIFICATE_NAME`           | Set to NO_CERT to allow non-encrypted MQTT access, or to USE_TLS to use TLS encryption                       | string | USE_TLS, NO_CERT        | USE_TLS                                                      |
| `CUSTOMER_NAME_{NUMBER}`     | Specifies a user for the REST API. Multiple users can be set                                                 | string | Any                     | ""                                                           |
| `CUSTOMER_PASSWORD_{NUMBER}` | Specifies the password of the user for the REST API                                                          | string | Any                     | ""                                                           |
| `DEBUG_ENABLE_FGTRACE`       | Enables the use of the [fgtrace](https://github.com/felixge/fgtrace) library. Not recommended for production | string | `true`, `false`         | `false`                                                      |
| `FACTORYINPUT_PASSWORD`      | Specifies the admin user for the REST API                                                                    | string | Any                     | factoryinsight                                               |
| `FACTORYINPUT_USER`          | Specifies the password for the admin user for the REST API                                                   | string | Any                     | _Random UUID_                                                |
| `LOGGING_LEVEL`              | Defines which logging level is used, mostly relevant for developers                                          | string | PRODUCTION, DEVELOPMENT | PRODUCTION                                                   |
| `MQTT_QUEUE_HANDLER`         | Number of queue workers to spawn                                                                             | int    | 0-65535                 | 10                                                           |
| `MQTT_PASSWORD`              | Password for the MQTT broker                                                                                 | string | Any                     | INSECURE_INSECURE_INSECURE                                   |
| `POD_NAME`                   | Name of the pod. Used for tracing                                                                            | string | Any                     | {{< resource type="statefulset" name="factoryinput" >}}-0    |
| `SERIAL_NUMBER`              | Serial number of the cluster. Used for tracing                                                               | string | Any                     | defalut                                                      |
| `VERSION`                    | The version of the API used. Each version also enables all the previous ones                                 | int    | Any                     | 1                                                            |
{{< /table >}}
