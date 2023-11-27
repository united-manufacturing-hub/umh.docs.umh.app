---
title: "Node-RED"
content_type: microservices
description: |
    The technical documentation of the nodered microservice,
    which wires together hardware devices, APIs and online services.
weight: 0
aliases:
  - /docs/architecture/microservices/core/node-reD/
---

<!-- overview -->

[Node-RED](https://nodered.org/) is a programming tool for wiring together
hardware devices, APIs and online services in new and interesting ways. It
provides a browser-based editor that makes it easy to wire together flows using
the wide range of nodes in the Node-RED library.

## {{% heading "howitworks" %}}

Node-RED is a JavaScript-based tool that can be used to create flows that
interact with the other microservices in the United Manufacturing Hub or
external services.

See our [guides for Node-RED](https://learn.umh.app/topic/node-red/) to learn
more about how to use it.

<!-- body -->

## {{% heading "kuberesources" %}}

- StatefulSet: `{{< resource type="statefulset" name="nodered" >}}`
- Service:
  - External LoadBalancer: `{{< resource type="service" name="nodered" >}}` at
    port 1880
- ConfigMap:
  - Configuration: `{{< resource type="configmap" name="nodered-config" >}}`
  - Flows: `{{< resource type="configmap" name="nodered-flows" >}}`
- Secret: `{{< resource type="secret" name="nodered" >}}`
- PersistentVolumeClaim: `{{< resource type="pvc" name="nodered" >}}`

## {{% heading "configuration" %}}

You can enable the nodered microservice and decide if you want to use the
default flows in the [`_000_commonConfig.dataprocessing.nodered`](/docs/architecture/helm-chart/#node-red)
section of the Helm chart values.

All the other values are set by default and you can find them in the
Danger Zone section of the Helm chart values.

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name               | Description                                      | Type    | Allowed values  | Default       |
| --------------------------- | ------------------------------------------------ | ------- | --------------- | ------------- |
| `NODE_RED_ENABLE_SAFE_MODE` | Enable safe mode, useful in case of broken flows | boolean | `true`, `false` | `false`       |
| `TZ`                        | The timezone used by Node-RED                    | string  | Any             | Berlin/Europe |
{{< /table >}}
