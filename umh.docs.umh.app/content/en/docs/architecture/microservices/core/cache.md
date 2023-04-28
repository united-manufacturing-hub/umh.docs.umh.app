---
title: "Cache"
content_type: microservices
description: |
    The technical documentation of the redis microservice,
    which is used as a cache for the other microservices.
weight: 0
---

<!-- overview -->

The cache in the United Manufacturing Hub is [Redis](https://redis.io/), a
key-value store that is used as a cache for the other microservices.

## {{% heading "howitworks" %}}

Recently used data is stored in the cache to reduce the load on the database.
All the microservices that need to access the database will first check if the
data is available in the cache. If it is, it will be used, otherwise the
microservice will query the database and store the result in the cache.

By default, Redis is configured to run in standalone mode, which means that it
will only have one master node.

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
