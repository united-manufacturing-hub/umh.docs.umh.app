---
title: "{{ replace .Name "-" " " | title }}"
content_type: microservices
description: |
    The technical documentation of the {{ .Name }} microservice,
    which
weight: 0
---

<!-- overview -->

<!-- body -->

## {{% heading "howitworks" %}}

## {{% heading "kuberesources" %}}

- Deployment: `{{< resource type="deployment" name="" >}}`
- StatefulSet: `{{< resource type="statefulset" name="" >}}`
- Service:
  - Internal ClusterIP: `{{< resource type="service" name="" >}}` at
    port 80
  - External LoadBalancer: `{{< resource type="service" name="" >}}` at
    port 80
- ConfigMap: `{{< resource type="configmap" name="" >}}`
- Secret: `{{< resource type="secret" name="" >}}`
- PersistentVolumeClaim: `{{< resource type="pvc" name="" >}}`

## {{% heading "configuration" %}}

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name | Description | Type | Allowed values | Default |
| ------------- | ----------- | ---- | -------------- | ------- |
{{< /table >}}
