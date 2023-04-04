---
title: "Sensorconnect"
content_type: microservices
description: |
    The technical documentation of the sensorconnect microservice,
    which reads data from sensors and sends them to the MQTT or Kafka broker.
weight: 0
---

<!-- overview -->

Sensorconnect automatically detects [ifm gateways](https://ifm.com/us/en/category/245_010_010)
connected to the network and reads data from the connected [IO-Link](https://io-link.com)
sensors.

## {{% heading "howitworks" %}}

Sensorconnect continuosly scans the given IP range for gateways, making it
effectively a plug-and-play solution. Once a gateway is found, it automatically
download the IODD files for the connected sensors and starts reading the data at
the configured interval. Then it processes the data and sends it to the MQTT or
Kafka broker, to be consumed by other microservices.

If you want to learn more about how to use sensors in your asstes, check out the
[retrofitting](https://learn.umh.app/topic/retrofit/) section of the UMH Learn
website.

### IODD files

The IODD files are used to describe the sensors connected to the gateway. They
contain information about the data type, the unit of measurement, the minimum and
maximum values, etc. The IODD files are downloaded automatically from
[IODDFinder](https://ioddfinder.io-link.com/#/) once a sensor is found, and are
stored in a Persistent Volume. If downloading from internet is not possible,
for example in a closed network, you can download the IODD files manually and
store them in the folder specified by the `IODD_FILE_PATH` environment variable.

If no IODD file is found for a sensor, the data will not be processed, but sent
to the broker as-is.

<!-- body -->

## {{% heading "kuberesources" %}}

- StatefulSet: `{{< resource type="statefulset" name="sensorconnect" >}}`
- Secret:
  - Kafka: `{{< resource type="secret" name="sensorconnect-kafka" >}}`
  - MQTT: `{{< resource type="secret" name="sensorconnect-mqtt" >}}`
- PersistentVolumeClaim: `{{< resource type="pvc" name="sensorconnect" >}}`

## {{% heading "configuration" %}}

You can configure the IP range to scan for gateways, and which message broker to
use, by setting the values of the parameters in the
[`_000_commonConfig.datasources.sensorconnect`](/docs/architecture/helm-chart/#sensor-connect)
section of the Helm chart values file.

The default values of the other parameters are usually good for most use cases,
but you can change them in the Danger Zone section of the Helm chart values file.

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name                              | Description                                                                                                                                                   | Type   | Allowed values                | Default                                                 |
| ------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------ | ----------------------------- | ------------------------------------------------------- |
| `ADDITIONAL_SLEEP_TIME_PER_ACTIVE_PORT_MS` | Additional sleep time between pollings for each active port                                                                                                   | float  | Any                           | 0.0                                                     |
| `ADDITIONAL_SLOWDOWN_MAP`                  | JSON map of values, allows to slow down and speed up the polling time of specific sensors                                                                     | JSON   | [See below](#slowdown-map)    | []                                                      |
| `DEBUG_ENABLE_FGTRACE`                     | Enables the use of the [fgtrace](https://github.com/felixge/fgtrace) library. Not reccomended for production                                                  | string | true, false                   | false                                                   |
| `DEVICE_FINDER_TIMEOUT_SEC`                | HTTP timeout in seconds for finding new devices                                                                                                               | int    | Any                           | 1                                                       |
| `DEVICE_FINDER_TIME_SEC`                   | Time interval in seconds for finding new devices                                                                                                              | int    | Any                           | 20                                                      |
| `IODD_FILE_PATH`                           | Filesystem path where to store IODD files                                                                                                                     | string | Any valid Unix path           | `/ioddfiles`                                            |
| `IP_RANGE`                                 | The IP range to scan for new sensor                                                                                                                           | string | Any valid IP in CIDR notation | 192.168.10.1/24                                         |
| `KAFKA_BOOTSTRAP_SERVER`                   | URL of the Kafka broker. Port is required                                                                                                                     | string | Any                           | {{< resource type="service" name="kafkabroker" >}}:9092 |
| `KAFKA_SSL_KEY_PASSWORD`                   | The encrypted password of the SSL key. If empty, no password is used                                                                                          | string | Any                           | ""                                                      |
| `LOGGING_LEVEL`                            | Defines which logging level is used, mostly relevant for developers                                                                                           | string | PRODUCTION, DEVELOPMENT       | PRODUCTION                                              |
| `LOWER_POLLING_TIME_MS`                    | Time in milliseconds to define the lower bound of time between sensor polling                                                                                 | int    | Any                           | 20                                                      |
| `MAX_SENSOR_ERROR_COUNT`                   | Amount of errors before a sensor is temporarily disabled                                                                                                      | int    | Any                           | 50                                                      |
| `MICROSERVICE_NAME`                        | Name of the microservice (used for tracing)                                                                                                                   | string | Any                           | united-manufacturing-hub-sensorconnect                  |
| `MQTT_BROKER_URL`                          | URL of the MQTT broker. Port is required                                                                                                                      | string | Any                           | {{< resource type="service" name="mqttbroker" >}}:1883  |
| `MQTT_CERTIFICATE_NAME`                    | Set to NO_CERT to allow non-encrypted MQTT access, or to USE_TLS to use TLS encryption                                                                        | string | USE_TLS, NO_CERT              | USE_TLS                                                 |
| `MQTT_PASSWORD`                            | Password for the MQTT broker                                                                                                                                  | string | Any                           | INSECURE_INSECURE_INSECURE                              |
| `POLLING_SPEED_STEP_DOWN_MS`               | Time in milliseconds subtracted from the polling interval after a successful polling                                                                          | int    | Any                           | 1                                                       |
| `POLLING_SPEED_STEP_UP_MS`                 | Time in milliseconds added to the polling interval after a failed polling                                                                                     | int    | Any                           | 20                                                      |
| `SENSOR_INITIAL_POLLING_TIME_MS`           | Amount of time in milliseconds before starting to request sensor data. Must be higher than `LOWER_POLLING_TIME_MS`                                            | int    | Any                           | 100                                                     |
| `SUB_TWENTY_MS`                            | Set to 1 to allow `LOWER_POLLING_TIME_MS` of under 20 ms. This is not recommended as it might lead to the gateway becoming unresponsive until a manual reboot | int    | 0, 1                          | 0                                                       |
| `TEST`                                     | If enabled, the microservice will use a test IODD file from the filesystem to use with a mocked sensor. Only useful for development.                          | string | true, false                   | false                                                   |
| `TRANSMITTERID`                            | Serial number of the cluster (used for tracing)                                                                                                               | string | Any                           | default                                                 |
| `UPPER_POLLING_TIME_MS`                    | Time in milliseconds to define the upper bound of time between sensor polling                                                                                 | int    | Any                           | 1000                                                    |
| `USE_KAFKA`                                | If enabled, uses Kafka as a message broker                                                                                                                    | string | true, false                   | true                                                    |
| `USE_MQTT`                                 | If enabled, uses MQTT as a message broker                                                                                                                     | string | true, false                   | false                                                   |
{{< /table >}}

### Slowdown map

The `ADDITIONAL_SLOWDOWN_MAP` environment variable allows you to slow down and
speed up the polling time of specific sensors. It is a JSON array of values, with
the following structure:

```json
[
  {
    "serialnumber": "000200610104",
    "slowdown_ms": -10
  },
  {
    "url": "http://192.168.0.13",
    "slowdown_ms": 20
  },
  {
    "productcode": "AL13500",
    "slowdown_ms": 20.01
  }
]
```
