---
title: "Grafana Proxy"
content_type: concept
# description: |
#     Add a description of the concept here.
weight: 10
aliases:
  - /docs/architecture/microservices/community/grafana-proxy/
---

<!-- overview -->

{{% notice warning %}}
This microservice is still in development and is not considered stable for production use
{{% /notice %}}

<!-- body -->

## {{% heading "howitworks" %}}

The grafana-proxy microservice serves an HTTP REST endpoint located at
`/api/v1/{service}/{data}`. The `service` parameter specifies the backend
service to which the request should be proxied, like factoryinput or
factoryinsight. The `data` parameter specifies the API endpoint to forward to
the backend service. The body of the HTTP request is used as the payload for
the proxied request.

<!-- Optional section; add links to information related to this topic. -->

## {{% heading "whatsnext" %}}

- Read the [Grafana Proxy](/docs/reference/microservices/grafana-proxy/) reference
  documentation to learn more about the technical details of the Grafana Proxy
  microservice.
