---
title: "{{ replace .Name "-" " " | title }}"
content_type: reference
description: |
    The technical documentation of the {{ .Name }} microservice
weight: 0
---
<!-- list all the kubernetes workloads associated to the microservice -->
<!-- remember to also update the i18n/en.toml file with the resource definition -->
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

<!-- explain how to properly configure the microservice -->
## {{% heading "configuration" %}}

<!-- list all the available environment variables -->
### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name | Description | Type | Allowed values | Default |
| ------------- | ----------- | ---- | -------------- | ------- |
{{< /table >}}
