---
title: "Kafka Bridge"
content_type: concept
# description: |
#     Add a description of the concept here.
weight: 10
aliases:
  - /docs/architecture/microservices/core/kafka-bridge/
---

<!-- overview -->

Kafka-bridge is a microservice that connects two Kafka brokers and forwards
messages between them. It is used to connect the local broker of the edge computer
with the remote broker on the server.

<!-- body -->

## {{% heading "howitworks" %}}

This microservice has two ways of operation:

- **High Integrity**: This mode is used for topics that are critical for the
  user. It is garanteed that no messages are lost. This is achieved by
  committing the message only after it has been successfully inserted into the
  database. Ususally all the topics are forwarded in this mode, except for
  processValue, processValueString and raw messages.
- **High Throughput**: This mode is used for topics that are not critical for
  the user. They are forwarded as fast as possible, but it is possible that
  messages are lost, for example if the database struggles to keep up. Usually
  only the processValue, processValueString and raw messages are forwarded in
  this mode.

<!-- Optional section; add links to information related to this topic. -->

## {{% heading "whatsnext" %}}

- Read the [Kafka Bridge](/docs/reference/microservices/kafka-bridge/) reference documentation
  to learn more about the technical details of the Kafka Bridge microservice.