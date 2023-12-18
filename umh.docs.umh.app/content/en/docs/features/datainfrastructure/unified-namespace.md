---
title: Unified Namespace
menuTitle: Unified Namespace
description: |
  Seamlessly connect and communicate across shopfloor equipment, IT/OT systems,
  and microservices.
weight: 1000
edition: community
aliases:
  - /docs/features/unified-namespace
---

The Unified Namespace is a centralized, standardized, event-driven data
architecture that enables for seamless integration and communication across
various devices and systems in an industrial environment. It operates on the
principle that all data, regardless of whether there is an immediate consumer,
should be published and made available for consumption. This means that any
node in the network can work as either a producer or a consumer, depending on
the needs of the system at any given time.

This architecture is the foundation of the United Manufacturing Hub, and you
can read more about it in the [Learning Hub article](https://learn.umh.app/lesson/introduction-into-it-ot-unified-namespace/).

## When should I use it?

The Unified Namespace is the ideal solution for exchanging data between
applications and devices. It effectively eliminates the complexity of spaghetti
diagrams and enables real-time data processing.

While data can be shared through databases,
[REST APIs](https://learn.umh.app/lesson/introduction-into-it-ot-https-rest/),
or message brokers, we believe that a message broker approach is most suitable
for most manufacturing applications. Consequently, every piece of information
within the United Manufacturing Hub is transmitted via a message broker.

## What can I do with it?

The Unified Namespace in the United Manufacturing Hub allows for diverse functionalities and applications:

- **Seamless Integration with MQTT**: Facilitates straightforward connection
  with modern industrial equipment using the MQTT protocol.
- **Legacy Equipment Compatibility**: Provides easy integration with older
  systems using tools like [Node-RED](/docs/architecture/data-infrastructure/unified-namespace/node-red/),
  supporting various protocols like Siemens S7, OPC-UA, and Modbus.
- **Real-time Notifications**: Enables instant alerting and data transmission
  through MQTT, crucial for time-sensitive operations.
- **Historical Data Access**: Offers the ability to view and analyze past
  messages stored in Kafka logs, which is essential for troubleshooting and
  understanding historical trends.
- **Scalable Message Processing**: Designed to handle vast quantities of data
  from numerous devices efficiently, ensuring reliable message delivery even
  over unstable network connections.
- **Advanced Message Tracing**: Equips you with the capability to trace the
  origin and path of messages, aiding in debugging and system optimization.
- **Data Transformation and Transfer**: Utilizes the
  [Data Bridge](/docs/architecture/data-infrastructure/unified-namespace/data-bridge/)
  to adapt and transmit data between different formats and systems, maintaining
  data consistency and reliability.

Each feature opens up possibilities for enhanced data management, real-time
monitoring, and system optimization in industrial settings.

![Data Dashboard](/images/features/unified-namespace/dataDashboardMC.png?width=80%)

## How can I use it?

Using the Unified Namespace is quite simple:

Configure your IoT devices and devices on the shopfloor to use the in-built
MQTT broker of the United Manufacturing Hub by specifying the MQTT protocol,
selecting unencrypted (1883) / encrypted (8883) ports depending on your
configuration, and send the messages into a topic. From there on, you can start
processing the messages in Node-RED by reading in the messages again via MQTT
or Kafka, adjusting the payload or the topic and sending it back again to MQTT
or Kafka.

You can acquire hands-on experience with the configuration process on the
[Get Started!](/docs/getstarted/) page.

In the United Manufacturing Hub (UMH), we organize data using a specific topic
structure based on the ISA95 standard model that ensures data integrity and
ease of understanding for OT professionals. JSON has been selected as the
primary data format for payloads. You can get more detailed information in the
[Data Model](/docs/datamodel/) page.

The [Data Bridge](/docs/reference/microservices/data-bridge/) microservice
helps you transmit data between two Kafka or MQTT brokers and transform the
data according to the UNS data model. The bridge consolidates messages from
multiple MQTT topics into a single Kafka topic. The point where the topics will
be merged is referred to as a "merge point," and you can configure it. For
example, with a merge point of 4, it consolidates messages from various
detailed topics like `umh/v1/acme/anytown/foo/bar` into a general topic
`umh.v1.acme.anytown` while using the specific sub-topic paths (`foo.bar`,
`foo.baz`, etc.) as message keys in Kafka. You can find more information in
[this article](https://learn.umh.app/lesson/data-modeling-in-the-unified-namespace-mqtt-kafka/).

If you send the messages into other topics, some features might not work
correctly (see also [limitations](#what-are-the-limitations)).

{{% notice tip %}}
**Recommendation:** Send messages from IoT devices via MQTT and then work in
Kafka only.
{{% /notice %}}

## What are the limitations?

- Increased complexity in integrating MQTT with Kafka.
- The specific topic structure should be used.
- We recommend using JSON payloads that require more resource than Protobuf or
  Avro. However, JSON enhances the capability of OT professionals to work with
  and understand messages.

## Where to get more information?

- For more information about the involved microservices, please take a look at
  our [architecture page](/docs/architecture/).
- For more information about [MQTT](https://learn.umh.app/lesson/introduction-into-it-ot-mqtt/),
[Kafka](https://learn.umh.app/lesson/introduction-into-it-ot-kafka/),
  or the [Unified Namespace](https://learn.umh.app/lesson/introduction-into-it-ot-unified-namespace/),
  visit the Learning Hub.
- For more information about the reasons to use MQTT and Kafka, please take a
  look at our blog article [Tools & Techniques for scalable data processing in Industrial IoT](https://learn.umh.app/blog/tools-techniques-for-scalable-data-processing-in-industrial-iot/).
- For more information about the data model, visit [data model page](/docs/datamodel/).
