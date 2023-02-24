---
title: "Access Kafka Outside the Cluster"
content_type: task
description: |
  This page describes how to access Kafka from outside the cluster.
weight: 50
---

<!-- overview -->

By default the Kafka broker is only available from within the cluster, therefore
you cannot access it from external applications.

You can create a LoadBalancer service to expose it from the host.

## {{% heading "prerequisites" %}}

{{< include "task-tutorial-prereqs.md" >}}

<!-- steps -->

## Enable external access from Kafka configuration

1. From {{< resource type="lens" name="name" >}}, go to **Helm** > **Releases**.
2. Click on the **Upgrade** button.
3. Search for the `kafka` section and edit the following values:

   ```yaml
   ...
   kafka:
   ...
     externalAccess:
       autoDiscovery:
         enabled: true
       ...
       enabled: true
     ...
     rbac:
       create: true
   ...
   ```

4. Click **Upgrade**.

To verify that the LoadBalancer service is created, go to **Network** > **Services**
and search for {{< resource type="service" name="kafka-ext" >}}.

Now you can connect to Kafka from external applications using the node IP and
the port 9094.
<!-- discussion -->

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}