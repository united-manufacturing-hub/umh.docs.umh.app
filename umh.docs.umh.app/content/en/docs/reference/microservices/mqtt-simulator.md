---
title: "MQTT Simulator"
content_type: reference
description: |
    The technical documentation of the iotsensorsmqtt microservice,
    which simulates sensors sending data to the MQTT broker.
weight: 0
---

<!-- overview -->

<!-- body -->

## {{% heading "kuberesources" %}}

- Deployment: `{{< resource type="deployment" name="mqttsimulator" >}}`
- ConfigMap: `{{< resource type="configmap" name="mqttsimulator" >}}`

## {{% heading "configuration" %}}

You can change the configuration of the microservice by updating the `config.json`
file in the ConfigMap.
