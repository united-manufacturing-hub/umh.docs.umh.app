---
title: "Cache"
content_type: concept
# description: |
#     Add a description of the concept here.
weight: 10
aliases:
  - /docs/architecture/microservices/core/cache/
---

<!-- overview -->

The cache in the United Manufacturing Hub is [Redis](https://redis.io/), a
key-value store that is used as a cache for the other microservices.

<!-- body -->

## {{% heading "howitworks" %}}

Recently used data is stored in the cache to reduce the load on the database.
All the microservices that need to access the database will first check if the
data is available in the cache. If it is, it will be used, otherwise the
microservice will query the database and store the result in the cache.

By default, Redis is configured to run in standalone mode, which means that it
will only have one master node.

<!-- Optional section; add links to information related to this topic. -->

## {{% heading "whatsnext" %}}

- Read the [Cache](/docs/reference/microservices/cache/) reference documentation
  to learn more about the technical details of the cache microservice.
