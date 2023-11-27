---
title: "MQTT Bridge"
content_type: microservices
description: |
    The technical documentation of the mqtt-bridge microservice,
    which acts as a communication bridge between two MQTT brokers.
weight: 0
---

<!-- overview -->

<!-- body -->

## {{% heading "kuberesources" %}}

- StatefulSet: `{{< resource type="statefulset" name="mqttbridge" >}}`
- Secret: `{{< resource type="secret" name="mqttbridge" >}}`
- PersistentVolumeClaim: `{{< resource type="pvc" name="mqttbridge" >}}`

## {{% heading "configuration" %}}

You can configure the URL of the remote MQTT broker that MQTT-bridge should
connect to by setting the value of the `remoteBrokerUrl` parameter in the
[`_000_commonConfig.mqttBridge`](/docs/architecture/helm-chart/#mqtt-bridge)
section of the Helm chart values file.

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name                 | Description                                                                            | Type   | Allowed values   | Default                                                           |
| ----------------------------- | -------------------------------------------------------------------------------------- | ------ | ---------------- | ----------------------------------------------------------------- |
| `BRIDGE_ONE_WAY`              | Whether to enable one-way communication, from local to remote                          | `bool` | `true`, `false`  | `true`                                                            |
| `INSECURE_SKIP_VERIFY_LOCAL`  | Skip TLS certificate verification for the local broker                                 | `bool` | `true`, `false`  | `true`                                                            |
| `INSECURE_SKIP_VERIFY_REMOTE` | Skip TLS certificate verification for the remote broker                                | `bool` | `true`, `false`  | `true`                                                            |
| `LOCAL_BROKER_SSL_ENABLED`    | Whether to enable SSL for the local MQTT broker                                        | `bool` | `true`, `false`  | `true`                                                            |
| `LOCAL_BROKER_URL`            | URL for the local MQTT broker                                                          | string | Any              | ssl://{{< resource type="service" name="mqttbroker" >}}:8883      |
| `LOCAL_CERTIFICATE_NAME`      | Set to NO_CERT to allow non-encrypted MQTT access, or to USE_TLS to use TLS encryption | string | USE_TLS, NO_CERT | USE_TLS                                                           |
| `LOCAL_PUB_TOPIC`             | Local MQTT topic to publish to                                                         | string | Any              | ia                                                                |
| `LOCAL_SUB_TOPIC`             | Local MQTT topic to subscribe to                                                       | string | Any              | ia/factoryinsight                                                 |
| `MQTT_PASSWORD`               | Password for the MQTT broker                                                           | string | Any              | INSECURE_INSECURE_INSECURE                                        |
| `REMOTE_BROKER_SSL_ENABLED`   | Whether to enable SSL for the remote MQTT broker                                       | `bool` | `true`, `false`  | `true`                                                            |
| `REMOTE_BROKER_URL`           | URL for the local MQTT broker                                                          | string | Any              | ssl://united-manufacturing-hub-mqtt.united-manufacturing-hub:8883 |
| `REMOTE_CERTIFICATE_NAME`     | Set to NO_CERT to allow non-encrypted MQTT access, or to USE_TLS to use TLS encryption | string | USE_TLS, NO_CERT | USE_TLS                                                           |
| `REMOTE_PUB_TOPIC`            | Remote MQTT topic to publish to                                                        | string | Any              | ia/factoryinsight                                                 |
| `REMOTE_SUB_TOPIC`            | Remote MQTT topic to subscribe to                                                      | string | Any              | ia                                                                |
{{< /table >}}
