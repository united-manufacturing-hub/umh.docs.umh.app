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
   {{% notice note %}}
   The MQTT service name has changed since version 0.9.10. If you are using an older
   version, use `{{< resource type="service" name="mqtt-verne" >}}` instead of
   `{{< resource type="service" name="mqtt" >}}`.
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

There are some security considerations to keep in mind when exposing the MQTT broker.

By default, the MQTT broker is configured to allow anonymous connections. This
means that anyone can connect to the broker without providing any credentials.
This is not recommended for production environments.

To secure the MQTT broker, you can configure it to require authentication. For
that, you can either [enable RBAC](/docs/production-guide/security/hivemq-rbac/)
or [set up HiveMQ PKI](/docs/production-guide/security/hivemq-pki/) (recommended
for production environments).

{{% notice note %}}
If you are using a version of the United Manufacturing Hub older than 0.9.10,
then you need to [change the ACL configuration](/docs/production-guide/security/vernemq-acl/)
to allow your MQTT client to connect to the broker.
{{< /notice >}}

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- See [Access Kafka Outside the Cluster](/docs/administration/access-kafka-outside-cluster)
- See [Access Factoryinsight Outside the Cluster](/docs/administration/access-factoryinsight-outside-cluster)
- See [Access Services from Within the Cluster](/docs/administration/access-services-from-cluster)
