---
title: "Grafana"
content_type: concept
# description: |
#     Add a description of the concept here.
weight: 10
---

<!-- overview -->

The grafana microservice is a web application that provides visualization and
analytics capabilities. Grafana allows you to query, visualize, alert on and
understand your metrics no matter where they are stored.

It has a rich ecosystem of plugins that allow you to extend its functionality
beyond the core features.

<!-- body -->

## {{% heading "howitworks" %}}

Grafana is a web application that can be accessed through a web browser. It
let's you create dashboards that can be used to visualize data from the database.

Thanks to some custom [datasource plugins](/docs/architecture/microservices/grafana-plugins/),
Grafana can use the various APIs of the United Manufacturing Hub to query the
database and display useful information.

<!-- Optional section; add links to information related to this topic. -->

## {{% heading "whatsnext" %}}

- Read the [Grafana](/docs/reference/microservices/grafana/) reference documentation
  to learn more about the technical details of the grafana microservice.
