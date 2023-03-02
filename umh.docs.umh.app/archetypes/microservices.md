---
title: "{{ replace .Name "-" " " | title }}"
content_type: microservices
description: |
    TODO
weight: 10
---

## {{% heading "howitworks" %}}

<!-- body -->

## {{% heading "kuberesources" %}}

- Deployment: `{{< resource type="" name="" >}}`
- StatefulSet: `{{< resource type="" name="" >}}`
- Service:
  - Internal ClusterIP: `{{< resource type="" name="" >}}` at
    port 80
  - External LoadBalancer: `{{< resource type="" name="" >}}` at
    port 80
- ConfigMap: `{{< resource type="" name="" >}}`
- Secret: `{{< resource type="" name="" >}}`
- PersistentVolumeClaim: `{{< resource type="" name="" >}}`

## {{% heading "configuration" %}}

### {{% heading "envvars" %}}
