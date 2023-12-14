---
title: "MQTT Bridge"
content_type: concept
# description: |
#     Add a description of the concept here.
weight: 10
aliases:
  - /docs/architecture/microservices/core/mqtt-bridge/
---

<!-- overview -->

MQTT-bridge is a microservice that connects two MQTT brokers and forwards
messages between them. It is used to connect the local broker of the edge computer
with the remote broker on the server.

<!-- body -->

## {{% heading "howitworks" %}}

This microservice subscribes to topics on the local broker and publishes the
messages to the remote broker, while also subscribing to topics on the remote
broker and publishing the messages to the local broker.

<!-- Optional section; add links to information related to this topic. -->

## {{% heading "whatsnext" %}}

- Read the [MQTT Bridge](/docs/reference/microservices/mqtt-bridge/) reference documentation
  to learn more about the technical details of the MQTT Bridge microservice.
