---
title: "Tulip Connector"
content_type: microservices
description: |
    The technical documentation of the tulip-connector microservice,
    which exposes internal APIs, such as factoryinsight, to the internet.
    Specifically designed to communicate with Tulip.
weight: 0
---

<!-- overview -->

{{% notice warning %}}
This microservice is still in development and is not considered stable for production use.
{{% /notice %}}

The tulip-connector microservice enables communication with the United
Manufacturing Hub by exposing internal APIs, like
[`factoryinsight`](/docs/architecture/microservices/core/factoryinsight), to the
internet. With this REST endpoint, users can access data stored in the UMH and
seamlessly integrate Tulip with a Unified Namespace and on-premise Historian.
Furthermore, the tulip-connector can be customized to meet specific customer
requirements, including integration with an on-premise MES system.

## {{% heading "howitworks" %}}

The tulip-connector acts as a proxy between the internet and the UMH. It
exposes an endpoint to forward requests to the UMH and returns the response.

### API documentation

{{< swaggerui src="/openapi/tulip-connector.yaml" >}}

<!-- body -->

## {{% heading "kuberesources" %}}

- Deployment: `{{< resource type="deployment" name="tulipconnector" >}}`
- Service:
  - Internal ClusterIP: `{{< resource type="service" name="tulipconnector" >}}` at
    port 80
- Ingress: `{{< resource type="ingress" name="tulipconnector" >}}`

## {{% heading "configuration" %}}

You can enable the tulip-connector and set the domain for the ingress by editing
the values in the [`_000_commonConfig.tulipconnector`](/docs/architecture/helm-chart/#tulip-connector)
section of the Helm chart values file.

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name             | Description                                                                     | Type   | Allowed values | Default                                                        |
| ------------------------- | ------------------------------------------------------------------------------- | ------ | -------------- | -------------------------------------------------------------- |
| `FACTORYINSIGHT_PASSWORD` | Specifies the password for the admin user for the REST API                      | string | Any            | _Random UUID_                                                  |
| `FACTORYINSIGHT_URL`      | Specifies the URL of the factoryinsight microservice.                           | string | Any            | `http://{{< resource type="service" name="factoryinsight" >}}` |
| `FACTORYINSIGHT_USER`     | Specifies the admin user for the REST API                                       | string | Any            | factoryinsight                                                 |
| `MODE`                    | Specifies the mode that the service will run in. Change only during development | string | dev, prod      | prod                                                           |
{{< /table >}}
