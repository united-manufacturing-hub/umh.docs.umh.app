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
- grafanaproxy: provides a
  proxy to the backend services.
- [MQTT Simulator](/docs/architecture/microservices/community/mqtt-simulator): simulates
  sensors and sends the data to the MQTT broker for further processing.
- [kafka-bridge](/docs/architecture/microservices/core/kafka-bridge/): connects Kafka brokers
  on different Kubernetes clusters.
- [kafkatoblob](/docs/architecture/microservices/community/kafka-to-blob/): stores the data
  from the Kafka broker in a blob storage.
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
- [MinIo Operator](https://operator.min.io/): a Kubernetes operator for
  deploying and managing MinIO clusters.
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

After those two sections, there are the specific sections for each microservice,
which contain their advanced configuration. This is the so called Danger Zone,
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
| `blobstorage`        | The configuration of the microservices used to store data in a blob storage.    | object | See below      | [See below](#blob-storage)         |
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
| Parameter     | Description                                              | Type   | Allowed values  | Default         |
| ------------- | -------------------------------------------------------- | ------ | --------------- | --------------- |
| `enabled`     | Whether the sensorconnect microservice is enabled.       | bool   | `true`, `false` | `false`         |
| `iprange`     | The IP range of the sensors in CIDR notation.            | string | Valid IP range  | 192.168.10.1/24 |
| `enableKafka` | Whether the sensorconnect microservice should use Kafka. | bool   | `true`, `false` | `true`          |
| `enableMQTT`  | Whether the sensorconnect microservice should use MQTT.  | bool   | `true`, `false` | `false`         |
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
of the nodered microservice.

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
[MQTT broker](/docs/architecture/microservices/core/hivemq) and the
Kafka broker.

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
of the [MQTT broker](/docs/architecture/microservices/core/hivemq).

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
of the Kafka broker
and related services, like [mqttkafkabridge](/docs/architecture/microservices/core/mqtt-kafka-bridge/),
[kafkatopostgresql](/docs/architecture/microservices/core/kafka-to-postgresql/)
and the Kafka console.

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

- timescaledb
- [factoryinsight](/docs/architecture/microservices/core/factoryinsight)
- [kafka-to-postgresql](/docs/architecture/microservices/core/kafka-to-postgresql)
- grafana
- [mqtt-broker](/docs/architecture/microservices/core/hivemq)

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

#### Blob storage

The `_000_commonConfig.blobstorage` section contains the configuration of the
microservices used to store data in blob storage. Specifically, it controls the
following microservices:

- [kafka-to-blob](/docs/architecture/microservices/community/kafka-to-blob)
- minio

If you want to specifically configure one of these microservices, you can do so
in their respective sections in the danger zone.

The following table lists the configurable parameters of the
`_000_commonConfig.blobstorage` section.

{{< table caption="blobstorage section parameters" >}}
| Parameter | Description                                      | Type | Allowed values  | Default |
| --------- | ------------------------------------------------ | ---- | --------------- | ------- |
| `enabled` | Whether to enable the blob storage microservices | bool | `true`, `false` | `false` |
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
| `statefulEnabled  | Create a PersistentVolumeClaim for the microservice and mount it in `/data` | bool   | `true`, `false`                   | `false`                                    |
{{< /table >}}

## Danger zone

The next sections contain a more advanced configuration of the microservices.
Usually, changing the values of the previous sections is enough to run the
United Manufacturing Hub. However, you may need to adjust some of the values
below if you want to change the default behavior of the microservices.

{{< notice warning >}}
Everything below this point  should not be changed, unless you know what you are doing.
{{< /notice >}}

<!-- Optional section; add links to information related to this topic. -->

## {{% heading "whatsnext" %}}

- Take a look at the [overview of the architecture](/docs/architecture)
- Deep dive into the [microservices](/docs/architecture/microservices)
