---
title: "MQTT Kafka Bridge"
content_type: concept
# description: |
#     Add a description of the concept here.
weight: 10
---

<!-- overview -->

Mqtt-kafka-bridge is a microservice that acts as a bridge between MQTT brokers
and Kafka brokers, transfering messages from one to the other and vice versa.

{{% notice note %}}
This microservice requires that the Kafka Topic `umh.v1.kafka.newTopic` exits.
This will happen automatically from version 0.9.12.
{{% /notice %}}

{{% notice tip %}}
Since version 0.9.10, it allows all raw messages, even if their content is not
in a valid JSON format.
{{% /notice %}}

<!-- body -->

## {{% heading "howitworks" %}}

Mqtt-kafka-bridge consumes topics from a message broker, translates them to
the proper format and publishes them to the other message broker.

<!-- Optional section; add links to information related to this topic. -->

## {{% heading "whatsnext" %}}

- Read the [MQTT Kafka Bridge](/docs/reference/microservices/mqtt-kafka-bridge/)
  reference documentation to learn more about the technical details of the
  MQTT Kafka Bridge microservice.
