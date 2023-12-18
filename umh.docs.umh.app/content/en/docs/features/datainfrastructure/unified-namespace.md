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

The Unified Namespace / Message Broker in the United Manufacturing Hub provides
several notable functionalities in addition to the features already mentioned:

- Easy integration using MQTT: Many modern shopfloor equipment can send and
  receive data using the MQTT protocol.
- Easy integration with legacy equipment: Using tools like
[Node-RED](/docs/reference/microservices/node-red/), data can be easily
  extracted from various protocols such as Siemens S7, OPC-UA, or Modbus
- Get notified in real-time via MQTT: The Unified Namespace allows you to receive
  eal-time notifications via MQTT when new messages are published. This can be
  seful for applications that require near real-time processing of data, such as
  n AGV waiting for new commands.
- Retrieve past messages from Kafka logs: By looking into the Kafka logs, you
  an always be aware of the last messages that have been sent to a topic. This
  llows you to replay certain scenarios for troubleshooting or testing purposes.
- Efficiently process messages from millions of devices: The Unified Namespace
  is designed to handle messages from millions of devices in your factory, even
  over unreliable connections. By using Kafka, you can efficiently at-least-once
  process each message, ensuring that each message arrives at-least-once (1 or
  more times).
- Trace messages through the system: The Unified Namespace provides tracing
  capabilities, allowing you to understand where messages are coming from and
  where they go. This can be useful for debugging and troubleshooting purposes.
  You can use the Management Console to visualize the flow of messages through
  the system to visualize the flow of messages through the system like in the
  picture below.

  ![Data Dashboard](/images/features/unified-namespace/dataDashboardMC.png?width=75%)

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
