---
title: "Tulip Connector"
content_type: concept
# description: |
#     Add a description of the concept here.
weight: 10
aliases:
  - /docs/architecture/microservices/community/tulip-connector/
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

<!-- body -->

## {{% heading "howitworks" %}}

The tulip-connector acts as a proxy between the internet and the UMH. It
exposes an endpoint to forward requests to the UMH and returns the response.

<!-- Optional section; add links to information related to this topic. -->

## {{% heading "whatsnext" %}}

- Read the [Tulip Connector](/docs/reference/microservices/tulip-connector/) reference
  documentation to learn more about the technical details of the Tulip Connector
  microservice.
