---
title: "tulip-connector"
content_type: task
description: |
    The technical documentation of the microservice tulip-connector, which exposes internal APIs such as factoryinsight to the internet. Specifically designed to communicate with Tulip.
weight: 10000
---

{{% notice warning %}}
This microservice is still in development and is not considered stable for production use.
{{% /notice %}}

## How it works

The tulip-connector microservice exposes internal APIs, such as [`factoryinsight`](https://learn.umh.app/docs/core/factoryinsight/), to the internet for use with Tulip. It provides a REST endpoint that allows accessing data stored in the United Manufacturing Hub, making it easy to connect [Tulip](https://tulip.co/) with a Unified Namespace and on-premise Historian. Additionally, the tulip-connector allows the UMH to be easily tailored to customer needs, such as connecting to an on-premise MES system.

## Kubernetes resources

To get started with the tulip-connector, you will need to edit the `values.yaml` file to enable the service and provide a valid domain. By default, the tulip-connector is disabled.

```yaml
_000_commonConfig:
 tulipconnector:
  enabled: false
  domain: "your.domain.here"
```

Once the service is enabled, you can access it via HTTPS at the provided domain.

## Configuration

### Environment variables
The tulip-connector microservice can be configured using the following environment variables:

| Variable name |                              Description                              |  Type  | Possible values | Default value |
| :------------ | :-------------------------------------------------------------------: | :----: | :-------------: | ------------: |
| MODE          | The mode that the service will run in. Change only during development | string |    dev, prod    |          prod |

### Endpoints

The tulip-connector microservice provides the following endpoints:

{{< swaggerui src="/openapi/tulip-connector.yaml" >}}
