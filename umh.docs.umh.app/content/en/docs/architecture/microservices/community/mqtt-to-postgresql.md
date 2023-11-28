---
title: "MQTT to Postgresql"
content_type: concept
# description: |
#     Add a description of the concept here.
weight: 10
---

<!-- overview -->

{{% notice tip %}}
If you landed here from Google, you probably might want to check out either the
[architecture of the United Manufacturing Hub](/docs/architecture/)
or our [knowledge website](https://learn.umh.app) for more information on the
general topics of IT, OT and IIoT.
{{% /notice %}}

{{% notice warning %}}
This microservice is deprecated and should not be used anymore in production.
Please use [kafka-to-postgresql](/docs/architecture/microservices/core/kafka-to-postgresql) instead.
{{% /notice %}}

<!-- body -->

## {{% heading "howitworks" %}}

The mqtt-to-postgresql microservice subscribes to the MQTT broker and saves
the values of the messages on the topic `ia/#` in the database.

<!-- Optional section; add links to information related to this topic. -->

## {{% heading "whatsnext" %}}

- Read the [MQTT to Postgresql](/docs/reference/microservices/mqtt-to-postgresql/) reference
  documentation to learn more about the technical details of the MQTT to Postgresql
  microservice.
