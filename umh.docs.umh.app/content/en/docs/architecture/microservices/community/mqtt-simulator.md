---
title: "Mqtt Simulator"
content_type: concept
# description: |
#     Add a description of the concept here.
weight: 10
---

<!-- overview -->

{{% notice warning %}}
This microservice is a community contribution and is not part of the main stack of the United Manufacturing Hub, but is enabled by default.
{{% /notice %}}

The IoTSensors MQTT Simulator is a microservice that simulates sensors sending data to the
MQTT broker. You can read the full documentation on the

[GitHub repository](https://github.com/amine-amaach/simulators/tree/main/ioTSensorsMQTT).

<!-- body -->

## {{% heading "howitworks" %}}

The microservice publishes messages on the topic `ia/raw/development/ioTSensors/`,
creating a subtopic for each simulation. The subtopics are the names of the
simulations, which are `Temperature`, `Humidity`, and `Pressure`.
The values are calculated using a normal distribution with a mean and standard
deviation that can be configured.

<!-- Optional section; add links to information related to this topic. -->

## {{% heading "whatsnext" %}}

- Read the [IoTSensors MQTT Simulator](/docs/reference/microservices/mqtt-simulator/) reference
  documentation to learn more about the technical details of the IoTSensors MQTT Simulator
  microservice.
