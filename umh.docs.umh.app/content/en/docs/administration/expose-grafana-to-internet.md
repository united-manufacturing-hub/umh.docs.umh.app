---
title: "Expose Grafana to the Internet"
content_type: task
description: |
  This page describes how to expose Grafana to the Internet.
weight: 21
---

<!-- overview -->

This page describes how to expose Grafana to the Internet so that you can access
it from outside the Kubernetes cluster.

## {{% heading "prerequisites" %}}

{{< include "task-tutorial-prereqs.md" >}}

<!-- steps -->

## Enable the ingress

To expose Grafana to the Internet, you need to enable the ingress.

1. Open {{< resource type="lens" name="name" >}} and go to the **Helm** > **Releases**
page.
2. Click the **Upgrade** button and search for Grafana.
3. Scroll down to the `ingress` section
4. Set the `enabled` field to `true`.
5. Add you domain name to the `hosts` field.
6. Click **Upgrade** to apply the changes.

Remember to add a DNS record for your domain name that points to the external IP
address of the Kubernetes host. You can find the external IP address of the
Kubernetes host on the **Nodes** page in {{< resource type="lens" name="name" >}}.

<!-- discussion -->

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- See how to [Access Factoryinsight Outside the Cluster](/docs/administration/access-factoryinsight-outside-cluster/)
