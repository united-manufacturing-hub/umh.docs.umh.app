---
title: "PackML Simulator"
content_type: concept
# description: |
#     Add a description of the concept here.
weight: 10
---

<!-- overview -->

{{% notice warning %}}
This microservice is a community contribution and is not part of the main stack of the United Manufacturing Hub, but it is enabled by default.
{{% /notice %}}

PackML MQTT Simulator is a virtual line that interfaces using PackML implemented
over MQTT. It implements the following PackML State model and communicates
over MQTT topics as defined by environmental variables. The simulator can run
with either a basic MQTT topic structure or SparkPlugB.

![PackML StateModel](/images/microservices-community/PackML-StateModel.png)

<!-- body -->

## {{% heading "howitworks" %}}

You can read the full documentation on the
[GitHub repository](https://github.com/Spruik/PackML-MQTT-Simulator).

<!-- Optional section; add links to information related to this topic. -->

## {{% heading "whatsnext" %}}

- Read the [PackML Simulator](/docs/reference/microservices/packml-simulator/) reference
  documentation to learn more about the technical details of the PackML Simulator
  microservice.
