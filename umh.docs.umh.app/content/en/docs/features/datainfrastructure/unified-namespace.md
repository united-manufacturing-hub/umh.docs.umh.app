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

In our opinion, the Unified Namespace provides the best tradeoff for connecting
systems in manufacturing / shopfloor scenarios. It effectively eliminates the
complexity of spaghetti diagrams and enables real-time data processing.

While data can be shared through databases,
[REST APIs](https://learn.umh.app/lesson/introduction-into-it-ot-https-rest/),
or message brokers, we believe that a message broker approach is most suitable
for most manufacturing applications. Consequently, every piece of information
within the United Manufacturing Hub is transmitted via a message broker.

Both MQTT and Kafka are used in the United Manufacturing Hub. MQTT is designed
for the safe message delivery between devices and simplifies gathering data on
the shopfloor. However, it is not designed for reliable stream processing.
Although Kafka does not provide a simple way to collect data, it is suitable
for contextualizing and processing data. Therefore, we are combining both the
strengths of MQTT and Kafka. You can get more information from [this article](https://learn.umh.app/blog/tools-techniques-for-scalable-data-processing-in-industrial-iot/).

## What can I do with it?

The Unified Namespace in the United Manufacturing Hub provides you the following
functionalities and applications:

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
- **Scalable Message Processing**: Designed to handle a large amount of data
  from a lot of devices efficiently, ensuring reliable message delivery even
  over unstable network connections. By using IT standard tools, we can
  theoretically process data in the measure of `GB/second` instead of
  `messages/second`.
- **Data Transformation and Transfer**: Utilizes the
  [Data Bridge](/docs/architecture/data-infrastructure/unified-namespace/data-bridge/)
  to adapt and transmit data between different formats and systems, maintaining
  data consistency and reliability.

Each feature opens up possibilities for enhanced data management, real-time
monitoring, and system optimization in industrial settings.

You can view the Unified Namespace by using the Management Console like in the picture
below. The picture shows data under the topic
`umh/v1/demo-pharma-enterprise/Cologne/_historian/rainfall/isRaining`, where

- `umh/v1` is a versioning prefix.
- `demo-pharma-enterprise` is a sample `enterprise` tag.
- `Cologne` is a sample `site` tag.
- `_historian` is a schema tag. Data with this tag will be stored in the UMH's database.
- `rainfall/isRaining` is a sample schema dependent context, where `rainfall` is a tag group and
  `isRaining` is a tag belonging to it.

{{% notice info %}}
The full tag name uniquely identifies a single tag, it can be found in the **Publisher & Subscriber Info** table.
{{% /notice %}}

![Tag Browser](/images/features/unified-namespace/tagBrowser.png?width=80%)

The above image showcases the `Tag Browser`, our main tool for navigating the Unified Namespace. It includes the
following features:

- **Data Aggregation**: Automatically consolidates data from all connected instances / brokers.
- **Topic Structure**: Displays the hierarchical structure of topics and which data belongs to which namespace.
- **Tag Folder Structure**: Facilitates browsing through tag folders or groups within a single asset.
- **Schema validation**: Introduces validation for known schemas such as `_historian`. In case of validation
  failure, the corresponding errors are displayed.
- **Publisher & Subscriber Info**: Provides various details, such as the origins and destinations of the data,
  the instance it was published from, the messages per minute to get an overview on how much data is flowing,
  and the full tag name to uniquely identify the selected tag.
- **Payload Visualization**: Displays payloads under validated schemas in a formatted/structured manner, enhancing
  readability. For unknown schemas without strict validation, the raw payload is displayed instead.
- **Tag Value History**: Shows the last 100 received values for the selected tag, allowing you to track the
  changes in the data over time. Keep in mind that this feature is only available for tags that are part of the
  `_historian` schema.
- **Kafka Origin**: Provides information about the Kafka key, topic and the actual payload that was sent via Kafka.

{{% notice note %}}
It's important to note that data displayed in the `Tag Browser` represent snapshots; hence, data sent at
intervals shorter than 10 seconds may not be accurately reflected.
{{% /notice %}}

You can find more detailed information about the topic structure [here](/docs/datamodel/messages).

You can also use tools like [MQTT Explorer](https://mqtt-explorer.com/)
(not included in the UMH) or Redpanda Console (enabled by defualt, accessible
via port `8090`) to view data from a single instance (but single instance only).

## How can I use it?

To effectively use the Unified Namespace in the United Manufacturing Hub, start
by configuring your IoT devices to communicate with the UMH's MQTT broker,
considering the necessary security protocols. While MQTT is recommended for
gathering data on the shopfloor, you can send messages to Kafka as well.

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

While JSON is the only supported payload format due to its accessibility, it's
important to note that it can be more resource-intensive compared to formats
like Protobuf or Avro.

## Where to get more information?

- Explore the UMH [architecture](/docs/architecture/) and
  [data model](/docs/datamodel/).
- Read articles about [MQTT](https://learn.umh.app/lesson/introduction-into-it-ot-mqtt/),
  [Kafka](https://learn.umh.app/lesson/introduction-into-it-ot-kafka/),
  and the [Unified Namespace](https://learn.umh.app/lesson/introduction-into-it-ot-unified-namespace/)
  on the Learning Hub.
- Read the blog article about
  [Tools & Techniques for scalable data processing in Industrial IoT](https://learn.umh.app/blog/tools-techniques-for-scalable-data-processing-in-industrial-iot/).
