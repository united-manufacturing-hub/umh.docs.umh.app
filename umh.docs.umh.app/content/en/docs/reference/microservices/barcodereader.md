---
title: "Barcodereader"
content_type: reference
description: |
    The technical documentation of the barcodereader microservice,
    which reads barcodes and sends the data to the Kafka broker.
weight: 0
---

<!-- overview -->
## {{% heading "howitworks" %}}

<!-- body -->

## {{% heading "kuberesources" %}}

- Deployment: `{{< resource type="deployment" name="barcodereader" >}}`
- Secret: `{{< resource type="secret" name="barcodereader" >}}`

## {{% heading "configuration" %}}

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name            | Description                                                                                                              | Type   | Allowed values          | Default                                                 |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------ | ------ | ----------------------- | ------------------------------------------------------- |
| `ASSET_ID`               | The asset ID, which is used for the topic structure                                                                      | string | Any                     | barcodereader                                           |
| `CUSTOMER_ID`            | The customer ID, which is used for the topic structure                                                                   | string | Any                     | raw                                                     |
| `DEBUG_ENABLE_FGTRACE`   | Enables the use of the [fgtrace](https://github.com/felixge/fgtrace) library. Not recommended for production             | string | `true`, `false`         | `false`                                                 |
| `INPUT_DEVICE_NAME`      | The name of the USB device to use                                                                                        | string | Any                     | Datalogic ADC, Inc. Handheld Barcode Scanner            |
| `INPUT_DEVICE_PATH`      | The path of the USB device to use. It is recommended to use a wildcard (for example, `/dev/input/event*`) or leave empty | string | Valid Unix device path  | ""                                                      |
| `KAFKA_BOOTSTRAP_SERVER` | URL of the Kafka broker used, port is required                                                                           | string | Any                     | {{< resource type="service" name="kafkabroker" >}}:9092 |
| `LOCATION`               | The location, which is  used for the topic structure                                                                     | string | Any                     | barcodereader                                           |
| `LOGGING_LEVEL`          | Defines which logging level is used, mostly relevant for developers.                                                     | string | PRODUCTION, DEVELOPMENT | PRODUCTION                                              |
| `MICROSERVICE_NAME`      | Name of the microservice (used for tracing)                                                                              | string | Any                     | united-manufacturing-hub-barcodereader                  |
| `SCAN_ONLY`              | Prevent message broadcasting if enabled                                                                                  | `bool` | `true`, `false`         | `false`                                                 |
| `SERIAL_NUMBER`          | Serial number of the cluster (used for tracing)                                                                          | string | Any                     | defalut                                                 |
{{< /table >}}
