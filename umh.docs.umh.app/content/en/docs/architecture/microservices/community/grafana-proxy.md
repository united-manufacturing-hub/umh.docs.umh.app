---
title: "Grafana Proxy"
content_type: microservices
description: |
    The technical documentation of the grafana-proxy microservice,
    which proxies request from Grafana to the backend services.
weight: 0
---

<!-- overview -->

{{% notice warning %}}
This microservice is still in development and is not considered stable for production use
{{% /notice %}}

## {{% heading "howitworks" %}}

The grafana-proxy microservice serves an HTTP REST endpoint located at
`/api/v1/{service}/{data}`. The `service` parameter specifies the backend
service to which the request should be proxied, like factoryinput or
factoryinsight. The `data` parameter specifies the API endpoint to forward to
the backend service. The body of the HTTP request is used as the payload for
the proxied request.

<!-- body -->

## {{% heading "kuberesources" %}}

- Deployment: `{{< resource type="deployment" name="grafanaproxy" >}}`
- Service:
  - External LoadBalancer: `{{< resource type="service" name="grafanaproxy" >}}` at
    port 2096

## {{% heading "configuration" %}}

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name             | Description                                                                                                  | Type   | Allowed values          | Default                                                      |
| ------------------------- | ------------------------------------------------------------------------------------------------------------ | ------ | ----------------------- | ------------------------------------------------------------ |
| `DEBUG_ENABLE_FGTRACE`    | Enables the use of the [fgtrace](https://github.com/felixge/fgtrace) library. Not recommended for production | string | `true`, `false`         | `false`                                                      |
| `FACTORYINPUT_BASE_URL`   | URL of factoryinput                                                                                          | string | Any                     | http://{{< resource type="service" name="factoryinput" >}}   |
| `FACTORYINPUT_KEY`        | Specifies the password for the admin user for factoryinput                                                   | string | Any                     | _Random UUID_                                                |
| `FACTORYINPUT_USER`       | Specifies the admin user for factoryinput                                                                    | string | Any                     | factoryinput                                                 |
| `FACTORYINSIGHT_BASE_URL` | URL of factoryinsight                                                                                        | string | Any                     | http://{{< resource type="service" name="factoryinsight" >}} |
| `MICROSERVICE_NAME`       | Name of the microservice. Used for tracing                                                                   | string | Any                     | united-manufacturing-hub-factoryinput                        |
| `SERIAL_NUMBER`           | Serial number of the cluster. Used for tracing                                                               | string | Any                     | default                                                      |
| `VERSION`                 | The version of the API used. Each version also enables all the previous ones                                 | int    | Any                     | 1                                                            |
{{< /table >}}
