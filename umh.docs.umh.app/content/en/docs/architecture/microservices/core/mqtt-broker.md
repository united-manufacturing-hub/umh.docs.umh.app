---
title: "Mqtt Broker"
content_type: concept
# description: |
#     Add a description of the concept here.
weight: 10
---

<!-- overview -->

The MQTT broker in the United Manufacturing Hub is [HiveMQ](https://www.hivemq.com/)
and is customized to fit the needs of the stack. It's a core component of
the stack and is used to communicate between the different microservices.

<!-- body -->

## {{% heading "howitworks" %}}

The MQTT broker is responsible for receiving MQTT messages from the
different microservices and forwarding them to the
[MQTT Kafka bridge](/docs/architecture/microservices/core/mqtt-kafka-bridge/).

<!-- Optional section; add links to information related to this topic. -->

## {{% heading "whatsnext" %}}

- Read the [MQTT Broker](/docs/reference/microservices/mqtt-broker/) reference documentation
  to learn more about the technical details of the MQTT Broker microservice.
