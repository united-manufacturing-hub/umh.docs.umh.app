---
title: "Factoryinput"
content_type: concept
# description: |
#     Add a description of the concept here.
weight: 10
aliases:
  - /docs/architecture/microservices/community/factoryinput/
---

<!-- overview -->

{{% notice warning %}}
This microservice is still in development and is not considered stable for production use
{{% /notice %}}

Factoryinput provides REST endpoints for MQTT messages via HTTP requests.

This microservice is typically accessed via [grafana-proxy](/docs/architecture/microservices/community/grafana-proxy)

<!-- body -->

## {{% heading "howitworks" %}}

The factoryinput microservice provides REST endpoints for MQTT messages via HTTP requests.

The main endpoint is `/api/v1/{customer}/{location}/{asset}/{value}`, with a POST
request method. The customer, location, asset and value are all strings. And are
used to build the MQTT topic. The body of the HTTP request is used as the MQTT
payload.

<!-- Optional section; add links to information related to this topic. -->

## {{% heading "whatsnext" %}}

- Read the [Factoryinput](/docs/reference/microservices/factoryinput/) reference
  documentation to learn more about the technical details of the Factoryinput
  microservice.
