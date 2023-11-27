---
title: "Kafka State Detector"
content_type: reference
description: |
    The technical documentation of the kafka-state-detector microservice,
    which detects the state of the Kafka broker.
weight: 0
---

<!-- overview -->

<!-- body -->

## {{% heading "kuberesources" %}}

- Deployment: `{{< resource type="deployment" name="kafkastatedetector" >}}`
- Secret: `{{< resource type="secret" name="kafkastatedetector" >}}`

## {{% heading "configuration" %}}

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name            | Description                                                                                                  | Type   | Allowed values  | Default                                                 |
| ------------------------ | ------------------------------------------------------------------------------------------------------------ | ------ | --------------- | ------------------------------------------------------- |
| `ACTIVITY_ENABLED`       | Controls whether to check the activity of the Kafka broker                                                   | string | `true`, `false` | true                                                    |
| `ANOMALY_ENABLED`        | Controls whether to check for anomalies in the Kafka broker                                                  | string | `true`, `false` | true                                                    |
| `DEBUG_ENABLE_FGTRACE`   | Enables the use of the [fgtrace](https://github.com/felixge/fgtrace) library. Not recommended for production | string | `true`, `false` | `false`                                                 |
| `KAFKA_BOOTSTRAP_SERVER` | URL of the Kafka broker used, port is required                                                               | string | Any             | {{< resource type="service" name="kafkabroker" >}}:9092 |
| `KAFKA_SSL_KEY_PASSWORD` | Key password to decode the SSL private key                                                                   | string | Any             | ""                                                      |
| `KAKFA_USE_SSL`          | Enables the use of SSL for the kafka connection                                                              | string | `true`, `false` | `false`                                                 |
| `MICROSERVICE_NAME`      | Name of the microservice (used for tracing)                                                                  | string | Any             | united-manufacturing-hub-kafkastatedetector             |
| `SERIAL_NUMBER`          | Serial number of the cluster. Used for tracing                                                               | string | Any             | default                                                 |
{{< /table >}}
