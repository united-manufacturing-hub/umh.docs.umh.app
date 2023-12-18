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
  systems using tools like [Node-RED](/docs/architecture/data-infrastructure/unified-namespace/node-red/)
  or [Benthos UMH](/docs/features/connectivity/benthos-umh/),
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

To effectively use the Unified Namespace in the United Manufacturing Hub, start
by configuring your IoT devices to communicate with the UMH's MQTT broker,
considering the necessary security protocols.

Once the devices are set up, handle the incoming data messages using tools like
[Node-RED](/docs/architecture/data-infrastructure/unified-namespace/node-red/)
or [Benthos UMH](/docs/features/connectivity/benthos-umh/). This step involves
adjusting payloads and topics as needed. It's also important to understand and
follow the ISA95 standard model for data organization, using JSON as the
primary format.

Additionally, the [Data Bridge](/docs/architecture/data-infrastructure/unified-namespace/data-bridge/)
microservice plays a crucial role in transferring and transforming data between
MQTT and Kafka, ensuring that it adheres to the UMH data model. You can
configure a merge point to consolidate messages from multiple MQTT topics into
a single Kafka topic. For instance, if you set a merge point of 3, the Data
Bridge will consolidate messages from more detailed topics like
`umh/v1/plant1/machineA/temperature` into a broader topic like `umh/v1/plant1`.
This process helps in organizing and managing data efficiently, ensuring that
messages are grouped logically while retaining key information for each topic
in the Kafka message key.

{{% notice tip %}}
**Recommendation:** Send messages from IoT devices via MQTT and then work in
Kafka only.
{{% /notice %}}

## What are the limitations?

The limitations of the Unified Namespace primarily revolve around its technical
complexity. Integrating MQTT with Kafka can be challenging, requiring a solid
understanding of both systems. Additionally, the specific topic structure
mandated by UMH must be adhered to, which might limit flexibility in some
cases. While JSON is the only supported payload format due to its
accessibility, it's important to note that it can be more resource-intensive
compared to formats like Protobuf or Avro.

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
