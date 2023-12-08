---
title: "Factoryinsight"
content_type: concept
# description: |
#     Add a description of the concept here.
weight: 10
aliases:
  - /docs/architecture/microservices/core/factoryinsight/
---

<!-- overview -->

Factoryinsight is a microservice that provides a set of REST APIs to access the
data from the database. It is particularly useful to calculate the Key
Performance Indicators (KPIs) of the factories.

<!-- body -->

## {{% heading "howitworks" %}}

Factoryinsight exposes REST APIs to access the data from the database or calculate
the KPIs. By default, it's only accessible from the internal network of the
cluster, but it can be configured to be
[accessible from the external network](/docs/production-guide/administration/access-factoryinsight-outside-cluster/).

The APIs require authentication, that can be either a Basic Auth or a Bearer
token. Both of these can be found in the Secret `{{< resource type="secret" name="factoryinsight" >}}`.

<!-- Optional section; add links to information related to this topic. -->

## {{% heading "whatsnext" %}}

- Read the [Factoryinsight](/docs/reference/microservices/factoryinsight/) reference documentation
  to learn more about the technical details of the Factoryinsight microservice.
