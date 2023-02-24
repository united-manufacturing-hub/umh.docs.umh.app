---
title: "Connect to Mqtt Broker"
content_type: task
description: |
  This page describes how to connect to the United Manufacturing Hub MQTT broker.
weight: 12
version: 0.9.10
---

<!-- overview -->

You might want to connect to the MQTT broker to publish or subscribe to topics,
or to inspect the messages that are being published to the broker.

There are two different ways to connect to the MQTT broker, depending on where
your client is running. If your client is running inside the Kubernetes cluster,
e.g. Node-RED, you can use the MQTT broker service name as the hostname. If your
client is running outside the Kubernetes cluster, e.g. a desktop application like
MQTT Explorer, you need to use the external IP address of the MQTT broker.

## {{% heading "prerequisites" %}}

{{< include "task-tutorial-prereqs.md" >}}

{{< notice note >}}
The MQTT service name has changed after version 0.9.10. If you are using an older
version, use <code>{{< resource type="service" name="mqtt-verne" >}}</code> instead of
<code>{{< resource type="service" name="mqtt" >}}</code>.
{{< /notice >}}

{{< version-check >}}

<!-- steps -->

## Connect to the MQTT broker from inside the Kubernetes cluster

To connect to the MQTT broker from inside the Kubernetes cluster, use the MQTT
broker service name as the hostname. The MQTT broker service name is
`{{< resource type="service" name="mqtt" >}}`, and the port is 1883.

## Connect to the MQTT broker from outside the Kubernetes cluster

By default, the MQTT broker does not have an external IP address. To enable it,
open {{< resource type="lens" name="name" >}} and go to the **Services** page. Find the `{{< resource type="service" name="mqtt" >}}`
Service and click the **Edit** button. Scroll down to the `status.loadBalancer`
section and change it to the following:

```yaml
status:
  loadBalancer:
    ingress:
    - ip: <external-ip>
```

Replace `<external-ip>` with the external IP address of the node. Then scroll to
the `spec.type` section and change it from ClusterIp to LoadBalancer. Click
**Save** to apply the changes.

Now you can connect to the MQTT broker from outside the Kubernetes cluster using
the external IP address of the node as the hostname. The port is 1883.

<!-- discussion -->

## Security considerations

TODO

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}
