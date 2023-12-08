---
title: "Sensorconnect"
content_type: concept
# description: |
#     Add a description of the concept here.
weight: 10
aliases:
  - /docs/architecture/microservices/core/sensorconnect/
---

<!-- overview -->

Sensorconnect automatically detects [ifm gateways](https://ifm.com/us/en/category/245_010_010)
connected to the network and reads data from the connected [IO-Link](https://io-link.com)
sensors.

<!-- body -->

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

<!-- Optional section; add links to information related to this topic. -->

## {{% heading "whatsnext" %}}

- Read the [Sensorconnect](/docs/reference/microservices/sensorconnect/) reference
  documentation to learn more about the technical details of the Sensorconnect
  microservice.
