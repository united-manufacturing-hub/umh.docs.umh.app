---
title: "PackML Simulator"
content_type: reference
description: |
    The technical documentation of the packml-simulator microservice,
    which simulates a manufacturing line using PackML over MQTT.
weight: 0
---

<!-- overview -->

<!-- body -->

## {{% heading "kuberesources" %}}

- Deployment: `{{< resource type="deployment" name="packmlsimulator" >}}`

## {{% heading "configuration" %}}

You shouldn't need to configure PackML Simulator manually, as it's configured
automatically when the cluster is deployed. However, if you need to change the
configuration, you can do it by editing the `packmlmqttsimulator` section of the
Helm chart values file.

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name   | Description                                                                         | Type   | Allowed values | Default                                                       |
| --------------- | ----------------------------------------------------------------------------------- | ------ | -------------- | ------------------------------------------------------------- |
| `AREA`          | ISA-95 area name of the line                                                        | string | Any            | DefaultArea                                                   |
| `LINE`          | ISA-95 line name of the line                                                        | string | Any            | DefaultProductionLine                                         |
| `MQTT_PASSWORD` | Password for the MQTT broker. Leave empty if the server does not manage permissions | string | Any            | INSECURE_INSECURE_INSECURE                                    |
| `MQTT_URL`      | Server URL of the MQTT server                                                       | string | Any            | mqtt://{{< resource type="service" name="mqttbroker" >}}:1883 |
| `MQTT_USERNAME` | Name for the MQTT broker. Leave empty if the server does not manage permissions     | string | Any            | PACKMLSIMULATOR                                               |
| `SITE`          | ISA-95 site name of the line                                                        | string | Any            | testLocation                                                  |
{{< /table >}}
