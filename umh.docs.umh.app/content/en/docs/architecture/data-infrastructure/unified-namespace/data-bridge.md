---
title: "Data Bridge"
content_type: concept
# description: |
#     Add a description of the concept here.
weight: 10
aliases:
  - /docs/architecture/microservices/core/data-bridge/
---

<!-- overview -->

Data-bridge is a microservice specifically tailored to adhere to the
[UNS](https://learn.umh.app/lesson/navigating-data-flow-understanding-data-models/)
data model. It consumes topics from a message broker, translates them to
the proper format and publishes them to the other message broker.

<!-- body -->

## {{% heading "howitworks" %}}

Data-bridge connects to the source broker, that can be either Kafka or MQTT,
and subscribes to the topics specified in the configuration. It then processes
the messages, and publishes them to the destination broker, that can be either
Kafka or MQTT.

In the case where the destination broker is Kafka, messages from multiple topics
can be merged into a single topic, making use of the message key to identify
the source topic.
For example, subscribing to a topic using a wildcard, such as
`umh.v1.acme.anytown..*`, and a merge point of 4, will result in
messages from the topics `umh.v1.acme.anytown.foo.bar`,
`umh.v1.acme.anytown.foo.baz`, `umh.v1.acme.anytown` and `umh.v1.acme.anytown.frob`
being merged into a single topic, `umh.v1.acme.anytown`, with the message key
being the missing part of the topic name, in this case `foo.bar`, `foo.baz`, etc.

Here is a diagram showing the flow of messages:

{{< mermaid >}}
graph LR
source((MQTT or Kafka broker))
subgraph Messages
direction TB
msg1(topic: umh/v1/acme/anytown/foo/bar<br>value: 1)
msg2(topic: umh/v1/acme/anytown/foo/baz<br>value: 2)
msg3(topic: umh/v1/acme/anytown<br>value: 3)
msg4(topic: umh/v1/acme/anytown/frob<br>value: 4)
end
source --> msg1
source --> msg2
source --> msg3
source --> msg4

msg1 --> bridge
msg2 --> bridge
msg3 --> bridge
msg4 --> bridge
bridge{{data-bridge<br>subscribes to: umh/v1/acme/anytown/#<br>topic merge point: 4}}

subgraph Grouped messages
direction TB
gmsg1(topic: umh.v1.acme.anytown<br>key: foo.bar<br>value: 1)
gmsg2(topic: umh.v1.acme.anytown<br>key: foo.baz<br>value: 2)
gmsg3(topic: umh.v1.acme.anytown<br>value: 3)
gmsg4(topic: umh.v1.acme.anytown<br>key: frob<br>value: 4)
end

bridge --> gmsg1
bridge --> gmsg2
bridge --> gmsg3
bridge --> gmsg4

dest((Kafka broker))
gmsg1 --> dest
gmsg2 --> dest
gmsg3 --> dest
gmsg4 --> dest
{{< /mermaid >}}

{{% notice note %}}
The value of the message is not changed, only the topic and key are modified.
{{% /notice %}}

Another important feature is that it is possible to configure multiple data
bridges, each with its own source and destination brokers, and each with its
own set of topics to subscribe to and merge point.

The brokers can be local or remote, and, in case of MQTT, they can be secured
using TLS.

<!-- Optional section; add links to information related to this topic. -->

## {{% heading "whatsnext" %}}

- Read the [Data Bridge](/docs/reference/microservices/data-bridge/) reference
  documentation to learn more about the technical details of the data-bridge microservice.
