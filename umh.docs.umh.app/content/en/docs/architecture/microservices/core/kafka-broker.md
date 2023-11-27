---
title: "Kafka Broker"
content_type: concept
# description: |
#     Add a description of the concept here.
weight: 10
---

<!-- overview -->

The Kafka broker in the United Manufacturing Hub is [RedPanda](https://redpanda.com/),
a Kafka-compatible event streaming platform. It's used to store and process
messages, in order to stream real-time data between the microservices.

<!-- body -->

## {{% heading "howitworks" %}}

RedPanda is a distributed system that is made up of a cluster of brokers,
designed for maximum performance and reliability. It does not depend on external
systems like ZooKeeper, as it's shipped as a single binary.

Read more about RedPanda in the [official documentation](https://docs.redpanda.com/docs/get-started/).

<!-- Optional section; add links to information related to this topic. -->

## {{% heading "whatsnext" %}}

- Read the [Kafka Broker](/docs/reference/microservices/kafka-broker/) reference documentation
  to learn more about the technical details of the Kafka broker microservice
