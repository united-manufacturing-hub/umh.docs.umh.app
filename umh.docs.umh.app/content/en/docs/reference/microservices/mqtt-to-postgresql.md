---
title: "MQTT to Postgresql"
content_type: microservices
description: |
    The technical documentation of the mqtt-to-postgresql microservice,
    which consumes messages from an MQTT broker and writes them in a PostgreSQL
    database.
weight: 0
aliases:
  - /docs/architecture/microservices/community/mqtt-to-postgresql/
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

## {{% heading "howitworks" %}}

The mqtt-to-postgresql microservice subscribes to the MQTT broker and saves
the values of the messages on the topic `ia/#` in the database.

<!-- body -->
