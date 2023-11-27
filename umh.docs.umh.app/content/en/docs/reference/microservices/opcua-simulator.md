---
title: "OPCUA Simulator"
content_type: microservices
description: |
    The technical documentation of the opcua-simulator microservice,
    which simulates OPCUA devices.
weight: 0
aliases:
  - /docs/architecture/microservices/community/opcua-simulator/
---

<!-- overview -->

{{% notice warning %}}
This microservice is a community contribution and is not part of the main stack of the United Manufacturing Hub, but is enabled by default.
{{% /notice %}}

## {{% heading "howitworks" %}}

The OPCUA Simulator is a microservice that simulates OPCUA devices. You can read
the full documentation on the
[GitHub repository](https://github.com/amine-amaach/simulators/tree/main/ioTSensorsOPCUA).

You can then connect to the simulated OPCUA server via Node-RED and read the
values of the simulated devices. Learn more about how to connect to the OPCUA
simulator to Node-RED in [our guide](https://learn.umh.app/course/creating-a-node-red-flow-with-simulated-opc-ua-data/).

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
