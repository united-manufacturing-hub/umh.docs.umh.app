---
title: "Helm Chart"
content_type: concept
description: |
    This page describes the Helm Chart of the United Manufacturing Hub and the
    possible configuration options.
weight: 10
---

<!-- overview -->

An Helm chart is a package manager for Kubernetes that simplifies the
installation, configuration, and deployment of applications and services.
It contains all the necessary Kubernetes manifests, configuration files, and
dependencies required to run a particular application or service.  One of the
main advantages of Helm is that it allows to define the configuration of the
installed resources in a single YAML file, called `values.yaml`.

The Helm Chart of the United Manufacturing Hub is composed of both custom
microservices and third-party applications. If you want a more in-depth view of
the architecture of the United Manufacturing Hub, you can read the [Architecture overview](/docs/architecture/) page.

<!-- body -->

## Helm Chart structure

### Custom microservices

The Helm Chart of the United Manufacturing Hub is composed of the following
custom microservices:

- [barcodereader](/docs/architecture/microservices/community/barcodereader/): reads the input from
  a barcode reader and sends it to the MQTT broker for further processing.
- customMicroservice: a
  template for deploying any number of custom microservices.
- [factoryinput](/docs/architecture/microservices/community/factoryinput/): provides REST
  endpoints for MQTT messages.
- [factoryinsight](/docs/architecture/microservices/core/factoryinsight/): provides REST
  endpoints to fetch data and calculate KPIs.
- [grafanaproxy](/docs/architecture/microservices/community/grafana-proxy): provides a
  proxy to the backend services.
- [MQTT Simulator](/docs/architecture/microservices/community/mqtt-simulator): simulates
  sensors and sends the data to the MQTT broker for further processing.
- [kafka-bridge](/docs/architecture/microservices/core/kafka-bridge/): connects Kafka brokers
  on different Kubernetes clusters.
- [kafkatopostgresql](/docs/architecture/microservices/core/kafka-to-postgresql/):
  stores the data from the Kafka broker in a PostgreSQL database.
- [mqtt-kafka-bridge](/docs/architecture/microservices/core/mqtt-kafka-bridge/): connects
  the MQTT broker and the Kafka broker.
- [mqttbridge](/docs/architecture/microservices/core/mqtt-bridge/): connects MQTT brokers on
  different Kubernetes clusters.
- [opcuasimulator](/docs/architecture/microservices/community/opcua-simulator/): simulates
  OPC UA servers and sends the data to the MQTT broker for further processing.
- [packmlmqttsimulator](/docs/architecture/microservices/community/packml-simulator/):
  simulates a PackML state machine and sends the data to the MQTT broker for
  further processing.
- [sensorconnect](/docs/architecture/microservices/core/sensorconnect/): connects to a
  sensor and sends the data to the MQTT and Kafka brokers for further processing.
- [tulip-connector](/docs/architecture/microservices/community/tulip-connector/): exposes internal
  APIs to the internet, especially tailored for the [Tulip](https://tulip.co/) platform.

### Third-party applications

The Helm Chart of the United Manufacturing Hub is composed of the following
third-party applications:

- [Grafana](https://grafana.com/): a visualization and analytics software.
- [HiveMQ](https://www.hivemq.com/): an MQTT broker.
- [Kafka](https://kafka.apache.org/): a distributed streaming platform.
- [Node-RED](https://nodered.org/): a programming tool for wiring together
  hardware devices, APIs and online services.
- [Red Panda Console](https://redpanda.com/redpanda-console-kafka-ui/): a
  web-based user interface for Kafka.
- [Redis](https://redis.io/): an in-memory data structure store, used for cache.
- [TimescaleDB](https://www.timescale.com/): an open-source time-series SQL
  database.

## Configuration

There are two ways to configure the Helm Chart of the United Manufacturing Hub:

- by editing the `values.yaml` file after the initial installation, which is the
  recommended way. Take a look at the
  [Customize the United Manufacturing Hub](/docs/production-guide/administration/customize-umh-installation/#edit-via-lens)
  page for more information.
- by creating a custom `values.yaml` file and passing it to the `helm install`
  command. Take a look at the
  [Customize the United Manufacturing Hub](/docs/production-guide/administration/customize-umh-installation/#custom-values-yaml)
  page for more information.

## Configuration options

The Helm Chart of the United Manufacturing Hub can be configured by setting
values in the `values.yaml` file. This file has three main sections that can be
used to configure the applications:

- [`customers`](#customers): contains the definition of the customers that will be created
  during the installation of the Helm Chart. This section is optional, and it's
  used only by factoryinsight and factoryinput.
- [`_000_commonConfig`](#common-configuration-options): contains the basic configuration options to customize the
  United Manufacturing Hub, and it's divided into sections that group applications
  with similar scope, like the ones that compose the infrastructure or the ones
  responsible for data processing. This is the section that should be mostly used
  to configure the microservices.
- [`_001_customMicroservices`](#custom-microservices-configuration): used to define the configuration of
  custom microservices that are not included in the Helm Chart.

After those three sections, there are the specific sections for each microservice,
which contain their advanced configuration. This is the so called [Danger Zone](#danger-zone),
because the values in those sections should not be changed, unlsess you absolutely
know what you are doing.

{{% notice note %}}
When a parameter contains `.` (dot) characters, it means that it is a nested
parameter. For example, in the `tls.factoryinput.cert` parameter the `cert`
parameter is nested inside the `tls.factoryinput` section, and the `factoryinput`
section is nested inside the `tls` section.
{{% /notice %}}

### Customers

The `customers` section contains the definition of the customers that will be
created during the installation of the Helm Chart. It's a simple dictionary where
the key is the name of the customer, and the value is the password.

For example, the following snippet creates two customers:

```yaml
customers:
  customer1: password1
  customer2: password2
```

### Common configuration options

The `_000_commonConfig` contains the basic configuration options to customize the
United Manufacturing Hub, and it's divided into sections that group applications
with similar scope.

The following table lists the configuration options that can be set in the
`_000_commonConfig` section:

{{< table caption="_000_commonConfig section parameters" >}}
| Parameter            | Description                                                                     | Type   | Allowed values | Default                            |
| -------------------- | ------------------------------------------------------------------------------- | ------ | -------------- | ---------------------------------- |
| `serialNumber`       | The hostname of the device. Used by some microservices to identify the device.  | string | Any            | default                            |
| `datasources`        | The configuration of the microservices used to acquire data.                    | object | See below      | [See below](#data-sources)         |
| `dataprocessing`     | The configuration of the microservices used to process data.                    | object | See below      | [See below](#data-processing)      |
| `infrastructure`     | The configuration of the microservices used to provide infrastructure services. | object | See below      | [See below](#infrastructure)       |
| `datastorage`        | The configuration of the microservices used to store data.                      | object | See below      | [See below](#data-storage)         |
| `datainput`          | The configuration of the microservices used to input data.                      | object | See below      | [See below](#data-input)           |
| `mqttBridge`         | The configuration for the MQTT bridge.                                          | object | See below      | [See below](#mqtt-bridge)          |
| `kafkaBridge`        | The configuration for the Kafka bridge.                                         | object | See below      | [See below](#kafka-bridge)         |
| `kafkaStateDetector` | The configuration for the Kafka state detector.                                 | object | See below      | [See below](#kafka-state-detector) |
| `debug`              | The configuration for the debug mode.                                           | object | See below      | [See below](#debug)                |
| `tulipconnector`     | The configuration for the Tulip connector.                                      | object | See below      | [See below](#tulip-connector)      |
{{< /table >}}

#### Data sources

The `_000_commonConfig.datasources` section contains the configuration of the
microservices used to acquire data, like the ones that connect to a sensor or
simulate data.

The following table lists the configuration options that can be set in the
`_000_commonConfig.datasources` section:

{{< table caption="datasources section parameters" >}}
| Parameter             | Description                                            | Type   | Allowed values | Default                             |
| --------------------- | ------------------------------------------------------ | ------ | -------------- | ----------------------------------- |
| `barcodereader`       | The configuration of the barcodereader microservice.   | object | See below      | [See below](#barcode-reader)        |
| `iotsensorsmqtt`      | The configuration of the IoTSensorsMQTT microservice.  | object | See below      | [See below](#iot-sensors-mqtt)      |
| `opcuasimulator`      | The configuration of the opcuasimulator microservice.  | object | See below      | [See below](#opc-ua-simulator)      |
| `packmlmqttsimulator` | The configuration of the packmlsimulator microservice. | object | See below      | [See below](#packml-mqtt-simulator) |
| `sensorconnect`       | The configuration of the sensorconnect microservice.   | object | See below      | [See below](#sensor-connect)        |
{{< /table >}}

##### Barcode reader

The `_000_commonConfig.datasources.barcodereader` section contains the
configuration of the [barcodereader](/docs/architecture/microservices/community/barcodereader)
microservice.

The following table lists the configuration options that can be set in the
`_000_commonConfig.datasources.barcodereader` section:

{{< table caption="barcodereader section parameters" >}}
| Parameter       | Description                                                                    | Type   | Allowed values         | Default                                      |
| --------------- | ------------------------------------------------------------------------------ | ------ | ---------------------- | -------------------------------------------- |
| `enabled`       | Whether the `barcodereader` microservice is enabled.                           | bool   | `true`, `false`        | `false`                                      |
| `USBDeviceName` | The name of the USB device to use.                                             | string | Any                    | Datalogic ADC, Inc. Handheld Barcode Scanner |
| `USBDevicePath` | The path of the USB device to use. If empty, `USBDeviceName` gets used instead | string | Valid Unix device path | ""                                           |
| `customerID`    | The customer ID to use in the topic structure.                                 | string | Any                    | raw                                          |
| `location`      | The location to use in the topic structure.                                    | string | Any                    | barcodereader                                |
| `machineID`     | The asset ID to use in the topic structure.                                    | string | Any                    | barcodereader                                |
{{< /table >}}

##### IoT Sensors MQTT

The `_000_commonConfig.datasources.iotsensorsmqtt` section contains the
configuration of the [IoTSensorsMQTT](/docs/architecture/microservices/community/mqtt-simulator)
microservice.

The following table lists the configuration options that can be set in the
`_000_commonConfig.datasources.iotsensorsmqtt` section:

{{< table caption="iotsensorsmqtt section parameters" >}}
| Parameter | Description                                         | Type | Allowed values  | Default |
| --------- | --------------------------------------------------- | ---- | --------------- | ------- |
| `enabled` | Whether the IoTSensorsMQTT microservice is enabled. | bool | `true`, `false` | `true`  |
{{< /table >}}

##### OPC UA Simulator

The `_000_commonConfig.datasources.opcuasimulator` section contains the
configuration of the [opcuasimulator](/docs/architecture/microservices/community/opcua-simulator)
microservice.

The following table lists the configuration options that can be set in the
`_000_commonConfig.datasources.opcuasimulator` section:

{{< table caption="opcuasimulator section parameters" >}}
| Parameter | Description                                         | Type | Allowed values  | Default |
| --------- | --------------------------------------------------- | ---- | --------------- | ------- |
| `enabled` | Whether the opcuasimulator microservice is enabled. | bool | `true`, `false` | `true`  |
{{< /table >}}

##### PackML MQTT Simulator

The `_000_commonConfig.datasources.packmlmqttsimulator` section contains the
configuration of the [packmlsimulator](/docs/architecture/microservices/community/packml-simulator)
microservice.

The following table lists the configuration options that can be set in the
`_000_commonConfig.datasources.packmlmqttsimulator` section:

{{< table caption="packmlmqttsimulator section parameters" >}}
| Parameter | Description                                          | Type | Allowed values  | Default |
| --------- | ---------------------------------------------------- | ---- | --------------- | ------- |
| `enabled` | Whether the packmlsimulator microservice is enabled. | bool | `true`, `false` | `true`  |
{{< /table >}}

##### Sensor connect

The `_000_commonConfig.datasources.sensorconnect` section contains the
configuration of the [sensorconnect](/docs/architecture/microservices/core/sensorconnect)
microservice.

The following table lists the configuration options that can be set in the
`_000_commonConfig.datasources.sensorconnect` section:

{{< table caption="sensorconnect section parameters" >}}
| Parameter     | Description                                               | Type   | Allowed values  | Default         |
| ------------- | --------------------------------------------------------- | ------ | --------------- | --------------- |
| `enabled`     | Whether the sensorconnect microservice is enabled.        | bool   | `true`, `false` | `false`         |
| `iprange`     | The IP range of the sensors in CIDR notation.             | string | Valid IP range  | 192.168.10.1/24 |
| `enableKafka` | Whether the sensorconnect microservice should use Kafka.  | bool   | `true`, `false` | `true`          |
| `enableMQTT`  | Whether the sensorconnect microservice should use MQTT.   | bool   | `true`, `false` | `false`         |
| `testMode`    | Whether to enable test mode. Only useful for development. | bool   | `true`, `false` | `false`         |
{{< /table >}}

#### Data processing

The `_000_commonConfig.dataprocessing` section contains the configuration of the
microservices used to process data, such as the nodered
microservice.

The following table lists the configuration options that can be set in the
`_000_commonConfig.dataprocessing` section:

{{< table caption="dataprocessing section parameters" >}}
| Parameter | Description                                    | Type   | Allowed values | Default                |
| --------- | ---------------------------------------------- | ------ | -------------- | ---------------------- |
| `nodered` | The configuration of the nodered microservice. | object | See below      | [See below](#node-red) |
{{< /table >}}

##### Node-RED

The `_000_commonConfig.dataprocessing.nodered` section contains the configuration
of the [nodered](/docs/architecture/microservices/core/node-red/) microservice.

The following table lists the configuration options that can be set in the
`_000_commonConfig.dataprocessing.nodered` section:

{{< table caption="nodered section parameters" >}}
| Parameter      | Description                                  | Type | Allowed values  | Default |
| -------------- | -------------------------------------------- | ---- | --------------- | ------- |
| `enabled`      | Whether the nodered microservice is enabled. | bool | `true`, `false` | `true`  |
| `defaultFlows` | Whether the default flows should be used.    | bool | `true`, `false` | `false` |
{{< /table >}}

#### Infrastructure

The `_000_commonConfig.infrastructure` section contains the configuration of the
microservices responsible for connecting all the other microservices, such as the
[MQTT broker](/docs/architecture/microservices/core/mqtt-broker) and the
[Kafka broker](/docs/architecture/microservices/core/kafka-broker/).

The following table lists the configuration options that can be set in the
`_000_commonConfig.infrastructure` section:

{{< table caption="infrastructure section parameters" >}}
| Parameter | Description                            | Type   | Allowed values | Default             |
| --------- | -------------------------------------- | ------ | -------------- | ------------------- |
| `mqtt`    | The configuration of the MQTT broker.  | object | See below      | [See below](#mqtt)  |
| `kafka`   | The configuration of the Kafka broker. | object | See below      | [See below](#kafka) |
{{< /table >}}

##### MQTT

The `_000_commonConfig.infrastructure.mqtt` section contains the configuration
of the [MQTT broker](/docs/architecture/microservices/core/mqtt-broker).

The following table lists the configuration options that can be set in the
`_000_commonConfig.infrastructure.mqtt` section:

{{< table caption="mqtt section parameters" >}}
| Parameter                     | Description                                               | Type   | Allowed values   | Default    |
| ----------------------------- | --------------------------------------------------------- | ------ | ---------------- | ---------- |
| `enabled`                     | Whether the MQTT broker is enabled                        | bool   | `true`, `false`  | `true`     |
| `adminUser.enabled`           | Whether the admin user is enabled                         | bool   | `true`, `false`  | `false`    |
| `adminUser.name`              | The name of the admin user                                | string | Any UTF-8 string | admin-user |
| `adminUser.encryptedPassword` | The encrypted password of the admin user                  | string | Any              | ""         |
| `tls.useTLS`                  | Whether TLS should be used                                | bool   | `true`, `false`  | `true`     |
| `tls.insecureSkipVerify`      | Whether the SSL certificate validation should be skipped  | bool   | `true`, `false`  | `true`     |
| `tls.keystoreBase64`          | The base64 encoded keystore                               | string | Any              | ""         |
| `tls.keystorePassword`        | The password of the keystore                              | string | Any              | ""         |
| `tls.truststoreBase64`        | The base64 encoded truststore                             | string | Any              | ""         |
| `tls.truststorePassword`      | The password of the truststore                            | string | Any              | ""         |
| `tls.caCert`                  | The CA certificate                                        | string | Any              | ""         |
| `tls.factoryinput.cert`       | The certificate used for the factoryinput microservice    | string | Any              | ""         |
| `tls.factoryinput.key`        | The key used for the factoryinput microservice            | string | Any              | ""         |
| `tls.mqtt_kafka_bridge.cert`  | The certificate used for the mqttkafkabridge              | string | Any              | ""         |
| `tls.mqtt_kafka_bridge.key`   | The key used for the mqttkafkabridge                      | string | Any              | ""         |
| `tls.mqtt_bridge.local_cert`  | The certificate used for the local mqttbridge broker      | string | Any              | ""         |
| `tls.mqtt_bridge.local_key`   | The key used for the local mqttbridge broker              | string | Any              | ""         |
| `tls.mqtt_bridge.remote_cert` | The certificate used for the remote mqttbridge broker     | string | Any              | ""         |
| `tls.mqtt_bridge.remote_key`  | The key used for the remote mqttbridge broker             | string | Any              | ""         |
| `tls.sensorconnect.cert`      | The certificate used for the sensorconnect microservice   | string | Any              | ""         |
| `tls.sensorconnect.key`       | The key used for the sensorconnect microservice           | string | Any              | ""         |
| `tls.iotsensorsmqtt.cert`     | The certificate used for the iotsensorsmqtt microservice  | string | Any              | ""         |
| `tls.iotsensorsmqtt.key`      | The key used for the iotsensorsmqtt microservice          | string | Any              | ""         |
| `tls.packmlsimulator.cert`    | The certificate used for the packmlsimulator microservice | string | Any              | ""         |
| `tls.packmlsimulator.key`     | The key used for the packmlsimulator microservice         | string | Any              | ""         |
| `tls.nodered.cert`            | The certificate used for the nodered microservice         | string | Any              | ""         |
| `tls.nodered.key`             | The key used for the nodered microservice                 | string | Any              | ""         |
{{< /table >}}

##### Kafka

The `_000_commonConfig.infrastructure.kafka` section contains the configuration
of the [Kafka broker](/docs/architecture/microservices/core/kafka-broker/)
and related services, like [mqttkafkabridge](/docs/architecture/microservices/core/mqtt-kafka-bridge/),
[kafkatopostgresql](/docs/architecture/microservices/core/kafka-to-postgresql/)
and the [Kafka console](/docs/architecture/microservices/core/kafka-console/).

The following table lists the configuration options that can be set in the
`_000_commonConfig.infrastructure.kafka` section:

{{< table caption="kafka section parameters" >}}
| Parameter                                  | Description                                                                                                  | Type   | Allowed values                                 | Default                                                                      |
| ------------------------------------------ | ------------------------------------------------------------------------------------------------------------ | ------ | ---------------------------------------------- | ---------------------------------------------------------------------------- |
| `enabled`                                  | Whether the Kafka broker and related services are enabled                                                    | bool   | `true`, `false`                                | `true`                                                                       |
| `useSSL`                                   | Whether SSL should be used                                                                                   | bool   | `true`, `false`                                | `true`                                                                       |
| `defaultTopics`                            | The default topics that should be created                                                                    | string | Semicolon separated list of valid Kafka topics | ia.test.test.test.processValue;ia.test.test.test.count;umh.v1.kafka.newTopic |
| `tls.CACert`                               | The CA certificate                                                                                           | string | Any                                            | -----BEGIN CERTIFICATE----- ... -----END CERTIFICATE-----                    |
| `tls.kafka.cert`                           | The certificate used for the kafka broker                                                                    | string | Any                                            | -----BEGIN CERTIFICATE----- ... -----END CERTIFICATE-----                    |
| `tls.kafka.privkey`                        | The private key of the certificate for the Kafka broker                                                      | string | Any                                            | -----BEGIN PRIVATE KEY----- ... -----END PRIVATE KEY-----                    |
| `tls.barcodereader.sslKeyPassword`         | The encrypted password of the SSL key for the barcodereader microservice. If empty, no password is used      | string | Any                                            | ""                                                                           |
| `tls.barcodereader.sslKeyPem`              | The private key for the SSL certificate of the barcodereader microservice                                    | string | Any                                            | -----BEGIN PRIVATE KEY----- ... -----END PRIVATE KEY-----                    |
| `tls.barcodereader.sslCertificatePem`      | The private SSL certificate for the barcodereader microservice                                               | string | Any                                            | -----BEGIN CERTIFICATE----- ... -----END CERTIFICATE-----                    |
| `tls.kafkabridge.sslKeyPasswordLocal`      | The encrypted password of the SSL key for the local mqttbridge broker. If empty, no password is used         | string | Any                                            | ""                                                                           |
| `tls.kafkabridge.sslKeyPemLocal`           | The private key for the SSL certificate of the local mqttbridge broker                                       | string | Any                                            | -----BEGIN PRIVATE KEY----- ... -----END PRIVATE KEY-----                    |
| `tls.kafkabridge.sslCertificatePemLocal`   | The private SSL certificate for the local mqttbridge broker                                                  | string | Any                                            | -----BEGIN CERTIFICATE----- ... -----END CERTIFICATE-----                    |
| `tls.kafkabridge.sslCACertRemote`          | The CA certificate for the remote mqttbridge broker                                                          | string | Any                                            | -----BEGIN CERTIFICATE----- ... -----END CERTIFICATE-----                    |
| `tls.kafkabridge.sslCertificatePemRemote`  | The private SSL certificate for the remote mqttbridge broker                                                 | string | Any                                            | -----BEGIN CERTIFICATE----- ... -----END CERTIFICATE-----                    |
| `tls.kafkabridge.sslKeyPasswordRemote`     | The encrypted password of the SSL key for the remote mqttbridge broker. If empty, no password is used        | string | Any                                            | ""                                                                           |
| `tls.kafkabridge.sslKeyPemRemote`          | The private key for the SSL certificate of the remote mqttbridge broker                                      | string | Any                                            | -----BEGIN PRIVATE KEY----- ... -----END PRIVATE KEY-----                    |
| `tls.kafkadebug.sslKeyPassword`            | The encrypted password of the SSL key for the kafkadebug microservice. If empty, no password is used         | string | Any                                            | ""                                                                           |
| `tls.kafkadebug.sslKeyPem`                 | The private key for the SSL certificate of the kafkadebug microservice                                       | string | Any                                            | -----BEGIN PRIVATE KEY----- ... -----END PRIVATE KEY-----                    |
| `tls.kafkadebug.sslCertificatePem`         | The private SSL certificate for the kafkadebug microservice                                                  | string | Any                                            | -----BEGIN CERTIFICATE----- ... -----END CERTIFICATE-----                    |
| `tls.kafkainit.sslKeyPassword`             | The encrypted password of the SSL key for the kafkainit microservice. If empty, no password is used          | string | Any                                            | ""                                                                           |
| `tls.kafkainit.sslKeyPem`                  | The private key for the SSL certificate of the kafkainit microservice                                        | string | Any                                            | -----BEGIN PRIVATE KEY----- ... -----END PRIVATE KEY-----                    |
| `tls.kafkainit.sslCertificatePem`          | The private SSL certificate for the kafkainit microservice                                                   | string | Any                                            | -----BEGIN CERTIFICATE----- ... -----END CERTIFICATE-----                    |
| `tls.kafkastatedetector.sslKeyPassword`    | The encrypted password of the SSL key for the kafkastatedetector microservice. If empty, no password is used | string | Any                                            | ""                                                                           |
| `tls.kafkastatedetector.sslKeyPem`         | The private key for the SSL certificate of the kafkastatedetector microservice                               | string | Any                                            | -----BEGIN PRIVATE KEY----- ... -----END PRIVATE KEY-----                    |
| `tls.kafkastatedetector.sslCertificatePem` | The private SSL certificate for the kafkastatedetector microservice                                          | string | Any                                            | -----BEGIN CERTIFICATE----- ... -----END CERTIFICATE-----                    |
| `tls.kafkatoblob.sslKeyPassword`           | The encrypted password of the SSL key for the kafkatoblob microservice. If empty, no password is used        | string | Any                                            | ""                                                                           |
| `tls.kafkatoblob.sslKeyPem`                | The private key for the SSL certificate of the kafkatoblob microservice                                      | string | Any                                            | -----BEGIN PRIVATE KEY----- ... -----END PRIVATE KEY-----                    |
| `tls.kafkatoblob.sslCertificatePem`        | The private SSL certificate for the kafkatoblob microservice                                                 | string | Any                                            | -----BEGIN CERTIFICATE----- ... -----END CERTIFICATE-----                    |
| `tls.kafkatopostgresql.sslKeyPassword`     | The encrypted password of the SSL key for the kafkatopostgresql microservice. If empty, no password is used  | string | Any                                            | ""                                                                           |
| `tls.kafkatopostgresql.sslKeyPem`          | The private key for the SSL certificate of the kafkatopostgresql microservice                                | string | Any                                            | -----BEGIN PRIVATE KEY----- ... -----END PRIVATE KEY-----                    |
| `tls.kafkatopostgresql.sslCertificatePem`  | The private SSL certificate for the kafkatopostgresql microservice                                           | string | Any                                            | -----BEGIN CERTIFICATE----- ... -----END CERTIFICATE-----                    |
| `tls.kowl.sslKeyPassword`                  | The encrypted password of the SSL key for the kowl microservice. If empty, no password is used               | string | Any                                            | ""                                                                           |
| `tls.kowl.sslKeyPem`                       | The private key for the SSL certificate of the kowl microservice                                             | string | Any                                            | -----BEGIN PRIVATE KEY----- ... -----END PRIVATE KEY-----                    |
| `tls.kowl.sslCertificatePem`               | The private SSL certificate for the kowl microservice                                                        | string | Any                                            | -----BEGIN CERTIFICATE----- ... -----END CERTIFICATE-----                    |
| `tls.mqttkafkabridge.sslKeyPassword`       | The encrypted password of the SSL key for the mqttkafkabridge microservice. If empty, no password is used    | string | Any                                            | ""                                                                           |
| `tls.mqttkafkabridge.sslKeyPem`            | The private key for the SSL certificate of the mqttkafkabridge microservice                                  | string | Any                                            | -----BEGIN PRIVATE KEY----- ... -----END PRIVATE KEY-----                    |
| `tls.mqttkafkabridge.sslCertificatePem`    | The private SSL certificate for the mqttkafkabridge microservice                                             | string | Any                                            | -----BEGIN CERTIFICATE----- ... -----END CERTIFICATE-----                    |
| `tls.nodered.sslKeyPassword`               | The encrypted password of the SSL key for the nodered microservice. If empty, no password is used            | string | Any                                            | ""                                                                           |
| `tls.nodered.sslKeyPem`                    | The private key for the SSL certificate of the nodered microservice                                          | string | Any                                            | -----BEGIN PRIVATE KEY----- ... -----END PRIVATE KEY-----                    |
| `tls.nodered.sslCertificatePem`            | The private SSL certificate for the nodered microservice                                                     | string | Any                                            | -----BEGIN CERTIFICATE----- ... -----END CERTIFICATE-----                    |
| `tls.sensorconnect.sslKeyPassword`         | The encrypted password of the SSL key for the sensorconnect microservice. If empty, no password is used      | string | Any                                            | ""                                                                           |
| `tls.sensorconnect.sslKeyPem`              | The private key for the SSL certificate of the sensorconnect microservice                                    | string | Any                                            | -----BEGIN PRIVATE KEY----- ... -----END PRIVATE KEY-----                    |
| `tls.sensorconnect.sslCertificatePem`      | The private SSL certificate for the sensorconnect microservice                                               | string | Any                                            | -----BEGIN CERTIFICATE----- ... -----END CERTIFICATE-----                    |
{{< /table >}}

#### Data storage

The `_000_commonConfig.datastorage` section contains the configuration of the
microservices used to store data. Specifically, it controls the following
microservices:

- [cache](/docs/architecture/microservices/core/cache)
- [database](/docs/architecture/microservices/core/database)
- [factoryinsight](/docs/architecture/microservices/core/factoryinsight)
- [grafana](/docs/architecture/microservices/core/grafana)
- [kafka-to-postgresql](/docs/architecture/microservices/core/kafka-to-postgresql)
- [mqtt-broker](/docs/architecture/microservices/core/mqtt-broker)

If you want to specifically configure one of these microservices, you can do so
in their respective sections in the Danger Zone.

The following table lists the configurable parameters of the
`_000_commonConfig.datastorage` section.

{{< table caption="datastorage section parameters" >}}
| Parameter     | Description                                                                                       | Type   | Allowed values  | Default  |
| ------------- | ------------------------------------------------------------------------------------------------- | ------ | --------------- | -------- |
| `enabled`     | Whether to enable the data storage microservices                                                  | bool   | `true`, `false` | `true`   |
| `db_password` | The password for the database. Used by all the microservices that need to connect to the database | string | Any             | changeme |
{{< /table >}}

#### Data input

The `_000_commonConfig.datainput` section contains the configuration of the
microservices used to input data. Specifically, it controls the following
microservices:

- [factoryinput](/docs/architecture/microservices/community/factoryinput)
- [grafanaproxy](/docs/architecture/microservices/community/grafana-proxy)

If you want to specifically configure one of these microservices, you can do so
in their respective sections in the danger zone.

The following table lists the configurable parameters of the
`_000_commonConfig.datainput` section./

{{< table caption="datainput section parameters" >}}
| Parameter | Description                                    | Type | Allowed values  | Default |
| --------- | ---------------------------------------------- | ---- | --------------- | ------- |
| `enabled` | Whether to enable the data input microservices | bool | `true`, `false` | `false` |
{{< /table >}}

#### MQTT Bridge

The `_000_commonConfig.mqttBridge` section contains the configuration of the
[mqtt-bridge](/docs/architecture/microservices/core/mqtt-bridge/) microservice,
responsible for bridging MQTT brokers in different Kubernetes clusters.

The following table lists the configurable parameters of the
`_000_commonConfig.mqttBridge` section.

{{< table caption="mqttBridge section parameters" >}}
| Parameter                | Description                                                   | Type   | Allowed values            | Default                                                           |
| ------------------------ | ------------------------------------------------------------- | ------ | ------------------------- | ----------------------------------------------------------------- |
| `enabled`                | Whether to enable the mqtt-bridge microservice                | bool   | `true`, `false`           | `false`                                                           |
| `localSubTopic`          | The topic that the local MQTT broker subscribes to            | string | Any valid MQTT topic      | ia/factoryinsight                                                 |
| `localPubTopic`          | The topic that the local MQTT broker publishes to             | string | Any valid MQTT topic      | ia/factoryinsight                                                 |
| `oneWay`                 | Whether to enable one-way communication, from local to remote | bool   | `true`, `false`           | `true`                                                            |
| `remoteBrokerUrl`        | The URL of the remote MQTT broker                             | string | Any valid MQTT broker URL | ssl://united-manufacturing-hub-mqtt.united-manufacturing-hub:8883 |
| `remoteBrokerSSLEnables` | Whether to enable SSL for the remote MQTT broker              | bool   | `true`, `false`           | `true`                                                            |
| `remoteSubTopic`         | The topic that the remote MQTT broker subscribes to           | string | Any valid MQTT topic      | ia                                                                |
| `remotePubTopic`         | The topic that the remote MQTT broker publishes to            | string | Any valid MQTT topic      | ia/factoryinsight                                                 |
{{< /table >}}

#### Kafka Bridge

The `_000_commonConfig.kafkaBridge` section contains the configuration of the
[kafka-bridge](/docs/architecture/microservices/core/kafka-bridge/) microservice,
responsible for bridging Kafka brokers in different Kubernetes clusters.

The following table lists the configurable parameters of the
`_000_commonConfig.kafkaBridge` section.

{{< table caption="kafkaBridge section parameters" >}}
| Parameter                 | Description                                     | Type   | Allowed values                                 | Default                                                                      |
| ------------------------- | ----------------------------------------------- | ------ | ---------------------------------------------- | ---------------------------------------------------------------------------- |
| `enabled`                 | Whether to enable the kafka-bridge microservice | bool   | `true`, `false`                                | `false`                                                                      |
| `remotebootstrapServer`   | The URL of the remote Kafka broker              | string | Any                                            | ""                                                                           |
| `topicCreationLocalList`  | The list of topics to create locally            | string | Semicolon separated list of valid Kafka topics | ia.test.test.test.processValue;ia.test.test.test.count;umh.v1.kafka.newTopic |
| `topicCreationRemoteList` | The list of topics to create remotely           | string | Semicolon separated list of valid Kafka topics | ia.test.test.test.processValue;ia.test.test.test.count;umh.v1.kafka.newTopic |
| `topicmap`                | The list of topic maps of topics to forward     | object | [See below](#topic-map)                        | _empty_                                                                      |
{{< /table >}}

##### Topic Map

The `topicmap` parameter is a list of topic maps, each of which contains the
following parameters:

{{< table caption="topicmap section parameters" >}}
| Parameter        | Description                                                         | Type   | Allowed values                |
| ---------------- | ------------------------------------------------------------------- | ------ | ----------------------------- |
| `bidirectional`  | Whether to enable bidirectional communication for that topic        | bool   | `true`, `false`               |
| `name`           | The name of the map                                                 | string | HighIntegrity, HighThroughput |
| `send_direction` | The direction of the communication for that topic                   | string | to_remote, to_local           |
| `topic`          | The topic to forward. A regex can be used to match multiple topics. | string | Any valid Kafka topic         |
{{< /table >}}

For more information about the topic maps, see the
[kafka-bridge documentation](/docs/architecture/microservices/core/kafka-bridge/#configuration).

#### Kafka State Detector

The `_000_commonConfig.kafkaStateDetector` section contains the configuration
of the [kafka-state-detector](/docs/architecture/microservices/community/kafka-state-detector/)
microservice, responsible for detecting the state of the Kafka broker.

The following table lists the configurable parameters of the
`_000_commonConfig.kafkaStateDetector` section.

{{< table caption="kafkastatedetector section parameters" >}}
| Parameter | Description                                             | Type | Allowed values  | Default |
| --------- | ------------------------------------------------------- | ---- | --------------- | ------- |
| `enabled` | Whether to enable the kafka-state-detector microservice | bool | `true`, `false` | `false` |
{{< /table >}}

#### Debug

The `_000_commonConfig.debug` section contains the debug configuration for all
the microservices. This values should not be enabled in production.

The following table lists the configurable parameters of the
`_000_commonConfig.debug` section.

{{< table caption="debug section parameters" >}}
| Parameter       | Description                            | Type | Allowed values  | Default |
| --------------- | -------------------------------------- | ---- | --------------- | ------- |
| `enableFGTrace` | Whether to enable the foreground trace | bool | `true`, `false` | `false` |
{{< /table >}}

#### Tulip Connector

The `_000_commonConfig.tulipconnector` section contains the configuration of
the [tulip-connector](/docs/architecture/microservices/community/tulip-connector/)
microservice, responsible for connecting a Tulip instance with the United
Manufacturing Hub.

The following table lists the configurable parameters of the
`_000_commonConfig.tulipconnector` section.

{{< table caption="tulipconnector section parameters" >}}
| Parameter | Description                                        | Type   | Allowed values        | Default                     |
| --------- | -------------------------------------------------- | ------ | --------------------- | --------------------------- |
| `enabled` | Whether to enable the tulip-connector microservice | bool   | `true`, `false`       | `false`                     |
| `domain`  | The domain name pointing to you cluster            | string | Any valid domain name | tulip-connector.changme.com |
{{< /table >}}

### Custom microservices configuration

The `_001_customConfig` section contains a list of custom microservices
definitions. It can be used to deploy any application of your choice, which can
be configured using the following parameters:

{{< table caption="Custom microservices configuration parameters" >}}
| Parameter         | Description                                                                 | Type   | Allowed values                    | Default                                    |
| ----------------- | --------------------------------------------------------------------------- | ------ | --------------------------------- | ------------------------------------------ |
| `name`            | The name of the microservice                                                | string | Any                               | example                                    |
| `image`           | The image and tag of the microservice                                       | string | Any                               | hello-world:latest                         |
| `enabled`         | Whether to enable the microservice                                          | bool   | `true`, `false`                   | `false`                                    |
| `imagePullPolicy` | The image pull policy of the microservice                                   | string | "Always", "IfNotPresent", "Never" | "Always"                                   |
| `env`             | The list of environment variables to set for the microservice               | object | Any                               | [{name: LOGGING_LEVEL, value: PRODUCTION}] |
| `port`            | The internal port of the microservice to target                             | int    | Any                               | 80                                         |
| `externalPort`    | The host port to which expose the internal port                             | int    | Any                               | 8080                                       |
| `probePort`       | The port to use for the liveness and startup probes                         | int    | Any                               | 9091                                       |
| `startupProbe`    | The interval in seconds for the startup probe                               | int    | Any                               | 200                                        |
| `livenessProbe`   | The interval in seconds for the liveness probe                              | int    | Any                               | 500                                        |
| `statefulEnabled` | Create a PersistentVolumeClaim for the microservice and mount it in `/data` | bool   | `true`, `false`                   | `false`                                    |
{{< /table >}}

## Danger zone

The next sections contain a more advanced configuration of the microservices.
Usually, changing the values of the previous sections is enough to run the
United Manufacturing Hub. However, you may need to adjust some of the values
below if you want to change the default behavior of the microservices.

{{< notice warning >}}
Everything below this point  should not be changed, unless you know what you are doing.
{{< /notice >}}

{{< table caption="Danger zone advanced configuration" >}}
| Section                                            | Description                                                     |
| -------------------------------------------------- | --------------------------------------------------------------- |
| [`barcodereader`](#dz-barcodereader)               | Configuration for barcodereader                                 |
| [`console`](#dz-kafka-console)                     | Configuration for the Kafka console                             |
| [`factoryinput`](#dz-factoryinput)                 | Configuration for factoryinput                                  |
| [`factoryinsight`](#dz-factoryinsight)             | Configuration for factoryinsight                                |
| [`grafana`](#dz-grafana)                           | Configuration for Grafana                                       |
| [`grafanaproxy`](#dz-grafana-proxy)                | Configuration for the Grafana proxy                             |
| [`iotsensorsmqtt`](#dz-iotsensorsmqtt)             | Configuration for the IoTSensorsMQTT simulator                  |
| [`kafka`](#dz-kafka-broker)                        | Configuration for the Kafka broker                              |
| [`kafkabridge`](#dz-kafka-bridge)                  | Configuration for kafka-bridge                                  |
| [`kafkastatedetector`](#dz-kafka-state-detector)   | Configuration for kafka-state-detector                          |
| [`kafkatopostgresql`](#dz-kafka-to-postgresql)     | Configuration for kafka-to-postgresql                           |
| [`mqtt_broker`](#dz-mqtt-broker)                   | Configuration for the MQTT broker                               |
| [`mqttbridge`](#dz-mqtt-bridge)                    | Configuration for mqtt-bridge                                   |
| [`mqttkafkabridge`](#dz-mqtt-kafka-bridge)         | Configuration for mqtt-kafka-bridge                             |
| [`nodered`](#dz-node-red)                          | Configuration for Node-RED                                      |
| [`opcuasimulator`](#dz-opcua-simulator)            | Configuration for the OPC UA simulator                          |
| [`packmlmqttsimulator`](#dz-packml-mqtt-simulator) | Configuration for the PackML MQTT simulator                     |
| [`redis`](#dz-redis)                               | Configuration for Redis                                         |
| [`sensorconnect`](#dz-sensorconnect)               | Configuration for sensorconnect                                 |
| [`serviceAccount`](#service-account)               | Configuration for the service account used by the microservices |
| [`timescaledb-single`](#dz-timescaledb-single)     | Configuration for TimescaleDB                                   |
| [`tulipconnector`](#dz-tulip-connector)            | Configuration for tulip-connector                               |
{{< /table >}}

### Sections

#### barcodereader {#dz-barcodereader}

The `barcodereader` section contains the advanced configuration of the
[barcodereader](/docs/architecture/microservices/community/barcodereader/)
microservice.

{{< table caption="barcodereader advanced section parameters" >}}
| Parameter                   | Description                                                                     | Type   | Allowed values              | Default                                                 |
| --------------------------- | ------------------------------------------------------------------------------- | ------ | --------------------------- | ------------------------------------------------------- |
| `annotations`               | Annotations to add to the Kubernetes resources                                  | object | Any                         | {}                                                      |
| `enabled`                   | Whether to enable the barcodereader microservice                                | bool   | `true`, `false`             | `false`                                                 |
| `image.pullPolicy`          | The image pull policy                                                           | string | Always, IfNotPresent, Never | IfNotPresent                                            |
| `image.repository`          | The image of the barcodereader microservice                                     | string | Any                         | {{< resource type="docker" name="org" >}}/barcodereader |
| `image.tag`                 | The tag of the barcodereader microservice. Defaults to Chart version if not set | string | Any                         | {{< latest-semver >}}                                   |
| `resources.limits.cpu`      | The CPU limit                                                                   | string | Any                         | 10m                                                     |
| `resources.limits.memory`   | The memory limit                                                                | string | Any                         | 60Mi                                                    |
| `resources.requests.cpu`    | The CPU request                                                                 | string | Any                         | 2m                                                      |
| `resources.requests.memory` | The memory request                                                              | string | Any                         | 30Mi                                                    |
| `scanOnly`                  | Whether to only scan without sending the data to the Kafka broker               | bool   | `true`, `false`             | `false`                                                 |
{{< /table >}}

#### console {#dz-kafka-console}

The `console` section contains the advanced configuration of the
[Kafka console](/docs/architecture/microservices/core/kafka-console/)
microservice. This is based on the
[official RedPanda Console Helm chart](https://github.com/redpanda-data/helm-charts).
For more information about the parameters, see the
[official documentation](https://github.com/redpanda-data/helm-charts/blob/main/charts/redpanda/values.yaml).

Here are only the values different from the default ones.

{{< table caption="console advanced section parameters" >}}
| Parameter               | Description                                     | Type   | Allowed values  | Default                                                              |
| ----------------------- | ----------------------------------------------- | ------ | --------------- | -------------------------------------------------------------------- |
| `console.config`        | The configuration of the Kafka console          | object | Any             | See [console.config](#dz-kafka-console-config) section               |
| `extraVolumeMounts`     | Extra volume mounts to add to the Kafka console | array  | Any             | See [extraVolumeMounts](#dz-kafka-console-extravolumemounts) section |
| `extraVolumes`          | Extra volumes to add to the Kafka console       | array  | Any             | See [extraVolumes](#dz-kafka-console-extravolumes) section           |
| `serviceAccount.create` | Whether to create a service account             | bool   | `true`, `false` | `false`                                                              |
{{< /table >}}

##### console.config {#dz-kafka-console-config}

The `console.config` section contains the configuration of the Kafka console.
See the [reference config](https://github.com/redpanda-data/console/blob/master/docs/config/console.yaml)
for more information.

{{< table caption="console config parameters" >}}
| Parameter                | Description                                 | Type   | Allowed values  | Default                                                 |
| ------------------------ | ------------------------------------------- | ------ | --------------- | ------------------------------------------------------- |
| `kafka.brokers`          | The list of Kafka brokers                   | array  | Any             | {{< resource type="service" name="kafkabroker" >}}:9092 |
| `kafka.tls.caFilepath`   | The path to the CA certificate file         | string | Any             | `/SSL_certs/kafka/ca.crt`                               |
| `kafka.tls.certFilepath` | The path to the certificate file            | string | Any             | `/SSL_certs/kafka/tls.crt`                              |
| `kafka.tls.enabled`      | Whether to enable TLS for the Kafka brokers | bool   | `true`, `false` | `false`                                                 |
| `kafka.tls.keyFilepath`  | The path to the key file                    | string | Any             | `/SSL_certs/kafka/tls.key`                              |
{{< /table >}}

##### extraVolumeMounts {#dz-kafka-console-extravolumemounts}

Here you can find the default values for the `extraVolumeMounts` parameter.

```yaml
extraVolumeMounts: |-
  - name: united-manfacturing-hub-kowl-certificates
    mountPath: /SSL_certs/kafka
    readOnly: true
```

##### extraVolumes {#dz-kafka-console-extravolumes}

Here you can find the default values for the `extraVolumes` parameter.

```yaml
extraVolumes: |-
  - name: united-manfacturing-hub-kowl-certificates
    secret:
      secretName: {{< resource type="secret" name="kafkaconsole-tls" >}}
```

#### factoryinput {#dz-factoryinput}

The `factoryinput` section contains the advanced configuration of the
[factoryinput](/docs/architecture/microservices/community/factoryinput/)
microservice.

{{< table caption="factoryinput advanced section parameters" >}}
| Parameter                | Description                                                                    | Type   | Allowed values              | Default                                                |
| ------------------------ | ------------------------------------------------------------------------------ | ------ | --------------------------- | ------------------------------------------------------ |
| `enabled`                | Whether to enable the factoryinput microservice                                | bool   | `true`, `false`             | `false`                                                |
| `env`                    | The environment variables                                                      | object | Any                         | See [env](#dz-factoryinput-env) section                |
| `image.pullPolicy`       | The image pull policy                                                          | string | Always, IfNotPresent, Never | IfNotPresent                                           |
| `image.repository`       | The image of the factoryinput microservice                                     | string | Any                         | {{< resource type="docker" name="org" >}}/factoryinput |
| `image.tag`              | The tag of the factoryinput microservice. Defaults to Chart version if not set | string | Any                         | {{< latest-semver >}}                                  |
| `mqtt.encryptedPassword` | The encrypted password of the MQTT broker                                      | string | Any                         | _Base 64 encrypted password_                           |
| `mqtt.password`          | The password of the MQTT broker                                                | string | Any                         | INSECURE_INSECURE_INSECURE                             |
| `pdb.enabled`            | Whether to enable a PodDisruptionBudget                                        | bool   | `true`, `false`             | `true`                                                 |
| `pdb.minAvailable`       | The minimum number of available pods                                           | int    | Any                         | 1                                                      |
| `replicas`               | The number of Pod replicas                                                     | int    | Any                         | 1                                                      |
| `service.annotations`    | Annotations to add to the factoryinput Service                                 | object | Any                         | {}                                                     |
| `storageRequest`         | The amount of storage for the PersistentVolumeClaim                            | string | Any                         | 1Gi                                                    |
| `user`                   | The user of factoryinput                                                       | string | Any                         | factoryinsight                                         |
{{< /table >}}

##### env {#dz-factoryinput-env}

The `env` section contains the configuration of the environment variables to add
to the Pod.

{{< table caption="factoryinput env parameters" >}}
| Parameter          | Description                                                                  | Type   | Allowed values          | Default    |
| ------------------ | ---------------------------------------------------------------------------- | ------ | ----------------------- | ---------- |
| `loggingLevel`     | The logging level of the factoryinput microservice                           | string | PRODUCTION, DEVELOPMENT | PRODUCTION |
| `mqttQueueHandler` | Number of queue workers to spawn                                             | int    | 0-65535                 | 10         |
| `version`          | The version of the API used. Each version also enables all the previous ones | int    | Any                     | 2          |
{{< /table >}}

#### factoryinsight {#dz-factoryinsight}

The `factoryinsight` section contains the advanced configuration of the
[factoryinsight](/docs/architecture/microservices/core/factoryinsight/)
microservice.

{{< table caption="factoryinsight advanced section parameters" >}}
| Parameter                      | Description                                                                      | Type   | Allowed values              | Default                                                  |
| ------------------------------ | -------------------------------------------------------------------------------- | ------ | --------------------------- | -------------------------------------------------------- |
| `db_database`                  | The database name                                                                | string | Any                         | factoryinsight                                           |
| `db_host`                      | The host of the database                                                         | string | Any                         | {{< resource type="service" name="database" >}}          |
| `db_user`                      | The database user                                                                | string | Any                         | factoryinsight                                           |
| `enabled`                      | Whether to enable the factoryinsight microservice                                | bool   | `true`, `false`             | `false`                                                  |
| `hpa.enabled`                  | Whether to enable a HorizontalPodAutoscaler                                      | bool   | `true`, `false`             | `false`                                                  |
| `image.pullPolicy`             | The image pull policy                                                            | string | Always, IfNotPresent, Never | IfNotPresent                                             |
| `image.repository`             | The image of the factoryinsight microservice                                     | string | Any                         | {{< resource type="docker" name="org" >}}/factoryinsight |
| `image.tag`                    | The tag of the factoryinsight microservice. Defaults to Chart version if not set | string | Any                         | {{< latest-semver >}}                                    |
| `ingress.enabled`              | Whether to enable an Ingress                                                     | bool   | `true`, `false`             | `false`                                                  |
| `ingress.publicHostSecretName` | The secret name of the public host of the Ingress                                | string | Any                         | ""                                                       |
| `ingress.publicHost`           | The public host of the Ingress                                                   | string | Any                         | ""                                                       |
| `insecure_no_auth`             | Whether to enable the insecure_no_auth mode                                      | bool   | `true`, `false`             | `false`                                                  |
| `pdb.enabled`                  | Whether to enable a PodDisruptionBudget                                          | bool   | `true`, `false`             | `false`                                                  |
| `redis`                        | The Redis configuration                                                          | object | Any                         | See [redis](#dz-factoryinsight-redis) section            |
| `replicas`                     | The number of Pod replicas                                                       | int    | Any                         | 2                                                        |
| `resources.limits.cpu`         | The CPU limit                                                                    | string | Any                         | 200m                                                     |
| `resources.limits.memory`      | The memory limit                                                                 | string | Any                         | 200Mi                                                    |
| `resources.requests.cpu`       | The CPU request                                                                  | string | Any                         | 50m                                                      |
| `resources.requests.memory`    | The memory request                                                               | string | Any                         | 50Mi                                                     |
| `service.annotations`          | Annotations to add to the factoryinsight Service                                 | object | Any                         | {}                                                       |
| `user`                         | The user of factoryinsight                                                       | string | Any                         | factoryinsight                                           |
| `version`                      | The version of the API used. Each version also enables all the previous ones     | int    | Any                         | 2                                                        |
{{< /table >}}

##### redis {#dz-factoryinsight-redis}

The `redis` section contains the configuration of the Redis instance used by
factoryinsight.

```yaml
URI1: {{< resource type="pod" name="cache" >}}.{{< resource type="service" name="cache-headless" >}}:26379
```

It is possible to add more Redis instances by adding a new `URI` key.

#### grafana {#dz-grafana}

The `grafana` section contains the advanced configuration of the
[grafana](/docs/architecture/microservices/core/grafana/) microservice. This is
based on the [official Grafana Helm chart](https://github.com/grafana/helm-charts).
For more information about the parameters, please refer to the
[official documentation](https://github.com/grafana/helm-charts/blob/main/charts/grafana/README.md#configuration).

Here are only the values different from the default ones.

{{< table caption="grafana advanced section parameters" >}}
| Parameter                          | Description                                                                 | Type   | Allowed values          | Default                                                            |
| ---------------------------------- | --------------------------------------------------------------------------- | ------ | ----------------------- | ------------------------------------------------------------------ |
| `admin.existingSecret`             | The name of the secret containing the admin password                        | string | Any                     | {{< resource type="secret" name="grafana" >}}                      |
| `admin.passwordKey`                | The key of the admin password in the secret                                 | string | Any                     | adminpassword                                                      |
| `admin.userKey`                    | The key of the admin password in the secret                                 | string | Any                     | adminuser                                                          |
| `datasources`                      | The datasources configuration.                                              | object | Any                     | See [datasources](#dz-grafana-datasources) section                 |
| `envValueFrom`                     | Environment variables to add to the Pod, from a secret or a configmap       | object | Any                     | See [envValueFrom](#dz-grafana-envValueFrom) section               |
| `env`                              | Environment variables to add to the Pod                                     | object | Any                     | See [env](#dz-grafana-env) section                                 |
| `extraInitContainers`              | Extra init containers to add to the Pod                                     | object | Any                     | See [extraInitContainers](#dz-grafana-extraInitContainers) section |
| `grafana.ini`                      | The grafana.ini configuration.                                              | object | Any                     | See [grafana.ini](#dz-grafana-grafana.ini) section                 |
| `initChownData.enabled`            | Whether to enable the initChownData job, to reset data ownership at startup | bool   | `true`, `false`         | `true`                                                             |
| `persistence.enabled`              | Whether to enable persistence                                               | bool   | `true`, `false`         | `true`                                                             |
| `persistence.size`                 | The size of the persistent volume                                           | string | Any                     | 5Gi                                                                |
| `podDisruptionBudget.minAvailable` | The minimum number of available pods                                        | int    | Any                     | 1                                                                  |
| `service.port`                     | The port of the Service                                                     | int    | Any                     | 8080                                                               |
| `service.type`                     | The type of Service to expose                                               | string | ClusterIP, LoadBalancer | LoadBalancer                                                       |
| `serviceAccount.create`            | Whether to create a ServiceAccount                                          | bool   | `true`, `false`         | `false`                                                            |
| `testFramework.enabled`            | Whether to enable the test framework                                        | bool   | `true`, `false`         | `false`                                                            |
{{< /table >}}

##### datasources {#dz-grafana-datasources}

The `datasources` section contains the configuration of the datasources
provisioning. See the
[Grafana documentation](https://grafana.com/docs/grafana/latest/administration/provisioning/#data-sources)
for more information.

```yaml
datasources.yaml:
  apiVersion: 1
  datasources:
    - name: umh-v2-datasource
      # <string, required> datasource type. Required
      type: umh-v2-datasource
      # <string, required> access mode. proxy or direct (Server or Browser in the UI). Required
      access: proxy
      # <int> org id. will default to orgId 1 if not specified
      orgId: 1
      url: "http://united-manufacturing-hub-factoryinsight-service/"
      jsonData:
        customerID: $FACTORYINSIGHT_CUSTOMERID
        apiKey: $FACTORYINSIGHT_PASSWORD
        baseURL: "http://united-manufacturing-hub-factoryinsight-service/"
        apiKeyConfigured: true
      version: 1
      # <bool> allow users to edit datasources from the UI.
      isDefault: false
      editable: false
    # <string, required> name of the datasource. Required
    - name: umh-datasource
      # <string, required> datasource type. Required
      type: umh-datasource
      # <string, required> access mode. proxy or direct (Server or Browser in the UI). Required
      access: proxy
      # <int> org id. will default to orgId 1 if not specified
      orgId: 1
      url: "http://united-manufacturing-hub-factoryinsight-service/"
      jsonData:
        customerId: $FACTORYINSIGHT_CUSTOMERID
        apiKey: $FACTORYINSIGHT_PASSWORD
        serverURL: "http://united-manufacturing-hub-factoryinsight-service/"
        apiKeyConfigured: true
      version: 1
      # <bool> allow users to edit datasources from the UI.
      isDefault: true
      editable: false
    # <string, required> name of the datasource. Required
```

##### envValueFrom {#dz-grafana-envValueFrom}

The `envValueFrom` section contains the configuration of the environment
variables to add to the Pod, from a secret or a configmap.

{{< table caption="grafana envValueFrom section parameters" >}}
| Parameter                   | Description                                                      | Value from   | Name                                                 | Key        |
| --------------------------- | ---------------------------------------------------------------- | ------------ | ---------------------------------------------------- | ---------- |
| `FACTORYINSIGHT_APIKEY`     | The API key to use to authenticate to the Factoryinsight API     | secretKeyRef | {{< resource type="secret" name="factoryinsight" >}} | apiKey     |
| `FACTORYINSIGHT_BASEURL`    | The base URL of the Factoryinsight API                           | secretKeyRef | {{< resource type="secret" name="factoryinsight" >}} | baseURL    |
| `FACTORYINSIGHT_CUSTOMERID` | The customer ID to use to authenticate to the Factoryinsight API | secretKeyRef | {{< resource type="secret" name="factoryinsight" >}} | customerID |
| `FACTORYINSIGHT_PASSWORD`   | The password to use to authenticate to the Factoryinsight API    | secretKeyRef | {{< resource type="secret" name="factoryinsight" >}} | password   |
{{< /table >}}

##### env {#dz-grafana-env}

The `env` section contains the configuration of the environment variables to add
to the Pod.

{{< table caption="grafana env section parameters" >}}
| Parameter                                   | Description                                                                     | Type   | Allowed values       | Default                                                 |
| ------------------------------------------- | ------------------------------------------------------------------------------- | ------ | -------------------- | ------------------------------------------------------- |
| `GF_PLUGINS_ALLOW_LOADING_UNSIGNED_PLUGINS` | List of plugin identifiers to allow loading even if they lack a valid signature | string | Comma separated list | umh-datasource,umh-factoryinput-panel,umh-v2-datasource |
{{< /table >}}

##### extraInitContainers {#dz-grafana-extraInitContainers}

The `extraInitContainers` section contains the configuration of the extra init
containers to add to the Pod.

The init-plugins container is used to install the default plugins shipped with
the UMH version of Grafana without the need to have an internet connection.
See the [documentation](/docs/architecture/microservices/core/grafana/#configuration)
for a list of the plugins.

```yaml
- image: unitedmanufacturinghub/grafana-umh:1.2.0
  name: init-plugins
  imagePullPolicy: IfNotPresent
  command: ['sh', '-c', 'cp -r /plugins /var/lib/grafana/']
  volumeMounts:
    - name: storage
      mountPath: /var/lib/grafana
```

##### grafana.ini {#dz-grafana-grafana.ini}

The `grafana.ini` section contains the configuration of the grafana.ini file.
See the [Grafana documentation](http://docs.grafana.org/installation/configuration/)
for more information.

```yaml
paths:
  data: /var/lib/grafana/data
  logs: /var/log/grafana
  plugins: /var/lib/grafana/plugins
  provisioning: /etc/grafana/provisioning
database:
  host: united-manufacturing-hub
  user: "grafana"
  name: "grafana"
  password: "changeme"
  ssl_mode: require
  type: postgres
```

#### grafanaproxy {#dz-grafana-proxy}

The `grafanaproxy` section contains the configuration of the
[Grafana proxy](/docs/architecture/microservices/community/grafana-proxy/)
microservice.

{{< table caption="grafanaproxy section parameters" >}}
| Parameter                | Description                                                                     | Type   | Allowed values              | Default                                                 |
| ------------------------ | ------------------------------------------------------------------------------- | ------ | --------------------------- | ------------------------------------------------------- |
| `enabled`                | Whether to enable the Grafana proxy microservice                                | bool   | `true`, `false`             | `true`                                                  |
| `image.pullPolicy`       | The image pull policy                                                           | string | Always, IfNotPresent, Never | IfNotPresent                                            |
| `image.repository`       | The image of the grafana-proxy microservice                                     | string | Any                         | {{< resource type="docker" name="org" >}}/barcodereader |
| `image.tag`              | The tag of the grafana-proxy microservice. Defaults to Chart version if not set | string | Any                         | {{< latest-semver >}}                                   |
| `replicas`               | The number of Pod replicas                                                      | int    | Any                         | 1                                                       |
| `service.annotations`    | Annotations to add to the service                                               | object | Any                         | {}                                                      |
| `service.port`           | The port of the service                                                         | int    | Any                         | 2096                                                    |
| `service.type`           | The type of the service                                                         | string | ClusterIP, LoadBalancer     | LoadBalancer                                            |
| `service.targetPort`     | The target port of the service                                                  | int    | Any                         | 80                                                      |
| `service.protocol`       | The protocol of the service                                                     | string | TCP, UDP                    | TCP                                                     |
| `service.name`           | The name of the port of the service                                             | string | Any                         | service                                                 |
| `resources.limits.cpu`   | The CPU limit                                                                   | string | Any                         | 1000m                                                   |
| `resources.requests.cpu` | The CPU request                                                                 | string | Any                         | 200m                                                    |
{{< /table >}}

#### iotsensorsmqtt {#dz-iotsensorsmqtt}

The `iotsensorsmqtt` section contains the configuration of the IoT Sensors MQTT
microservice.

{{< table caption="iotsensorsmqtt section parameters" >}}
| Parameter                   | Description                                                               | Type   | Allowed values | Default                      |
| --------------------------- | ------------------------------------------------------------------------- | ------ | -------------- | ---------------------------- |
| `image`                     | The image of the iotsensorsmqtt microservice                              | string | Any            | amineamaach/sensors-mqtt     |
| `mqtt.encryptedPassword`    | The encrypted password of the MQTT broker                                 | string | Any            | _Base 64 encrypted password_ |
| `mqtt.password`             | The password of the MQTT broker                                           | string | Any            | INSECURE_INSECURE_INSECURE   |
| `resources.limits.cpu`      | The CPU limit                                                             | string | Any            | 10m                          |
| `resources.limits.memory`   | The memory limit                                                          | string | Any            | 20Mi                         |
| `resources.requests.cpu`    | The CPU request                                                           | string | Any            | 100m                         |
| `resources.requests.memory` | The memory request                                                        | string | Any            | 100Mi                        |
| `tag`                       | The tag of the iotsensorsmqtt microservice. Defaults to latest if not set | string | Any            | v1.0.0                       |
{{< /table >}}

#### kafka {#dz-kafka-broker}

The `kafka` section contains the configuration of the
[Kafka broker](/docs/architecture/microservices/core/kafka-broker). This is
based on the [Bitnami Kafka chart](https://github.com/bitnami/charts/tree/main/bitnami/kafka/).
For more information about the parameters, see the
[official documentation](https://github.com/bitnami/charts/tree/main/bitnami/kafka/#parameters).

Here are only the values different from the default ones.

{{< table caption="kafka section parameters" >}}
| Parameter                        | Description                                                                       | Type         | Allowed values  | Default                                           |
| -------------------------------- | --------------------------------------------------------------------------------- | ------------ | --------------- | ------------------------------------------------- |
| `auth.tls.existingSecrets`       | The existing secrets to use for TLS authentication                                | string array | Any             | {{< resource type="secret" name="kafkabroker" >}} |
| `auth.tls.type`                  | The type of TLS authentication                                                    | string       | jks, pem        | pem                                               |
| `heapOpts`                       | The heap options of the Kafka container                                           | string       | Any             | -Xmx2048m -Xms2048m                               |
| `livenessProbe.failureThreshold` | The number of times the liveness probe can fail before the container is restarted | int          | Any             | 10                                                |
| `livenessProbe.timeoutSeconds`   | The number of seconds after which the liveness probe times out                    | int          | Any             | 10                                                |
| `logRetentionBytes`              | The log retention size                                                            | int          | Any             | 26214400                                          |
| `logSegmentBytes`                | The log segment size                                                              | int          | Any             | 10485760                                          |
| `numPartitions`                  | The number of partitions                                                          | int          | Any             | 6                                                 |
| `resources.limits.cpu`           | The CPU limit                                                                     | string       | Any             | 1000m                                             |
| `resources.limits.memory`        | The memory limit                                                                  | string       | Any             | 4Gi                                               |
| `resources.requests.cpu`         | The CPU request                                                                   | string       | Any             | 100m                                              |
| `resources.requests.memory`      | The memory request                                                                | string       | Any             | 2560Mi                                            |
| `serviceAccount.create`          | Whether to create a service account                                               | bool         | `true`, `false` | `false`                                           |
| `startupProbe.enabled`           | Whether to enable the startup probe                                               | bool         | `true`, `false` | `true`                                            |
| `startupProbe.failureThreshold`  | The number of times the startup probe can fail before the container is restarted  | int          | Any             | 600                                               |
| `startupProbe.periodSeconds`     | The number of seconds between the startup probe checks                            | int          | Any             | 10                                                |
| `startupProbe.timeoutSeconds`    | The number of seconds after which the startup probe times out                     | int          | Any             | 10                                                |
| `zookeeper.heapSize`             | The heap size of the Zookeeper container                                          | int          | Any             | 128                                               |
{{< /table >}}

#### kafkabridge {#dz-kafka-bridge}

The `kafkabridge` section contains the configuration of the
[Kafka bridge](/docs/architecture/microservices/core/kafka-bridge).

{{< table caption="kafkabridge section parameters" >}}
| Parameter                  | Description                                                                    | Type   | Allowed values              | Default                                                |
| -------------------------- | ------------------------------------------------------------------------------ | ------ | --------------------------- | ------------------------------------------------------ |
| `image.pullPolicy`         | The image pull policy                                                          | string | Always, IfNotPresent, Never | IfNotPresent                                           |
| `image.repository`         | The image of the kafka-bridge microservice                                     | string | Any                         | {{< resource type="docker" name="org" >}}/kafka-bridge |
| `image.tag`                | The tag of the kafka-bridge microservice. Defaults to Chart version if not set | string | Any                         | {{< latest-semver >}}                                  |
| `initContainer.pullPolicy` | The image pull policy of the init container                                    | string | Always, IfNotPresent, Never | IfNotPresent                                           |
| `initContainer.repository` | The image of the init container                                                | string | Any                         | {{< resource type="docker" name="org" >}}/kafka-init   |
| `initContainer.tag`        | The tag of the init container. Defaults to Chart version if not set            | string | Any                         | {{< latest-semver >}}                                  |
{{< /table >}}

#### kafkastatedetector {#dz-kafka-state-detector}

The `kafkastatedetector` section contains the configuration of the
[Kafka state detector](/docs/architecture/microservices/community/kafka-state-detector).

{{< table caption="kafkastatedetector section parameters" >}}
| Parameter          | Description                                                                          | Type   | Allowed values              | Default                                                        |
| ------------------ | ------------------------------------------------------------------------------------ | ------ | --------------------------- | -------------------------------------------------------------- |
| `activityEnabled`  | Controls wheter to check the activity of the Kafka broker                            | bool   | `true`, `false`             | `true`                                                         |
| `anomalyEnabled`   | Controls wheter to check for anomalies in the Kafka broker                           | bool   | `true`, `false`             | `true`                                                         |
| `enabled`          | Whether to enable the Kafka state detector                                           | bool   | `true`, `false`             | `true`                                                         |
| `image.pullPolicy` | The image pull policy                                                                | string | Always, IfNotPresent, Never | IfNotPresent                                                   |
| `image.repository` | The image of the kafkastatedetector microservice                                     | string | Any                         | {{< resource type="docker" name="org" >}}/kafka-state-detector |
| `image.tag`        | The tag of the kafkastatedetector microservice. Defaults to Chart version if not set | string | Any                         | {{< latest-semver >}}                                          |
{{< /table >}}

#### kafkatopostgresql {#dz-kafka-to-postgresql}

The `kafkatopostgresql` section contains the configuration of the
[Kafka to PostgreSQL](/docs/architecture/microservices/core/kafka-to-postgresql) microservice.

{{< table caption="kafkatopostgresql section parameters" >}}
| Parameter                   | Description                                                                         | Type   | Allowed values              | Default                                                       |
| --------------------------- | ----------------------------------------------------------------------------------- | ------ | --------------------------- | ------------------------------------------------------------- |
| `enabled`                   | Whether to enable the Kafka to PostgreSQL microservice                              | bool   | `true`, `false`             | `true`                                                        |
| `image.pullPolicy`          | The image pull policy                                                               | string | Always, IfNotPresent, Never | IfNotPresent                                                  |
| `image.repository`          | The image of the kafkatopostgresql microservice                                     | string | Any                         | {{< resource type="docker" name="org" >}}/kafka-to-postgresql |
| `image.tag`                 | The tag of the kafkatopostgresql microservice. Defaults to Chart version if not set | string | Any                         | {{< latest-semver >}}                                         |
| `initContainer.pullPolicy`  | The image pull policy of the init container                                         | string | Always, IfNotPresent, Never | IfNotPresent                                                  |
| `initContainer.repository`  | The image of the init container                                                     | string | Any                         | {{< resource type="docker" name="org" >}}/kafka-init          |
| `initContainer.tag`         | The tag of the init container. Defaults to Chart version if not set                 | string | Any                         | {{< latest-semver >}}                                         |
| `replicas`                  | The number of Pod replicas                                                          | int    | Any                         | 1                                                             |
| `resources.limits.cpu`      | The CPU limit                                                                       | string | Any                         | 200m                                                          |
| `resources.limits.memory`   | The memory limit                                                                    | string | Any                         | 200Mi                                                         |
| `resources.requests.cpu`    | The CPU request                                                                     | string | Any                         | 50m                                                           |
| `resources.requests.memory` | The memory request                                                                  | string | Any                         | 50Mi                                                          |
{{< /table >}}

#### mqtt_broker {#dz-mqtt-broker}

The `mqtt_broker` section contains the configuration of the
[MQTT broker](/docs/architecture/microservices/core/mqtt-broker).

{{< table caption="mqtt_broker section parameters" >}}
| Parameter                     | Description                                                            | Type         | Allowed values              | Default                                                                                                                                                                                                                                                                                      |
| ----------------------------- | ---------------------------------------------------------------------- | ------------ | --------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `image.pullPolicy`            | The image pull policy                                                  | string       | Always, IfNotPresent, Never | IfNotPresent                                                                                                                                                                                                                                                                                 |
| `image.repository`            | The image of the mqtt_broker microservice                              | string       | Any                         | hivemq/hivemq-ce                                                                                                                                                                                                                                                                             |
| `image.tag`                   | The tag of the mqtt_broker microservice. Defaults to 2022.1 if not set | string       | Any                         | 2022.1                                                                                                                                                                                                                                                                                       |
| `initContainer`               | The init container configuration                                       | object       | Any                         | See [initContainer](#dz-mqtt-broker-initcontainer) section                                                                                                                                                                                                                                   |
| `persistence.extension.size`  | The size of the persistence volume for the extensions                  | string       | Any                         | 100Mi                                                                                                                                                                                                                                                                                        |
| `persistence.storage.size`    | The size of the persistence volume for the storage                     | string       | Any                         | 2Gi                                                                                                                                                                                                                                                                                          |
| `rbacEnabled`                 | Whether to enable RBAC                                                 | bool         | `true`, `false`             | `false`                                                                                                                                                                                                                                                                                      |
| `resources.limits.cpu`        | The CPU limit                                                          | string       | Any                         | 500m                                                                                                                                                                                                                                                                                         |
| `resources.limits.memory`     | The memory limit                                                       | string       | Any                         | 500Mi                                                                                                                                                                                                                                                                                        |
| `resources.requests.cpu`      | The CPU request                                                        | string       | Any                         | 100m                                                                                                                                                                                                                                                                                         |
| `resources.requests.memory`   | The memory request                                                     | string       | Any                         | 100Mi                                                                                                                                                                                                                                                                                        |
| `service.mqtt.enabled`        | Whether to enable the MQTT service                                     | bool         | `true`, `false`             | `true`                                                                                                                                                                                                                                                                                       |
| `service.mqtt.port`           | The port of the MQTT service                                           | int          | Any                         | 1883                                                                                                                                                                                                                                                                                         |
| `service.mqtts.cipher_suites` | The ciphersuites to enable                                             | string array | Any                         | TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384, TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256, TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256, TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA, TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA, TLS_RSA_WITH_AES_128_GCM_SHA256, TLS_RSA_WITH_AES_128_CBC_SHA, TLS_RSA_WITH_AES_256_CBC_SHA |
| `service.mqtts.enabled`       | Whether to enable the MQTT over TLS service                            | bool         | `true`, `false`             | `true`                                                                                                                                                                                                                                                                                       |
| `service.mqtts.port`          | The port of the MQTT over TLS service                                  | int          | Any                         | 8883                                                                                                                                                                                                                                                                                         |
| `service.mqtts.tls_versions`  | The TLS versions to enable                                             | string array | Any                         | TLSv1.3, TLSv1.2                                                                                                                                                                                                                                                                             |
| `service.type`                | The type of the service                                                | string       | ClusterIP, LoadBalancer     | LoadBalancer                                                                                                                                                                                                                                                                                 |
| `service.ws.enabled`          | Whether to enable the WebSocket service                                | bool         | `true`, `false`             | `false`                                                                                                                                                                                                                                                                                      |
| `service.ws.port`             | The port of the WebSocket service                                      | int          | Any                         | 8080                                                                                                                                                                                                                                                                                         |
| `service.wss.cipher_suites`   | The ciphersuites to enable                                             | string array | Any                         | TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384, TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256, TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256, TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA, TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA, TLS_RSA_WITH_AES_128_GCM_SHA256, TLS_RSA_WITH_AES_128_CBC_SHA, TLS_RSA_WITH_AES_256_CBC_SHA |
| `service.wss.enabled`         | Whether to enable the WebSocket over TLS service                       | bool         | `true`, `false`             | `false`                                                                                                                                                                                                                                                                                      |
| `service.wss.port`            | The port of the WebSocket over TLS service                             | int          | Any                         | 8443                                                                                                                                                                                                                                                                                         |
| `service.wss.tls_versions`    | The TLS versions to enable                                             | string array | Any                         | TLSv1.3, TLSv1.2                                                                                                                                                                                                                                                                             |
{{< /table >}}

##### initContainer {#dz-mqtt-broker-initcontainer}

The `initContainer` section contains the configuration for the init containers.
By default, the hivemqextensioninit container is used to initialize the HiveMQ
extensions.

```yaml
initContainer:
  hivemqextensioninit:
    image:
      repository: unitedmanufacturinghub/hivemq-init
      tag: 2.0.0
      pullPolicy: IfNotPresent
```

#### mqttbridge {#dz-mqtt-bridge}

The `mqttbridge` section contains the configuration of the
[MQTT bridge](/docs/architecture/microservices/core/mqtt-bridge).

{{< table caption="mqttbridge section parameters" >}}
| Parameter                   | Description                                                                   | Type   | Allowed values | Default                                               |
| --------------------------- | ----------------------------------------------------------------------------- | ------ | -------------- | ----------------------------------------------------- |
| `image`                     | The image of the mqtt-bridge microservice                                     | string | Any            | {{< resource type="docker" name="org" >}}/mqtt-bridge |
| `mqtt.encryptedPassword`    | The encrypted password of the MQTT broker                                     | string | Any            | _Base 64 encrypted password_                          |
| `mqtt.password`             | The password of the MQTT broker                                               | string | Any            | INSECURE_INSECURE_INSECURE                            |
| `resources.limits.cpu`      | The CPU limit                                                                 | string | Any            | 200m                                                  |
| `resources.limits.memory`   | The memory limit                                                              | string | Any            | 100Mi                                                 |
| `resources.requests.cpu`    | The CPU request                                                               | string | Any            | 100m                                                  |
| `resources.requests.memory` | The memory request                                                            | string | Any            | 20Mi                                                  |
| `storageRequest`            | The amount of storage for the PersistentVolumeClaim                           | string | Any            | 1Gi                                                   |
| `tag`                       | The tag of the mqtt-bridge microservice. Defaults to Chart version if not set | string | Any            | {{< latest-semver >}}                                 |
{{< /table >}}

#### mqttkafkabridge {#dz-mqtt-kafka-bridge}

The `mqttkafkabridge` section contains the configuration of the
[MQTT-Kafka bridge](/docs/architecture/microservices/core/mqtt-kafka-bridge).

{{< table caption="mqttkafkabridge section parameters" >}}
| Parameter                   | Description                                                                         | Type   | Allowed values  | Default                                                     |
| --------------------------- | ----------------------------------------------------------------------------------- | ------ | --------------- | ----------------------------------------------------------- |
| `enabled`                   | Whether to enable the MQTT-Kafka bridge                                             | bool   | `true`, `false` | `false`                                                     |
| `image.pullPolicy`          | The pull policy of the mqtt-kafka-bridge microservice                               | string | Any             | IfNotPresent                                                |
| `image.repository`          | The image of the mqtt-kafka-bridge microservice                                     | string | Any             | {{< resource type="docker" name="org" >}}/mqtt-kafka-bridge |
| `image.tag`                 | The tag of the mqtt-kafka-bridge microservice. Defaults to Chart version if not set | string | Any             | {{< latest-semver >}}                                       |
| `initContainer.pullPolicy`  | The pull policy of the init container                                               | string | Any             | IfNotPresent                                                |
| `initContainer.repository`  | The image of the init container                                                     | string | Any             | {{< resource type="docker" name="org" >}}/kafka-init        |
| `initContainer.tag`         | The tag of the init container. Defaults to Chart version if not set                 | string | Any             | {{< latest-semver >}}                                       |
| `kafkaAcceptNoOrigin`       | Allow access to the Kafka broker without a valid x-trace                            | bool   | `true`, `false` | `false`                                                     |
| `kafkaSenderThreads`        | The number of threads for sending messages to the Kafka broker                      | int    | Any             | 1                                                           |
| `messageLRUSize`            | The size of the LRU cache for messages                                              | int    | Any             | 100000                                                      |
| `mqtt.encryptedPassword`    | The encrypted password of the MQTT broker                                           | string | Any             | _Base 64 encrypted password_                                |
| `mqtt.password`             | The password of the MQTT broker                                                     | string | Any             | INSECURE_INSECURE_INSECURE                                  |
| `mqttSenderThreads`         | The number of threads for sending messages to the MQTT broker                       | int    | Any             | 1                                                           |
| `pdb.enabled`               | Whether to enable the pod disruption budget                                         | bool   | `true`, `false` | `true`                                                      |
| `pdb.minAvailable`          | The minimum number of pods that must be available                                   | int    | Any             | 1                                                           |
| `rawMessageLRUSize`         | The size of the LRU cache for raw messages                                          | int    | Any             | 100000                                                      |
| `resources.limits.cpu`      | The CPU limit                                                                       | string | Any             | 500m                                                        |
| `resources.limits.memory`   | The memory limit                                                                    | string | Any             | 750Mi                                                       |
| `resources.requests.cpu`    | The CPU request                                                                     | string | Any             | 100m                                                        |
| `resources.requests.memory` | The memory request                                                                  | string | Any             | 500Mi                                                       |
{{< /table >}}

#### nodered {#dz-node-red}

The `nodered` section contains the configuration of the
[Node-RED](/docs/architecture/microservices/core/node-red) microservice.

{{< table caption="nodered section parameters" >}}
| Parameter                      | Description                                                | Type   | Allowed values          | Default                                                                                |
| ------------------------------ | ---------------------------------------------------------- | ------ | ----------------------- | -------------------------------------------------------------------------------------- |
| `env`                          | Environment variables to add to the Pod                    | object | Any                     | See [env](#dz-node-red-env) section                                                    |
| `flows`                        | A JSON string containing the flows to import into Node-RED | string | Any                     | See the [documentation](/docs/architecture/microservices/core/node-red/#how-it-works)  |
| `ingress.enabled`              | Whether to enable the ingress                              | bool   | `true`, `false`         | `false`                                                                                |
| `ingress.publicHostSecretName` | The secret name of the public host of the Ingress          | string | Any                     | ""                                                                                     |
| `ingress.publicHost`           | The public host of the Ingress                             | string | Any                     | ""                                                                                     |
| `mqtt.encryptedPassword`       | The encrypted password of the MQTT broker                  | string | Any                     | _Base 64 encrypted password_                                                           |
| `port`                         | The port of the Node-RED service                           | int    | Any                     | 1880                                                                                   |
| `serviceType`                  | The type of the service                                    | string | ClusterIP, LoadBalancer | LoadBalancer                                                                           |
| `settings`                     | A JSON string containing the settings of Node-RED          | string | Any                     | See the [documentation](/docs/architecture/microservices/core/node-red/#configuration) |
| `storageRequest`               | The amount of storage for the PersistentVolumeClaim        | string | Any                     | 1Gi                                                                                    |
| `tag`                          | The Node-RED version                                       | string | Any                     | 2.0.6                                                                                  |
| `timezone`                     | The timezone                                               | string | Any                     | Berlin/Europe                                                                          |
{{< /table >}}

##### env {#dz-node-red-env}

The `env` section contains the environment variables to add to the Pod.

{{< table caption="env section parameters" >}}
| Parameter                   | Description                     | Type | Allowed values  | Default |
| --------------------------- | ------------------------------- | ---- | --------------- | ------- |
| `NODE_RED_ENABLE_SAVE_MODE` | Whether to enable the save mode | bool | `true`, `false` | `false` |
{{< /table >}}

#### opcuasimulator {#dz-opcua-simulator}

The `opcuasimulator` section contains the configuration of the
[OPC UA Simulator](/docs/architecture/microservices/community/opcua-simulator) microservice.

{{< table caption="opcuasimulator section parameters" >}}
| Parameter                   | Description                                                                 | Type   | Allowed values | Default                                                  |
| --------------------------- | --------------------------------------------------------------------------- | ------ | -------------- | -------------------------------------------------------- |
| `certadds.hosts`            | Hosts to add to the certificate                                             | string | Any            | {{< resource type="service" name="opcuasimulator" >}}    |
| `certadds.ips`              | IPs to add to the certificate                                               | string | Any            | ""                                                       |
| `image`                     | The image of the OPC UA Simulator microservice                              | string | Any            | {{< resource type="docker" name="org" >}}/opcuasimulator |
| `resources.limits.cpu`      | The CPU limit                                                               | string | Any            | 100m                                                     |
| `resources.limits.memory`   | The memory limit                                                            | string | Any            | 100Mi                                                    |
| `resources.requests.cpu`    | The CPU request                                                             | string | Any            | 10m                                                      |
| `resources.requests.memory` | The memory request                                                          | string | Any            | 20Mi                                                     |
| `service.annotations`       | The annotations of the service                                              | object | Any            | {}                                                       |
| `tag`                       | The tag of the OPC UA Simulator microservice. Defaults to latest if not set | string | Any            | 0.1.0                                                    |
{{< /table >}}

#### packmlmqttsimulator {#dz-packml-mqtt-simulator}

The `packmlmqttsimulator` section contains the configuration of the
[PackML MQTT Simulator](/docs/architecture/microservices/community/packml-simulator)
microservice.

{{< table caption="packmlmqttsimulator section parameters" >}}
| Parameter                   | Description                                                     | Type   | Allowed values              | Default                                                          |
| --------------------------- | --------------------------------------------------------------- | ------ | --------------------------- | ---------------------------------------------------------------- |
| `image.repository`          | The image of the PackML MQTT Simulator microservice             | string | Any                         | spruiktec/packml-simulator                                       |
| `image.hash`                | The hash of the image of the PackML MQTT Simulator microservice | string | Any                         | 01e2f0da3542f1b4e0de830a8d24135de03fd9174dce184ed329bed3ee688e19 |
| `image.pullPolicy`          | The image pull policy                                           | string | Always, IfNotPresent, Never | IfNotPresent                                                     |
| `replicas`                  | The number of replicas                                          | int    | Any                         | 1                                                                |
| `resources.limits.cpu`      | The CPU limit                                                   | string | Any                         | 100m                                                             |
| `resources.limits.memory`   | The memory limit                                                | string | Any                         | 100Mi                                                            |
| `resources.requests.cpu`    | The CPU request                                                 | string | Any                         | 10m                                                              |
| `resources.requests.memory` | The memory request                                              | string | Any                         | 20Mi                                                             |
| `env`                       | Environment variables to add to the Pod                         | object | Any                         | See [env](#dz-packml-mqtt-simulator-env) section                 |
{{< /table >}}

##### env {#dz-packml-mqtt-simulator-env}

The `env` section contains the environment variables to add to the Pod.

{{< table caption="env section parameters" >}}
| Parameter                | Description                               | Type   | Allowed values | Default                      |
| ------------------------ | ----------------------------------------- | ------ | -------------- | ---------------------------- |
| `area`                   | ISA-95 area name of the line              | string | Any            | DefaultArea                  |
| `productionLine`         | ISA-95 line name of the line              | string | Any            | DefaultProductionLine        |
| `site`                   | ISA-95 site name of the line              | string | Any            | testLocation                 |
| `mqtt.password`          | The password of the MQTT broker           | string | Any            | INSECURE_INSECURE_INSECURE   |
| `mqtt.encryptedPassword` | The encrypted password of the MQTT broker | string | Any            | _Base 64 encrypted password_ |
{{< /table >}}

#### redis {#dz-redis}

The `redis` section contains the configuration of the
[Redis](/docs/architecture/microservices/core/cache) microservice. This is
based on the [official Redis Helm chart](https://github.com/bitnami/charts/blob/main/bitnami/redis/README.md).
For more information about the parameters, see the
[official documentation](https://github.com/bitnami/charts/blob/main/bitnami/redis/README.md#parameters).

Here are only the values different from the default ones.

{{< table caption="redis section parameters" >}}
| Parameter                                     | Description                                         | Type         | Allowed values  | Default                                                           |
| --------------------------------------------- | --------------------------------------------------- | ------------ | --------------- | ----------------------------------------------------------------- |
| `auth.existingSecretPasswordKey`              | The key of the password in the secret               | string       | Any             | redispassword                                                     |
| `auth.existingSecret`                         | The name of the existing secret                     | string       | Any             | {{< resource type="secret" name="cache" >}}                       |
| `commonConfiguration`                         | The common configuration of the Redis microservice  | string       | Any             | See [commonConfiguration](#dz-redis-common-configuration) section |
| `master.command`                              | The command to run when the container starts        | string       | Any             | /run.sh                                                           |
| `master.extraFlags`                           | The extra flags to pass to Redis server             | string array | Any             | --maxmemory 200mb                                                 |
| `master.livenessProbe.initialDelaySeconds`    | The initial delay before the liveness probe starts  | int          | Any             | 5                                                                 |
| `master.readinessProbe.initialDelaySeconds`   | The initial delay before the readiness probe starts | int          | Any             | 120                                                               |
| `master.resources.limits.cpu`                 | The CPU limit                                       | string       | Any             | 200m                                                              |
| `master.resources.limits.memory`              | The memory limit                                    | string       | Any             | 200Mi                                                             |
| `master.resources.requests.cpu`               | The CPU request                                     | string       | Any             | 100m                                                              |
| `master.resources.requests.memory`            | The memory request                                  | string       | Any             | 100Mi                                                             |
| `metrics.enabled`                             | Whether to enable the metrics exporter              | bool         | `true`, `false` | `true`                                                            |
| `pdb.create`                                  | Whether to create a Pod Disruption Budget           | bool         | `true`, `false` | `true`                                                            |
| `pdb.minAvailable`                            | The minimum number of pods that must be available   | int          | Any             | 2                                                                 |
| `replica.livenessProbe.initialDelaySeconds`   | The initial delay before the liveness probe starts  | int          | Any             | 30                                                                |
| `replica.livenessProbe.periodSeconds`         | The period of the liveness probe                    | int          | Any             | 10                                                                |
| `replica.readinessProbe.initialDelaySeconds`  | The initial delay before the readiness probe starts | int          | Any             | 120                                                               |
| `replica.readinessProbe.periodSeconds`        | The period of the readiness probe                   | int          | Any             | 10                                                                |
| `replica.readinessProbe.timeoutSeconds`       | The timeout of the readiness probe                  | int          | Any             | 10                                                                |
| `replica.replicaCount`                        | The number of replicas                              | int          | Any             | 1                                                                 |
| `replica.resources.limits.cpu`                | The CPU limit                                       | string       | Any             | 200m                                                              |
| `replica.resources.limits.memory`             | The memory limit                                    | string       | Any             | 200Mi                                                             |
| `replica.resources.requests.cpu`              | The CPU request                                     | string       | Any             | 100m                                                              |
| `replica.resources.requests.memory`           | The memory request                                  | string       | Any             | 100Mi                                                             |
| `sentinel.downAfterMilliseconds`              | The time after which a sentinel is considered down  | int          | Any             | 1000                                                              |
| `sentinel.enabled`                            | Whether to enable the sentinel                      | bool         | `true`, `false` | `true`                                                            |
| `sentinel.failoverTimeout`                    | The sentinel failover timeout                       | int          | Any             | 18000                                                             |
| `sentinel.livenessProbe.initialDelaySeconds`  | The initial delay before the liveness probe starts  | int          | Any             | 5                                                                 |
| `sentinel.quorum`                             | The number of sentinels that must agree             | int          | Any             | 1                                                                 |
| `sentinel.readinessProbe.initialDelaySeconds` | The initial delay before the readiness probe starts | int          | Any             | 120                                                               |
| `sentinel.resources.requests.cpu`             | The CPU request                                     | string       | Any             | 100m                                                              |
| `sentinel.resources.requests.memory`          | The memory request                                  | string       | Any             | 256Mi                                                             |
| `sentinel.startupProbe.enabled`               | Whether to enable the startup probe                 | bool         | `true`, `false` | `false`                                                           |
| `serviceAccount.create`                       | Whether to create a service account                 | bool         | `true`, `false` | `false`                                                           |
{{< /table >}}

##### commonConfiguration {#dz-redis-common-configuration}

The `commonConfiguration` section contains the common configuration to be
added into the ConfigMap. For more information, see the
[documentation](https://redis.io/docs/management/config/).

```none
# Enable AOF https://redis.io/topics/persistence#append-only-file
appendonly yes
# Disable RDB persistence, AOF persistence already enabled.
save ""
# Backwards compatability with Redis version 6.*
replica-ignore-disk-write-errors yes
```

#### sensorconnect {#dz-sensorconnect}

The `sensorconnect` section contains the configuration of the
[Sensorconnect](/docs/architecture/microservices/core/sensorconnect) microservice.

{{< table caption="sensorconnect section parameters" >}}
| Parameter                            | Description                                                                               | Type   | Allowed values | Default                                                 |
| ------------------------------------ | ----------------------------------------------------------------------------------------- | ------ | -------------- | ------------------------------------------------------- |
| `additionalSleepTimePerActivePortMs` | Additional sleep time between pollings for each active port in milliseconds               | float  | Any            | 0.0                                                     |
| `additionalSlowDownMap`              | JSON map of values, allows to slow down and speed up the polling time of specific sensors | JSON   | Any            | {}                                                      |
| `allowSubTwentyMs`                   | Whether to allow sub 20ms polling time. Set to 1 to enable. Not recommended               | int    | 0, 1           | 0                                                       |
| `deviceFinderTimeSec`                | Time interval in second between new device discovery                                      | int    | Any            | 20                                                      |
| `deviceFinderTimeoutSec`             | Timeout in second for device discovery. Never set lower than `deviceFinderTimeSec`        | int    | Any            | 1                                                       |
| `image`                              | The image of the sensorconnect microservice                                               | string | Any            | {{< resource type="docker" name="org" >}}/sensorconnect |
| `ioddfilepath`                       | The path to the IODD files                                                                | string | Any            | /ioddfiles                                              |
| `lowerPollingTime`                   | The lower polling time in milliseconds                                                    | int    | Any            | 20                                                      |
| `maxSensorErrorCount`                | The maximum number of sensor errors before the sensor is marked as not responding         | int    | Any            | 50                                                      |
| `mqtt.encryptedPassword`             | The encrypted password of the MQTT broker                                                 | string | Any            | _Base 64 encrypted password_                            |
| `mqtt.password`                      | The password of the MQTT broker                                                           | string | Any            | INSECURE_INSECURE_INSECURE                              |
| `pollingSpeedStepDownMs`             | The time to subtract from the polling time in milliseconds when a sensor is responding    | int    | Any            | 1                                                       |
| `pollingSpeedStepUpMs`               | The time to add to the polling time in milliseconds when a sensor is not responding       | int    | Any            | 20                                                      |
| `resources.limits.cpu`               | The CPU limit                                                                             | string | Any            | 100m                                                    |
| `resources.limits.memory`            | The memory limit                                                                          | string | Any            | 200Mi                                                   |
| `resources.requests.cpu`             | The CPU request                                                                           | string | Any            | 10m                                                     |
| `resources.requests.memory`          | The memory request                                                                        | string | Any            | 75Mi                                                    |
| `storageRequest`                     | The amount of storage for the PersistentVolumeClaim                                       | string | Any            | 1Gi                                                     |
| `tag`                                | The tag of the sensorconnect microservice. Defaults to Chart version if not set           | string | Any            | {{< latest-semver >}}                                   |
| `upperPollingTime`                   | The upper polling time in milliseconds                                                    | int    | Any            | 1000                                                    |
{{< /table >}}

#### serviceAccount {#service-account}

The `serviceAccount` section contains the configuration of the service account.
See the [Kubernetes documentation](https://kubernetes.io/docs/concepts/security/service-accounts/)
for more information.

{{< table caption="serviceAccount section parameters" >}}
| Parameter | Description                         | Type | Allowed values  | Default |
| --------- | ----------------------------------- | ---- | --------------- | ------- |
| `create`  | Whether to create a service account | bool | `true`, `false` | `true`  |
{{< /table >}}

#### timescaledb-single {#dz-timescaledb-single}

The `timescaledb-single` section contains the configuration of the
[TimescaleDB](/docs/architecture/microservices/core/database) microservice. This
is based on the [official TimescaleDB Helm chart](https://github.com/timescale/helm-charts/tree/main/charts/timescaledb-single).
For more information about the parameters, see the
[official documentation](https://github.com/timescale/helm-charts/blob/main/charts/timescaledb-single/values.yaml).

Here are only the values different from the default ones.

{{< table caption="timescaledb-single section parameters" >}}
| Parameter                                   | Description                                      | Type         | Allowed values              | Default                                               |
| ------------------------------------------- | ------------------------------------------------ | ------------ | --------------------------- | ----------------------------------------------------- |
| `replicaCount`                              | The number of replicas                           | int          | Any                         | 1                                                     |
| `image.repository`                          | The image of the TimescaleDB microservice        | string       | Any                         | {{< resource type="docker" name="org" >}}/timescaledb |
| `image.tag`                                 | The Timescaledb-ha version                       | string       | Any                         | pg13.8-ts2.8.0-p1                                     |
| `image.pullPolicy`                          | The image pull policy                            | string       | Always, IfNotPresent, Never | IfNotPresent                                          |
| `patroni.postgresql.create_replica_methods` | The replica creation method                      | string array | Any                         | basebackup                                            |
| `postInit`                                  | A list of sources that contain post init scripts | object array | Any                         | See [postInit](#dz-timescaledb-single-postinit)       |
| `serviceAccount.create`                     | Whether to create a service account              | bool         | `true`, `false`             | `false`                                               |
{{< /table >}}

##### postInit {#dz-timescaledb-single-postinit}

The `postInit` parameter is a list of references to sources that contain
post init scripts. The scripts are executed after the database is initialized.

```yaml
postInit:
  - configMap:
      name: {{ resource type="configmap" name="database" }}
      optional: false
  - secret:
      name: {{ resource type="secret" name="database" }}
      optional: false
```

#### tulipconnector {#dz-tulip-connector}

The `tulipconnector` section contains the configuration of the
[Tulip Connector](/docs/architecture/microservices/community/tulip-connector)
microservice.

{{< table caption="tulipconnector section parameters" >}}
| Parameter                   | Description                                                                | Type   | Allowed values              | Default                                                   |
| --------------------------- | -------------------------------------------------------------------------- | ------ | --------------------------- | --------------------------------------------------------- |
| `image.repository`          | The image of the Tulip Connector microservice                              | string | Any                         | {{< resource type="docker" name="org" >}}/tulip-connector |
| `image.tag`                 | The tag of the Tulip Connector microservice. Defaults to latest if not set | string | Any                         | 0.1.0                                                     |
| `image.pullPolicy`          | The image pull policy                                                      | string | Always, IfNotPresent, Never | IfNotPresent                                              |
| `replicas`                  | The number of Pod replicas                                                 | int    | Any                         | 1                                                         |
| `env`                       | The environment variables                                                  | object | Any                         | See [env](#dz-tulip-connector-env)                        |
| `resources.limits.cpu`      | The CPU limit                                                              | string | Any                         | 200m                                                      |
| `resources.limits.memory`   | The memory limit                                                           | string | Any                         | 100Mi                                                     |
| `resources.requests.cpu`    | The CPU request                                                            | string | Any                         | 100m                                                      |
| `resources.requests.memory` | The memory request                                                         | string | Any                         | 20Mi                                                      |
{{< /table >}}

##### env {#dz-tulip-connector-env}

The `env` section contains the configuration of the environment variables to add
to the Pod.

{{< table caption="env section parameters" >}}
| Parameter | Description                              | Type   | Allowed values | Default |
| --------- | ---------------------------------------- | ------ | -------------- | ------- |
| `mode`    | In which mode to run the Tulip Connector | string | dev, prod      | prod    |
{{< /table >}}

<!-- Optional section; add links to information related to this topic. -->

## {{% heading "whatsnext" %}}

- Take a look at the [overview of the architecture](/docs/architecture)
- Deep dive into the [microservices](/docs/architecture/microservices)
