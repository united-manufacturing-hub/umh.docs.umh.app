---
title: "Node-RED"
content_type: reference
description: |
    The technical documentation of the nodered microservice,
    which wires together hardware devices, APIs and online services.
weight: 0
---

<!-- overview -->

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
