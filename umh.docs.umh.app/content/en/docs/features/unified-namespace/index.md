+++
title = "Unified Namespace / Message Broker"
menuTitle = "Unified Namespace / Message Broker"
description = "Exchange events and messages across all your shopfloor equipment, IT / OT systems such as ERP or MES and microservices."
weight = 1
+++

The Unified Namespace is an event-driven architecture that allows for seamless communication between nodes in a network. It operates on the principle that all data, regardless of whether there is an immediate consumer, should be published and made available for consumption. This means that any node in the network can work as either a producer or a consumer, depending on the needs of the system at any given time.

To use any functionalities of the United Manufacturing Hub, you need to use the Unified Namespace as well. More information can be found in our [Learning Hub on the topic of Unified Namespace](https://learn.umh.app/lesson/introduction-into-it-ot-unified-namespace/).

## When should I use it?

An application consists always out of multiple building blocks. To connect those building blocks, one can either exchange data between them through databases, through service calls (such as [REST](https://learn.umh.app/lesson/introduction-into-it-ot-https-rest/)), or through a message broker. 

{{% notice tip %}}
**Opinion:** We think for most applications in manufacturing, communication via a message broker is the best choice as it prevents spaghetti diagrams and allows for real-time data processing. For more information about this, you can [check out this blog article](https://learn.umh.app/blog/comparing-mqtt-brokers-for-the-industrial-iot/#message-brokers-and-mqtt).
{{% /notice %}} 

In the United Manufacturing Hub, each single piece of information / "message" / "event" is sent through a message broker, which is also called the Unified Namespace.

## What can I do with it?

The Unified Namespace / Message Broker in the United Manufacturing Hub provides several notable functionalities in addition to the features already mentioned:
- Easy integration using MQTT: Many modern shopfloor equipment can send and receive data using the MQTT protocol. 
- Easy integration with legacy equipment: Using tools like [Node-RED](/docs/architecture/microservices/core/node-red/), data can be easily extracted from various protocols such as Siemens S7, OPC-UA, or Modbus
- Get notified in real-time via MQTT: The Unified Namespace allows you to receive real-time notifications via MQTT when new messages are published. This can be useful for applications that require near real-time processing of data, such as an AGV waiting for new commands.
- Retrieve past messages from Kafka logs: By looking into the Kafka logs, you can always be aware of the last messages that have been sent to a topic. This allows you to replay certain scenarios for troubleshooting or testing purposes.
- Efficiently process messages from millions of devices: The Unified Namespace is designed to handle messages from millions of devices in your factory, even over unreliable connections. By using Kafka, you can efficiently at-least-once process each message, ensuring that no data is lost or duplicated.
- Trace messages through the system: The Unified Namespace provides tracing capabilities, allowing you to understand where messages are coming from and where they go. This can be useful for debugging and troubleshooting purposes. You can use the [Management Console](https://mgmt.docs.umh.app/docs/) to visualize the flow of messages through the system.to visualize the flow of messages through the system.

## How can I use it?

Using the Unified Namespace is quite simple: 

Configure your IoT devices and devices on the shopfloor to use the in-built MQTT broker of the United Manufacturing Hub by specifying the MQTT protocol, selecting unencrypted (1883) / encrypted (8883) ports depending on your configuration, and send the messages into a topic starting with `ia/raw`. From there on, you can start processing the messages in Node-RED by reading in the messages again via MQTT or Kafka, adjusting the payload or the topic to match the [UMH datamodel](/docs/architecture/datamodel/) and sending it back again to MQTT or Kafka.

If you send the messages into other topics, some features might not work correctly (see also [limitations](#what-are-the-limitations)).

{{% notice tip %}}
**Recommendation:** Send messages from IoT devices via MQTT and then work in Kafka only.
{{% /notice %}} 

## What are the limitations?

- Messages are only bridged between MQTT and Kafka if they fulfill the following requirements:
  - payload is a valid JSON OR message is sent to the `ia/raw` topic
  - only sent to topics matching the [allowed topics in the UMH datamodel](/docs/architecture/datamodel/messages/), independent of what is configured in the environment variables (will be changed soon)
- Messages from MQTT to Kafka will be published under a different topic:
  - Spaces will be removed
  - `/` characters will be replaced with a `.`
  - and vice versa
- By default, there will be no Authorization and Authentication on the MQTT broker. [You need to enable authentication and authorization yourself](/docs/production-guide/security/).
- The MQTT or Kafka broker is not exposed externally by default. [You need to enable external MQTT access first](/docs/production-guide/administration/access-mqtt-outside-cluster/), or alternatively [expose Kafka externally](/docs/production-guide/administration/access-kafka-outside-cluster/).

## Where to get more information?

- For more information about the involved microservices, please take a look at our [architecture page](/docs/architecture/).
- For more information about [MQTT](/lesson/introduction-into-it-ot-mqtt/), [Kafka](https://learn.umh.app/lesson/introduction-into-it-ot-kafka/), or the [Unified Namespace](https://learn.umh.app/lesson/introduction-into-it-ot-unified-namespace/), visit the Learning Hub.
- For more information about the reasons to use MQTT and Kafka, please take a look at our blog article [Tools & Techniques for scalable data processing in Industrial IoT](https://learn.umh.app/blog/tools-techniques-for-scalable-data-processing-in-industrial-iot/).
