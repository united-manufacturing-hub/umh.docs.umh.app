---
title: "Access Services From Within the Cluster"
content_type: task
description: |
  This page describes how to access services from within the cluster.
weight: 20
---

<!-- overview -->

All the services deployed in the cluster are visible to each other. That makes it
easy to connect them together.

## {{% heading "prerequisites" %}}

{{< include "task-aftinst-prereqs.md" >}}

<!-- steps -->

## Connect to a service from another service

To connect to a service from another service, you can use the service name as the
host name.

{{< include "service-list.md" >}}

<!-- discussion -->

## Example

The most common use case is to connect to the MQTT Broker from Node-RED.

To do that, when you create the MQTT node, you can use the service name
{{< resource type="service" name="mqttbroker" >}} as the host name and one the ports
listed in the **Ports** column.

{{% notice note %}}
The MQTT service name has changed since version 0.9.10. If you are using an older
version, use `{{< resource type="service" name="mqttbroker-verne" >}}` instead of
`{{< resource type="service" name="mqttbroker" >}}`.
{{< /notice >}}

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- See [Access the MQTT Broker Outside the Cluster](/docs/production-guide/administration/access-mqtt-outside-cluster)
- See [Access Factoryinsight Outside the Cluster](/docs/production-guide/administration/access-factoryinsight-outside-cluster)
- See [Access Kafka Outside the Cluster](/docs/production-guide/administration/access-kafka-outside-cluster)
