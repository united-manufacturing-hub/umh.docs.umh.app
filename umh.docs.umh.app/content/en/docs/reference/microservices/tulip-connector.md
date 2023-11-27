---
title: "Tulip Connector"
content_type: reference
description: |
    The technical documentation of the tulip-connector microservice,
    which exposes internal APIs, such as factoryinsight, to the internet.
    Specifically designed to communicate with Tulip.
weight: 0
---

<!-- overview -->

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

## API documentation

{{< swaggerui src="/openapi/tulip-connector.yaml" >}}
