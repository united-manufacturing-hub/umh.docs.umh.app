---
title: "OPCUA Simulator"
content_type: microservices
description: |
    The technical documentation of the opcua-simulator microservice,
    which simulates OPCUA devices.
weight: 0
---

<!-- overview -->

<!-- body -->

## {{% heading "kuberesources" %}}

- Deployment: `{{< resource type="deployment" name="opcuasimulator" >}}`
- Service:
  - External LoadBalancer: `{{< resource type="service" name="opcuasimulator" >}}` at
    port 46010
- ConfigMap: `{{< resource type="configmap" name="opcuasimulator" >}}`

## {{% heading "configuration" %}}

You can change the configuration of the microservice by updating the `config.json`
file in the ConfigMap.
