---
title: "MQTT Simulator"
content_type: microservices
description: |
    The technical documentation of the iotsensorsmqtt microservice,
    which simulates sensors sending data to the MQTT broker.
weight: 0
aliases:
  - /docs/architecture/microservices/community/mqtt-simulator/
---

<!-- overview -->

{{% notice warning %}}
This microservice is a community contribution and is not part of the main stack of the United Manufacturing Hub, but is enabled by default.
{{% /notice %}}

The IoTSensors MQTT Simulator is a microservice that simulates sensors sending data to the
MQTT broker. You can read the full documentation on the

[GitHub repository](https://github.com/amine-amaach/simulators/tree/main/ioTSensorsMQTT).

## {{% heading "howitworks" %}}

The microservice publishes messages on the topic `ia/raw/development/ioTSensors/`,
creating a subtopic for each simulation. The subtopics are the names of the
simulations, which are `Temperature`, `Humidity`, and `Pressure`.
The values are calculated using a normal distribution with a mean and standard
deviation that can be configured.

<!-- body -->

## {{% heading "kuberesources" %}}

- Deployment: `{{< resource type="deployment" name="mqttsimulator" >}}`
- ConfigMap: `{{< resource type="configmap" name="mqttsimulator" >}}`

## {{% heading "configuration" %}}

You can change the configuration of the microservice by updating the `config.json`
file in the ConfigMap.
