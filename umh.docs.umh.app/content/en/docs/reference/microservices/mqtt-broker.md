---
title: "MQTT Broker"
content_type: microservices
description: |
    The technical documentation of the mqtt-broker microservice,
    which forwards MQTT messages between the other microservices.
weight: 0
---

<!-- overview -->

<!-- body -->

## {{% heading "kuberesources" %}}

- StatefulSet: `{{< resource type="statefulset" name="mqttbroker" >}}`
- Service:
  - Internal ClusterIP:
    - HiveMQ local: `{{< resource type="service" name="mqttbroker-hivemq-local" >}}` at
      port 1883 (MQTT) and 8883 (MQTT over TLS)
    - VerneMQ (for backwards compatibility): `{{< resource type="service" name="mqttbroker-verne" >}}` at
      port 1883 (MQTT) and 8883 (MQTT over TLS)
    - VerneMQ local (for backwards compatibility): `{{< resource type="service" name="mqttbroker-verne-local" >}}` at
      port 1883 (MQTT) and 8883 (MQTT over TLS)
  - External LoadBalancer: `{{< resource type="service" name="mqttbroker" >}}` at
    port 1883 (MQTT) and 8883 (MQTT over TLS)
- ConfigMap:
  - Configuration: `{{< resource type="configmap" name="mqttbroker-config" >}}`
  - Credentials: `{{< resource type="configmap" name="mqttbroker-credentials" >}}`
- Secret: `{{< resource type="secret" name="mqttbroker-keystore" >}}`
- PersistentVolumeClaim:
  - Data: `{{< resource type="pvc" name="mqttbroker-data" >}}`
  - Extensions: `{{< resource type="pvc" name="mqttbroker-extensions" >}}`

## {{% heading "configuration" %}}

Most of the configuration is done through the XML files in the ConfigMaps.
The default configuration should be sufficient for most use cases.

The HiveMQ installation of the United Manufacturing Hub comes with these extensions:

- [RBAC file extension](https://www.hivemq.com/extension/file-rbac-extension/)
  to manage the authentication and authorizations rules for the broker.
- [Prometheus extension](https://www.hivemq.com/extension/prometheus-extension/)
  to expose metrics for a prometheus applications
- [Heartbeat extension](https://www.hivemq.com/extension/heartbeat-extension/)
  to allow for readiness checks

If you want to add more extensions, or to change the configuration, visit
the [HiveMQ documentation](https://www.hivemq.com/docs/hivemq/3.4/user-guide/configuration.html#mqtt-configuration-persistence-chapter).

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name              | Description                                           | Type   | Allowed values  | Default |
| -------------------------- | ----------------------------------------------------- | ------ | --------------- | ------- |
| `HIVEMQ_ALLOW_ALL_CLIENTS` | Whether to allow all clients to connect to the broker | `bool` | `true`, `false` | `true`  |
{{< /table >}}
