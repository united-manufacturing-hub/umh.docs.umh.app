---
title: "Access the MQTT Broker Outside the Cluster"
content_type: task
description: |
  This page describes how to access the MQTT Broker from outside the cluster.
weight: 20
---

<!-- overview -->

By default the MQTT Broker is only available from within the cluster, therefore
you cannot access it from external applications.

You can enable external access from the MQTT Broker configuration.

## {{% heading "prerequisites" %}}

{{< include "task-tutorial-prereqs.md" >}}

<!-- steps -->

## Enable external access from MQTT Broker configuration

1. From {{< resource type="lens" name="name" >}}, go to **Network** > **Services**.
2. Find the `{{< resource type="service" name="mqtt" >}}` Service.
   {{< notice note >}}
   The MQTT service name has changed since version 0.9.10. If you are using an older
   version, use <code>{{< resource type="service" name="mqtt-verne" >}}</code> instead of
   <code>{{< resource type="service" name="mqtt" >}}</code>.
   {{< /notice >}}
3. Click the **Edit** button.
4. Scroll down to the `status.loadBalancer` section and change it to the following:

   ```yaml
   status:
     loadBalancer:
       ingress:
       - ip: <external-ip>
   ```

   Replace `<external-ip>` with the external IP address of the node.
5. Scroll to the `spec.type` section and change the value from ClusterIp to LoadBalancer.
6. Click **Save** to apply the changes.

Now you can connect to the MQTT broker from outside the Kubernetes cluster using
the external IP address of the node as the hostname. The port is 1883.

<!-- discussion -->

## Security considerations

TODO

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- See [Access Kafka Outside the Cluster](/docs/administration/access-kafka-outside-cluster)
- See [Access Factoryinsight Outside the Cluster](/docs/administration/access-factoryinsight-outside-cluster)
- See [Access Services from Within the Cluster](/docs/administration/access-services-from-cluster)
