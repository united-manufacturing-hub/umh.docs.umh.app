---
title: "Kafka Console"
content_type: microservices
description: |
    The technical documentation of the kafka-console microservice,
    which provides a GUI to interact with the Kafka broker.
weight: 0
---

<!-- overview -->

Kafka-console uses [Redpanda Console](https://github.com/redpanda-data/console)
to help you manage and debug your Kafka workloads effortlessy.

With it, you can explore your Kafka topics, view messages, list the active
consumers, and more.

## {{% heading "howitworks" %}}

You can access the Kafka console via its Service.

It's automatically connected to the Kafka broker, so you can start using it
right away.
You can view the Kafka broker configuration in the Broker tab, and explore the
topics in the Topics tab.

<!-- body -->

## {{% heading "kuberesources" %}}

- Deployment: `{{< resource type="deployment" name="kafkaconsole" >}}`
- Service:
  - External LoadBalancer: `{{< resource type="service" name="kafkaconsole" >}}` at
    port 8090
- ConfigMap: `{{< resource type="configmap" name="kafkaconsole" >}}`
- Secret: `{{< resource type="secret" name="kafkaconsole" >}}`

## {{% heading "configuration" %}}

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name     | Description                                                       | Type   | Allowed values | Default         |
| ----------------- | ----------------------------------------------------------------- | ------ | -------------- | --------------- |
| `LOGIN_JWTSECRET` | The secret used to authenticate the communication to the backend. | string | Any            | _Random string_ |
{{< /table >}}
