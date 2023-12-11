---
title: Unified Namespace
menuTitle: Unified Namespace
description: Exchange events and messages across all your shopfloor equipment, IT / OT systems such as ERP or MES and microservices.
weight: 1000
edition: community
aliases:
  - /docs/features/unified-namespace
---

The Unified Namespace is an event-driven architecture that allows for seamless communication between nodes in a network. It operates on the principle that all data, regardless of whether there is an immediate consumer, should be published and made available for consumption. This means that any node in the network can work as either a producer or a consumer, depending on the needs of the system at any given time.

To use any functionalities of the United Manufacturing Hub, you need to use the Unified Namespace as well. More information can be found in our [Learning Hub on the topic of Unified Namespace](https://learn.umh.app/lesson/introduction-into-it-ot-unified-namespace/).

## When should I use it?


An application always consists out of multiple building blocks. To connect those building blocks, one can either exchange data between them through databases, through service calls (such as [REST](https://learn.umh.app/lesson/introduction-into-it-ot-https-rest/)), or through a message broker.


{{% notice tip %}}
**Opinion:** We think for most applications in manufacturing, communication via a message broker is the best choice as it prevents spaghetti diagrams and allows for real-time data processing. For more information about this, you can [check out this blog article](https://learn.umh.app/blog/comparing-mqtt-brokers-for-the-industrial-iot/#message-brokers-and-mqtt).
{{% /notice %}}

In the United Manufacturing Hub, each single piece of information / "message" / "event" is sent through a message broker, which is also called the Unified Namespace.

## What can I do with it?

The Unified Namespace / Message Broker in the United Manufacturing Hub provides several notable functionalities in addition to the features already mentioned:

- Easy integration using MQTT: Many modern shopfloor equipment can send and receive data using the MQTT protocol.
- Easy integration with legacy equipment: Using tools like [Node-RED](/docs/reference/microservices/node-red/), data can be easily extracted from various protocols such as Siemens S7, OPC-UA, or Modbus
- Get notified in real-time via MQTT: The Unified Namespace allows you to receive real-time notifications via MQTT when new messages are published. This can be useful for applications that require near real-time processing of data, such as an AGV waiting for new commands.
- Retrieve past messages from Kafka logs: By looking into the Kafka logs, you can always be aware of the last messages that have been sent to a topic. This allows you to replay certain scenarios for troubleshooting or testing purposes.
- Efficiently process messages from millions of devices: The Unified Namespace is designed to handle messages from millions of devices in your factory, even over unreliable connections. By using Kafka, you can efficiently at-least-once process each message, ensuring that each message arrives at-least-once (1 or more times).
- Trace messages through the system: The Unified Namespace provides tracing capabilities, allowing you to understand where messages are coming from and where they go. This can be useful for debugging and troubleshooting purposes. You can use the Management Console to visualize the flow of messages through the system to visualize the flow of messages through the system like in the picture below.

  ![Untitled](/images/features/unified-namespace/dataDashboardMC.png?width=75%)

## How can I use it?

Using the Unified Namespace is quite simple:

Configure your IoT devices and devices on the shopfloor to use the in-built MQTT broker of the United Manufacturing Hub by specifying the MQTT protocol, selecting unencrypted (1883) / encrypted (8883) ports depending on your configuration, and send the messages into a topic. From there on, you can start processing the messages in Node-RED by reading in the messages again via MQTT or Kafka, adjusting the payload or the topic and sending it back again to MQTT or Kafka. In the United Manufacturing Hub (UMH), we organize data using a specific topic structure. The structure looks like this:

```
umh/v1/enterprise/site/area/productionLine/workCell/originID/_schema
```

- **Topic Names and Rules**: All parts of this structure, such as `enterprise`, `site`, `area`, etc., are flexible in terms of their naming. Here, you find valid and invalid characters:
  - Valid characters:
      - Letters: `a-z`, `A-Z`
      - Numbers: `0-9`
      - Symbols: `-`, `_`
  - Invalid characters: 
      - `.`, `+`, `#`, `/`


- **Versioning Prefix**: The `umh/v1` at the beginning is obligatory. It ensures that the structure can evolve over time without causing confusion or compatibility issues.
- **ISA95 Compliance**: The terms like `enterprise`, `site`, `area`, etc., are aligned with the ISA95 model, which is a standard for industrial systems. `enterprise` is the only mandatory term; others can be skipped if they don't apply, e.g., a room temperature sensor for a specific area.
- **Origin ID**: This part identifies where the data is coming from. It could be a serial number, a MAC address, or even a software component like a Docker container. If multiple sources are involved, they're separated by underscores. Examples of originIDs: `E588974`, `00-80-41-ae-fd-7e`, `VM241_nodered_mes`.

- **The _schema Field**: This is where IT and OT professionals need to pay close attention. The `_schema` field, identified by its leading underscore, is crucial for defining the type of data or the format being sent. In the UMH, we have default schemas like `_historian`, `_analytics`, and `_local`, but users can add more as needed. The underscore is important for clarity in parsing the structure, especially when some elements like `workCell` might be omitted. This feature does not block a message from entering Kafka or MQTT, but it will prevents forwarding or processing the message, and will throw warnings.

  1. **Schemas _historian and _analytics**:
      - Validation of Messages: The United Manufacturing Hub (UMH) is programmed to process messages under the `_historian` and `_analytics` schemas only if they adhere to a valid schema format (see further below).
      - Handling Invalid Messages: Any message that is not in JSON format or does otherwise not meet the schema, even if sent to these schemas, will not be saved in the database nor forwarded to another broker. This ensures data integrity and consistency in processing.
  2. **Schema _local**:
      - Non-Processing Policy: Messages sent under the `_local` schema will not be processed by UMH. This schema is reserved for data that is intended to remain local and is not meant for forwarding or storing in the database.
  3. **Other Schemas**:
      - Forwarding without Storage: Messages falling under schemas other than `_historian`, `_analytics`, and `_local` will be forwarded to other brokers via bridges.
      - Independence from Structure and Payload: This forwarding occurs regardless of the specific topic structure following the `_schema` marker and irrespective of the payload format. However, UMH will not store these messages in its database.

The [Data Bridge](/docs/reference/microservices/data-bridge/)  microservice assists you in transmitting data between two Kafka or MQTT brokers and transforming the data according to the UNS data model. It also offers a merge point feature that consolidates messages from various detailed topics into a general topic, minimizing overhead in managing a large number of topics. You can find more information in [this article](https://learn.umh.app/lesson/data-modeling-in-the-unified-namespace-mqtt-kafka/).

If you send the messages into other topics, some features might not work correctly (see also [limitations](#what-are-the-limitations)).

{{% notice tip %}}
**Recommendation:** Send messages from IoT devices via MQTT and then work in Kafka only.
{{% /notice %}}

## What are the limitations?
- Increased complexity in integrating MQTT with Kafka.
- The specific topic structure should be used.
- We recommend using JSON payloads that require more resource than Protobuf or Avro. However, JSON enhances the capability of OT professionals to work with and understand messages.



## Where to get more information?

- For more information about the involved microservices, please take a look at our [architecture page](/docs/architecture/).
- For more information about [MQTT](https://learn.umh.app/lesson/introduction-into-it-ot-mqtt/), [Kafka](https://learn.umh.app/lesson/introduction-into-it-ot-kafka/), or the [Unified Namespace](https://learn.umh.app/lesson/introduction-into-it-ot-unified-namespace/), visit the Learning Hub.
- For more information about the reasons to use MQTT and Kafka, please take a look at our blog article [Tools & Techniques for scalable data processing in Industrial IoT](https://learn.umh.app/blog/tools-techniques-for-scalable-data-processing-in-industrial-iot/).
<!-- add data model page!! -->
