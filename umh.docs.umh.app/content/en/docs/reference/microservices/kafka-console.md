---
title: "Kafka Console"
content_type: reference
description: |
    The technical documentation of the kafka-console microservice,
    which provides a GUI to interact with the Kafka broker.
weight: 0
---

<!-- overview -->

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
