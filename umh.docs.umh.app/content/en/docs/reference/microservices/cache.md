---
title: "Cache"
content_type: reference
description: |
    The technical documentation of the redis microservice,
    which is used as a cache for the other microservices.
weight: 0
---

<!-- overview -->

<!-- body -->

## {{% heading "kuberesources" %}}

- StatefulSet: `{{< resource type="statefulset" name="cache" >}}`
- Service:
  - Internal ClusterIP:
    - Redis: `{{< resource type="service" name="cache" >}}` at
      port 6379
    - Headless: `{{< resource type="service" name="cache-headless" >}}` at
      port 6379
    - Metrics: `{{< resource type="service" name="cache-metrics" >}}` at
      port 6379
- ConfigMap:
  - Configuration: `{{< resource type="configmap" name="cache-config" >}}`
  - Health: `{{< resource type="configmap" name="cache-health" >}}`
  - Scripts: `{{< resource type="configmap" name="cache-scripts" >}}`
- Secret: `{{< resource type="secret" name="cache" >}}`
- PersistentVolumeClaim: `{{< resource type="pvc" name="cache" >}}`

## {{% heading "configuration" %}}

You shouldn't need to configure the cache manually, as it's configured
automatically when the cluster is deployed. However, if you need to change the
configuration, you can do it by editing the `redis` section of the Helm
chart values file.

You can consult the [Bitnami Redis chart](https://github.com/bitnami/charts/tree/main/bitnami/redis#configuration-and-installation-details)
for more information about the available configuration options.

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name            | Description                           | Type   | Allowed values    | Default       |
| ------------------------ | ------------------------------------- | ------ | ----------------- | ------------- |
| `ALLOW_EMPTY_PASSWORD`   | Allow empty password                  | `bool` | `true`, `false`   | `false`       |
| `BITNAMI_DEBUG`          | Specify if debug values should be set | `bool` | `true`, `false`   | `false`       |
| `REDIS_PASSWORD`         | Redis password                        | string | Any               | _Random UUID_ |
| `REDIS_PORT`             | Redis port number                     | int    | Any               | 6379          |
| `REDIS_REPLICATION_MODE` | Redis replication mode                | string | `master`, `slave` | `master`      |
| `REDIS_TLS_ENABLED`      | Enable TLS                            | `bool` | `true`, `false`   | `false`       |
{{< /table >}}
